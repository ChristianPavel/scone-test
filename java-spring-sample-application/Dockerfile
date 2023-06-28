FROM registry.scontain.com/sconecuratedimages/apps:8-jdk-alpine
RUN apk update && apk add git maven
RUN git clone https://github.com/codecentric/springboot-sample-app.git
ENV SCONE_HEAP 2G
ENV SCONE_STACK 2M
ENV SCONE_LOG TRACE
ENV SCONE_VERSION 1
WORKDIR springboot-sample-app
CMD sh -c "SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG mvn package; \
    SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG java -jar ./target/app.jar;"