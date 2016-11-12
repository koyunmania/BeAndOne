N:
cd "N:\apache-tomcat-8.0.9-windows-x64\apache-tomcat-8.0.9\webapps"
rmdir spocial /S /Q
del spocial.war
P:
cd "P:\Sport Social\Sources\webapp\v0.4"
copy "target\webapp-1.0.0-BUILD-SNAPSHOT.war" "N:\Work\apache-tomcat-8.0.9-windows-x64\apache-tomcat-8.0.9\webapps\spocial.war"
N:
cd "N:\Work\apache-tomcat-8.0.9-windows-x64\apache-tomcat-8.0.9\logs"
del * /S /Q
cd "P:\Sport Social\Sources\webapp\v0.4"
P: