#!/bin/bash
cat /app/scripts/credits.txt

export LD_LIBRARY_PATH=/app/rust/RustDedicated_Data/Plugins/x86_64

if [ $CARBON_ENABLE ] 
then
    if [[ ! -d "/app/rust/carbon" || $CARBON_UPDATE ]] 
    then
        echo "======== Installing or Updating Carbon Mod ========"
        /app/scripts/install_carbon.sh
    fi
    
    echo "======== Initialize Carbon ========"
    source /app/server/carbon/tools/environment.sh
fi

echo "======== Start Rust Server ========"

/app/rust/RustDedicated \
    -batchmode \
    -load \
    -nographics \
    +server.port $SERVER_PORT \
    +server.queryport $SERVER_QUERY_PORT \
    +server.hostname "$SERVER_NAME" \
    +server.description "$SERVER_DESCRIPTION" \
    +server.level "$SERVER_LEVEL" \
    +server.worldsize $SERVER_WORLDSIZE \
    +server.url $SERVER_URL \
    +server.identity $SERVER_ID \
    +server.seed $SERVER_SEED \
    +server.maxplayers $SERVER_MAXPLAYERS \
    +rcon.port $RCON_PORT \
    +rcon.password $RCON_PASSWORD \
    +rcon.web $RCON_WEB