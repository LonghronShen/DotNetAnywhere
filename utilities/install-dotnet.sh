#!/bin/bash

set -x

curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 6.0.400 --install-dir /usr/local/bin/
dotnet --info
