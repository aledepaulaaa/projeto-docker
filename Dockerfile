FROM maven:3.8.4-jdk-17 AS build

# Copia apenas o pom primeiro para aproveitar o cache das dependências
COPY pom.xml /app/
COPY src /app/src/

WORKDIR /app
# Executa o build pulando os testes para ser mais rápido na VM
RUN mvn clean install -DskipTests

FROM eclipse-temurin:17-jre-alpine
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
