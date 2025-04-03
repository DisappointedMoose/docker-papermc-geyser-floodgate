FROM alpine:latest

# Environment variables
ENV MC_VERSION="latest" \
    PAPER_BUILD="latest" \
    MC_RAM="4g" \
    JAVA_OPTS=""

RUN apk update && apk add libstdc++ openjdk21-jre bash wget jq yq
RUN mkdir -p /papermc/plugins

COPY ./scripts/*.sh ./
COPY ./config/plugins.yml /default-config/plugins.yml

# Start script
CMD ["bash", "./run.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 19132/udp
VOLUME /papermc
