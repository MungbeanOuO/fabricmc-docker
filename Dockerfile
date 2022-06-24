FROM ubuntu:latest
COPY ./minecraft /fabric
WORKDIR /
RUN apt-get -q update && apt-get -yq upgrade && apt-get clean && apt-get autoremove \
    && apt-get -q update \
    && apt-get -yq install gnupg curl && apt-key adv \
        --keyserver hkp://keyserver.ubuntu.com:80 \
        --recv-keys 0xB1998361219BD9C9 \
    && curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb \
    && apt-get -yq install ./zulu-repo_1.0.0-3_all.deb && apt-get update -q \
    && apt-get -yq install zulu17-ca-jre-headless
WORKDIR /fabric
RUN chmod 777 ./fabric-installer-0.11.0.jar \
    && java -jar ./fabric-installer-0.11.0.jar server -mcversion 1.19 -downloadMinecraft \
    && rm ./fabric-installer-0.11.0.jar \
    && chmod 777 ./fabric-server-launch.jar \
    && chmod 777 ./start.sh 
    
CMD ["/fabric/start.sh", "run"]