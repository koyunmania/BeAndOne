D:
cd "D:\Work\Work\apache-tomcat-8.0.9-windows-x64\apache-tomcat-8.0.9\webapps"
rmdir beone /S /Q
del beone.war
rmdir ROOT /S /Q
del ROOT.war
D:
cd "D:\Work\BeOne\webapp\v0.2"
copy "target\webapp-1.0.0-BUILD-SNAPSHOT.war" "D:\Work\Work\apache-tomcat-8.0.9-windows-x64\apache-tomcat-8.0.9\webapps\ROOT.war"
D:
cd "D:\Work\Work\apache-tomcat-8.0.9-windows-x64\apache-tomcat-8.0.9\logs"
del * /S /Q
cd "D:\Work\BeOne\webapp\v0.2"
D: