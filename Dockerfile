FROM alpine:latest
RUN addgroup -g 1000 sonar && adduser -u 1000 -G sonar -h /app -D sonar && apk add bash gcompat openjdk11
USER 1000:1000
RUN cd /app && \
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.9.56886.zip && \
unzip `ls *.zip` && \
rm -f *.zip && \
mv `ls -d sonar*` sonarqube && \
ln -s /dev/stdout /app/sonarqube/logs/sonar.log && \
mkdir -p /app/sonarqube/data && \
sed -i 's|^wrapper.java.command.*|wrapper.java.command=/usr/bin/java|g' /app/sonarqube/conf/wrapper.conf
WORKDIR /app/sonarqube/
EXPOSE 9000
ENTRYPOINT ["/app/sonarqube/bin/linux-x86-64/sonar.sh","console"]
