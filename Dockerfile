# Use Eclipse Temurin JDK 21
FROM eclipse-temurin:21-jdk

# Set locale
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

WORKDIR /app

# Copy Maven wrapper and pom.xml first for caching dependencies
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies (cache layer)
RUN chmod +x mvnw && ./mvnw dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Expose ports
EXPOSE 8180
EXPOSE 8443

# Build and run the app
CMD chmod +x mvnw && \
    ./mvnw clean package -Pdocker -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2" && \
    java -XX:MaxRAMPercentage=85 -jar target/steve.war
