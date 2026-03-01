FROM maven:3.8.4-jdk-8 AS build

# Copia apenas o pom primeiro para aproveitar o cache das dependências
COPY pom.xml /app/
COPY src /app/src/

WORKDIR /app
# Executa o build pulando os testes para ser mais rápido na VM
RUN mvn clean install -DskipTests

FROM openjdk:8-jre-alpine

COPY --from=build /app/target/spring-boot-2-hello-world-1.0.2-SNAPSHOT.jar /app/app.jar

WORKDIR /app

EXPOSE 8080

# Corrigido: adicionadas as vírgulas necessárias no JSON array
CMD ["java", "-jar", "app.jar"]