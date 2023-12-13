From tomcat:8.5.72-jdk17-openjdk-buster
copy target/addressbook.war /user/local/tomcat/webapps

# Expose the port on which Tomcat will listen (usually port 8080)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]


