# 확실히 Debian/Ubuntu 기반인 이미지 사용
FROM openjdk:21-jdk

WORKDIR /app
COPY build/libs/app.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]