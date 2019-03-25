#!/bin/bash

if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed. Please install jq with "brew install jq" then rerun' >&2
  exit 1
fi

ROOTDIR="$(dirname $0)/.."
TEMPFILE="/tmp/bagubagu-common-$$.zip"

cd $ROOTDIR

zip -r $TEMPFILE bagubagu-common

aws lambda publish-layer-version --layer-name "bagubagu-common" \
    --description "Useful npm libraries for Bagubagu projects" \
    --license-info "MIT" \
    --compatible-runtimes "nodejs8.10" \
    --zip-file "fileb:///$TEMPFILE" \
    --profile bagubagu

LASTVERSION=$(aws lambda list-layer-versions --profile bagubagu --layer-name bagubagu-common |jq '.LayerVersions[-1].Version')

aws lambda add-layer-version-permission --layer-name bagubagu-common \
    --principal '*' \
    --version-number $LASTVERSION \
    --statement-id bbb$$ \
    --action lambda:GetLayerVersion \
    --profile bagubagu

rm $TEMPFILE
