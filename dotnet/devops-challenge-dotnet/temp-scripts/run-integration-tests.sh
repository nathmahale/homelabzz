#!/bin/bash

OLD_APP_PROCESS=$(ps -ef | grep DevOpsChallenge.SalesApi.dll | grep -v grep | cut -d' ' -f2)

if [ -z "$OLD_APP_PROCESS" ]; then
    echo "[ INFO ] killing old server process"
    sleep 20
    kill -9 $OLD_APP_PROCESS
else
    echo "[ ERROR ] Please check logs"
fi

dotnet $BUILD_DIR/src/DevOpsChallenge.SalesApi/bin/Release/net5.0/DevOpsChallenge.SalesApi.dll &
APP_RUN_PROCESS_ID=$!

echo $APP_RUN_PROCESS_ID
dotnet test --verbosity minimal $BUILD_DIR/tests/DevOpsChallenge.SalesApi.IntegrationTests

if [ -z "$APP_RUN_PROCESS_ID" ]; then
    echo "[ INFO ] dotnet integration testing is completed successfully!"
    sleep 20
    kill -9 $APP_RUN_PROCESS_ID
    exit 0
else
    echo "[ ERROR ] Please check the logs"
fi
