FROM alpine:latest AS build
#RUN apk add git maven sed 
RUN apk add git gradle sed 
#RUN git clone --branch dev/mvpbackend https://github.com/ChristianPavel/todo.git
RUN git clone --branch dev/gradleVersion https://github.com/ChristianPavel/todo.git 
WORKDIR todo
RUN  git pull 
#RUN  mvn package -P container
RUN gradle assemble  


 FROM registry.scontain.com/sconecuratedimages/apps:17-ea-jdk-alpine
# FROM alpine:latest

#mvn with build
# RUN apk add git maven sed 
# RUN git clone --branch dev/mvpbackend https://github.com/ChristianPavel/todo.git
# ENV SCONE_HEAP 2G
# ENV SCONE_STACK 2M
# ENV SCONE_LOG TRACE
# ENV SCONE_VERSION 1
# WORKDIR todo
# CMD sh -c "echo 'got here'" ;\ 
#   git pull ;\
#   sh -c "SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG mvn package -P container";\  
#   SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG java -jar ./target/todo-0.0.1-SNAPSHOT.jar 

#gradle with build
# RUN apk add git gradle sed
# RUN git clone --branch dev/gradleVersion https://github.com/ChristianPavel/todo.git 
# ENV SCONE_HEAP 2G
# ENV SCONE_STACK 2M
# ENV SCONE_LOG TRACE
# ENV SCONE_VERSION 1
# WORKDIR todo
# CMD sh -c "echo 'got here'" ;\ 
#   git pull ;\
#   sh -c "SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG gradle assemble --stacktrace" ;\ 
#   SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG java -jar ./build/libs/todo-0.0.1-SNAPSHOT.jar --spring.profiles.active=container


# jar without build
# RUN apk add git maven sed 
# RUN apk add git gradle sed
# RUN git clone https://github.com/ChristianPavel/todoJars.git
COPY --from=build /todo/build/libs/todo-0.0.1-SNAPSHOT.jar /todoJars/todo.jar
#COPY --from=build /todo/target/todo-0.0.1-SNAPSHOT.jar /todoJars/todo.jar
 ENV SCONE_HEAP 2G
 ENV SCONE_STACK 2M
 ENV SCONE_LOG TRACE
 ENV SCONE_VERSION 1
 WORKDIR todoJars
    CMD sh -c "cat /etc/os-release;\
     #SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG java -jar ./todo.jar"
     SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG java -jar ./todo.jar --spring.profiles.active=container"
    #CMD SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG java -jar ./mvntodo-0.0.1-SNAPSHOT.jar
    #CMD SCONE_VERSION=1 SCONE_HEAP=2G SCONE_STACK=2M SCONE_LOG=DEBUG java -jar ./gradletodo-0.0.1-SNAPSHOT.jar --spring.profiles.active=container  
    

# RUN git clone --branch dev/oldVersion https://github.com/ChristianPavel/todo.git

# docker-compose command:
# sudo docker-compose up --build --force-recreate --no-deps