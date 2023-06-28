# FROM registry.scontain.com/sconecuratedimages/apps:8-jdk-alpine
# FROM registry.scontain.com/sconecuratedimages/apps:11-jdk-alpine
# FROM registry.scontain.com/sconecuratedimages/apps:15-jdk-alpine
FROM registry.scontain.com/sconecuratedimages/apps:17-ea-jdk-alpine
RUN apk update && apk add git
RUN git clone https://github.com/spring-projects/spring-petclinic.git
ENV SCONE_HEAP 4G
ENV SCONE_STACK 2M
ENV SCONE_LOG TRACE
ENV SCONE_VERSION 1
WORKDIR spring-petclinic
# RUN git checkout 1.5.x
CMD sh -c "SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG MAVEN_OPTS=\"-Xmx64m -Xms64m -XX:CompressedClassSpaceSize=64m\" JAVA_TOOL_OPTIONS=\"-Xmx64m -Xms64m -XX:CompressedClassSpaceSize=64m\" ./mvnw package; \
    SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG java -Xmx64m -Xms64m -XX:CompressedClassSpaceSize=64m ./target/*.jar;"