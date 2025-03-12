#!/bin/bash

PLUGIN_GEYSER="${PLUGIN_GEYSER:-true}"
PLUGIN_FLOODGATE="${PLUGIN_FLOODGATE:-true}"
PLUGIN_ESSENTIALS="${PLUGIN_ESSENTIALS:-true}"
PLUGIN_LUCKPERMS="${PLUGIN_LUCKPERMS:-true}"

manage_plugin() {
    local INSTALL_PLUGIN=$1
    local PLUGIN_NAME=$2
    local PLUGIN_URL=$3
    local PLUGIN_FILENAME="./plugins/${PLUGIN_NAME}.jar"

    if [ "$INSTALL_PLUGIN" = true ]; then
        echo "Installing ${PLUGIN_NAME}..."
        mkdir -p ./plugins  # Sicherstellen, dass der Ordner existiert

        if wget -q -O "$PLUGIN_FILENAME" "$PLUGIN_URL"; then
            echo "${PLUGIN_NAME} downloaded successfully."
        else
            echo "Error: Failed to download ${PLUGIN_NAME}."
            return 1
        fi
        return 0
    fi

    # If INSTALL_PLUGIN is not true, delete Plugin if it exists
    [ -f "$PLUGIN_FILENAME" ] && echo "Removing ${PLUGIN_NAME}..." && rm -f "$PLUGIN_FILENAME"
}

manage_plugin $PLUGIN_GEYSER "Geyser" "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"
manage_plugin $PLUGIN_FLOODGATE "Floodgate" "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"
manage_plugin $PLUGIN_ESSENTIALS "EssentialsX" "https://github.com/EssentialsX/Essentials/releases/download/2.20.1/EssentialsX-2.20.1.jar"
manage_plugin $PLUGIN_LUCKPERMS "LuckPerms" "https://download.luckperms.net/1571/bukkit/loader/LuckPerms-Bukkit-5.4.154.jar"