
FROM ubuntu:latest
COPY . /minecraft
WORKDIR /
RUN apt update && apt upgrade -yq
RUN apt-get -q update && apt-get -yq install gnupg curl && apt-key adv \
  --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys 0xB1998361219BD9C9

RUN curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb
RUN apt-get install ./zulu-repo_1.0.0-3_all.deb && apt-get update
RUN apt-get zulu17-ca-jre-headless -yq
RUN mkdir fabric
WORKDIR /fabric
