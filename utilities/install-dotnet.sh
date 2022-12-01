#!/bin/bash

set -x

curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 7.0 --install-dir /usr/local/bin/
dotnet --info
