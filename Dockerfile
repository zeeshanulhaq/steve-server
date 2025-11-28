FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
RUN chmod +x mvnw && ./mvnw clean package -Pdocker -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2"
COPY src ./src
RUN ./mvnw package -Pdocker
EXPOSE 8180 8443
CMD java -XX:MaxRAMPercentage=85 -jar target/steve.war
