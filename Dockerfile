# Use OpenJDK 11 as the base image
FROM openjdk:11

# Set the working directory
WORKDIR /usr/src/myproject

# Copy the project files to the container
COPY . /usr/src/myproject

# Run Maven command to package and run the project with Jetty
RUN mvn package jetty:run

# Expose the port on which Jetty is listening
EXPOSE 8080
USER 10002

# Start Jetty server when the container is run
CMD ["mvn", "jetty:run"]


# FROM openjdk:8-jre-alpine

# WORKDIR /swagger-petstore

# COPY target/lib/jetty-runner.jar /swagger-petstore/jetty-runner.jar
# COPY target/*.war /swagger-petstore/server.war
# COPY src/main/resources/openapi.yaml /swagger-petstore/openapi.yaml
# COPY inflector.yaml /swagger-petstore/

# EXPOSE 8080
# USER 10002

# CMD ["java", "-jar", "-DswaggerUrl=openapi.yaml", "/swagger-petstore/jetty-runner.jar", "--log", "/var/log/yyyy_mm_dd-requests.log", "/swagger-petstore/server.war"]
