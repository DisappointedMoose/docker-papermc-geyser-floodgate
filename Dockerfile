FROM alpine:latest

# Environment variables
ENV MC_VERSION="latest" \
    PAPER_BUILD="latest" \
    MC_RAM="4g" \
    JAVA_OPTS=""

COPY papermc.sh .

RUN apk update \
    && apk add libstdc++ \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add wget \
    && apk add jq \
    && mkdir /papermc

#get the config file into the root
COPY ./geyeserMCConfig.yml .
COPY ./server.properties .

# Start script
CMD ["bash", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 19132/udp
VOLUME /papermc
