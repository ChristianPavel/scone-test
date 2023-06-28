FROM registry.scontain.com/sconecuratedimages/apps:15-jdk-alpine
COPY code.java HelloWorld.java
RUN javac HelloWorld.java
CMD sh -c "SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=TRACE java HelloWorld"