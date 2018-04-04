FROM openjdk:8

MAINTAINER David Dooling <david@atomist.com>

RUN mkdir -p /opt/app

WORKDIR /opt/app

EXPOSE 8080

ENTRYPOINT ["/usr/bin/java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Xmx256m", "-Djava.security.egd=file:/dev/urandom"]

CMD ["-jar", "spring-boot.jar"]

ARG JAR_FILE

COPY target/$JAR_FILE spring-boot.jar
