From tomcat:latest
add target/addressbook.war /user/local/tomcat/webapps

# Expose the port on which Tomcat will listen (usually port 8080)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]


