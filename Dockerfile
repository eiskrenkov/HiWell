# Step 1
FROM ruby:3.0.0-alpine

ARG MINECRAFT_VERSION

WORKDIR /downloads
COPY ruby ruby/

RUN ruby ruby/download_server.rb $MINECRAFT_VERSION

# Step 2
FROM openjdk:17-alpine3.13

WORKDIR /minecraft
COPY --from=0 /downloads/server.jar .

COPY server.properties /minecraft/server.properties
RUN echo "eula=true" >> eula.txt

CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
