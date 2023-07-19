FROM openjdk:8-jdk-alpine

WORKDIR /swagger-petstore

RUN apk add maven

COPY src/ /swagger-petstore/src
COPY pom.xml /swagger-petstore/pom.xml

RUN mvn --quiet package

#
# copy build assets into run
#
FROM openjdk:8-jre-alpine

WORKDIR /swagger-petstore

COPY src/main/resources/openapi.yaml /swagger-petstore/openapi.yaml
COPY inflector.yaml /swagger-petstore/
COPY --from=0 /swagger-petstore/target/lib/jetty-runner.jar /swagger-petstore/jetty-runner.jar
COPY --from=0 /swagger-petstore/target/*.war /swagger-petstore/server.war

EXPOSE 8080

RUN chown -R 10014 /var/log
USER 10014

CMD ["java", "-jar", "-DswaggerUrl=openapi.yaml", "/swagger-petstore/jetty-runner.jar", "/swagger-petstore/server.war"]
