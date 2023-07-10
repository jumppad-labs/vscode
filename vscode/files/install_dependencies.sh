#!/bin/bash -ex
for extension in ${EXTENSIONS//,/$IFS}; do
  OUTPUT=$(code-server --install-extension $extension)
  if [[ ! ${OUTPUT} =~ 'successfully installed' ]]; then
    echo "fallback"
    AUTHOR=$(echo $extension | cut -d '.' -f 1)
    PACKAGE=$(echo $extension | cut -d '.' -f 2 | cut -d '@' -f 1)
    VERSION=$(echo $extension | cut -d '@' -f 2)
    curl -L --retry 5 -o extension.gz https://marketplace.visualstudio.com/_apis/public/gallery/publishers/${AUTHOR}/vsextensions/${PACKAGE}/${VERSION}/vspackage
    gunzip extension.gz
    mv extension extension.vsix
    RETRY=$(code-server --install-extension extension.vsix)
    rm extension.vsix
    if [[ ! ${RETRY} =~ 'successfully installed' ]]; then
      echo "could not install package"
      exit 1
    fi 
  fi
done