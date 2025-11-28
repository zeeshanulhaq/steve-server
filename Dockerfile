FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY target/steve.war ./steve.war
EXPOSE 8180 8443
CMD java -XX:MaxRAMPercentage=85 -jar steve.war
