#!/bin/bash
for extension in ${EXTENSIONS//,/$IFS}; do
  code-server serve-local --accept-server-license-terms --install-extension $extension
done

bounce install

code-server serve-local \
  --accept-server-license-terms \
  --connection-token ${CONNECTION_TOKEN} \
  --host 0.0.0.0 \
  --verbose \
  -- \
  --default-folder ${DEFAULT_FOLDER}