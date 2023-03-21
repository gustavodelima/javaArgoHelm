FROM gradle AS BUILD
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew build --no-daemon 

FROM tomcat:latest
COPY --from=BUILD /home/gradle/src/build/libs/devops-poc-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/devops.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
