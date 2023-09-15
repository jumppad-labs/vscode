#!/bin/bash
# Replace the location of the terminal server with the environment vars
eval "echo \"$(cat ./envoy.yaml)\"" >> ./envoy_processed.yaml

# Run the proxy server
nohup envoy --log-path /logs/envoy.log --log-level debug -c ./envoy_processed.yaml --service-cluster front-proxy &

# Run docs in the background
npm run dev