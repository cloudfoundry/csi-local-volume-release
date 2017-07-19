#!/bin/bash

set -e

cd `dirname $0`
cd ..

go build -o "$HOME/csi_local_controller" "src/github.com/jeffpak/local-controller-plugin/cmd/localcontrollerplugin/main.go"

go get -t github.com/paulcwarren/csi-cert

#=======================================================================================================================
# local-controller-plugin 
#=======================================================================================================================

# TCP TESTS
export FIXTURE_FILENAME=$PWD/scripts/fixtures/local_plugin_cert.json
/bin/bash scripts/start_controller_plugin_tcp.sh
pushd src/github.com/paulcwarren/csi-cert
    ginkgo
popd
/bin/bash scripts/stop_controller_plugin_tcp.sh

rm -rf $HOME/csi_plugins