#!/bin/bash

PLUGIN_DIR="/papermc/plugins"

# process plugins.yml
yq e '.plugins[] | .name + " " + .version + " " + .url' /papermc/plugins.yml | while read -r name version url; do
    echo "Checking Plugin ${name}:${version}..."
    
    filename="${name}-${version}.jar"
    
    # always download when version is "latest"
    if [ "$version" == "latest" ]; then
        echo "Downloading ${name} as ${filename}..."
        wget -qO "$PLUGIN_DIR/$filename" "$url"
    elif [ ! -f "$PLUGIN_DIR/$filename" ]; then
        # delete other versions of plugin
        echo "Deleting other versions of ${name}..."
        find "$PLUGIN_DIR" -type f -name "${name}-*.jar" ! -name "$filename" -exec rm {} \;
        
        echo "Downloading ${name} as ${filename}..."
        wget -qO "$PLUGIN_DIR/$filename" "$url"
    else
        echo "Plugin ${name} already up to date. Skipping..."
    fi
done

echo "Done updating plugins"
