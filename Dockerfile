FROM ubuntu:latest
COPY . /fabric
WORKDIR /
RUN apt update && apt upgrade -yq \
    && apt-get -q update \
    && apt-get -yq install gnupg curl && apt-key adv \
        --keyserver hkp://keyserver.ubuntu.com:80 \
        --recv-keys 0xB1998361219BD9C9 \
    && curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb \
    && apt-get install ./zulu-repo_1.0.0-3_all.deb && apt-get update \
    && apt-get zulu17-ca-jre-headless -yq
WORKDIR /fabric
RUN java -jar fabric-installer-0.11.0.jar server -mcversion 1.19 -downloadMinecraft \
    && rm fabric-installer-0.11.0.jar \
    && mv server.jar vanilla.jar \
    && mv fabric-server-launch.jar server.jar \
    && echo "serverJar=vanilla.jar" > fabric-server-launcher.properties \
    && start.sh