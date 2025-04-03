#!/bin/bash

# Populate Defaults
GAMEMODE="${GAMEMODE:-survival}"
MOTD="${MOTD:-Minecraft server}"
DIFFICULTY="${DIFFICULTY:-peaceful}"
ENABLE_WHITELIST="${ENABLE_WHITELIST:-false}"
SERVER_NAME="${SERVER_NAME:-Minecraft server}"

update_server_setting() {
    local KEY="$1"
    local VALUE="$2"
    local FILE="/papermc/server.properties"

    if [[ ! -f "$FILE" ]]; then
        echo "File $FILE not found."
        return 1
    fi

    if grep -q "^$KEY=" "$FILE"; then
        sed -i "s/^$KEY=.*/$KEY=$VALUE/" "$FILE"
    else
        echo "$KEY=$VALUE" >> "$FILE"
    fi
}

update_geyser_setting() {
    local KEY="$1"
    local VALUE="$2"
    local FILE="/papermc/plugins/Geyser-Spigot/config.yml"

    if [[ ! -f "$FILE" ]]; then
        echo "File $FILE not found."
        return 1
    fi

    sed -i "s/$KEY:.*/$KEY: \"$VALUE\"/" "$FILE"
}

update_geyser_setting "server-name" "${SERVER_NAME}"

update_server_setting "motd" "${MOTD}"
update_server_setting "gamemode" "${GAMEMODE}"
update_server_setting "difficulty" "${DIFFICULTY}"
update_server_setting "white-list" "${ENABLE_WHITELIST}"