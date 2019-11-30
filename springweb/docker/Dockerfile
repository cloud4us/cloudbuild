FROM openjdk:9-jre
LABEL maintainer="cloud4us"
COPY springweb.jar /app/springweb.jar
CMD ["-jar", "/app/springweb.jar"]
VOLUME ["/tmp"]
EXPOSE 443
COPY dependency/BOOT-INF/lib /app/lib
COPY dependency/META-INF /app/META-INF
COPY dependency/BOOT-INF/classes /app
ENTRYPOINT ["java", "-cp", "app:app/lib/*", "com.springweb.SpringwebApplication  "]
