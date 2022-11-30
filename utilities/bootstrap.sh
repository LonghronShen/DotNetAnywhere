#!/bin/bash

set -x

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

vercmp() {
    if [[ "$1" == "$2" ]]; then
        return 0
    fi
    local IFS=.
    local i ver1=("$1") ver2=("$2")
    # fill empty fields in ver1 with zeros
    for ((i = ${#ver1[@]}; i < ${#ver2[@]}; i++)); do
        ver1[i]=0
    done
    for ((i = 0; i < ${#ver1[@]}; i++)); do
        if [[ -z ${ver2[i]} ]]; then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 2
        fi
    done
    return 0
}

retry() {
    local -r -i max_attempts="$1"
    shift
    local -i attempt_num=1
    until "$@"; do
        if ((attempt_num == max_attempts)); then
            echo "Attempt $attempt_num failed and there are no more attempts left!"
            return 1
        else
            echo "Attempt $attempt_num failed! Trying again in $attempt_num seconds..."
            sleep $((attempt_num++))
        fi
    done
}

unameOut="$(uname -s)"
arch="x64"
case "${unameOut}" in
Linux*)
    machine=linux
    apt clean
    apt update
    retry 10 apt install -y apt-transport-https gnupg ca-certificates \
        git build-essential ccache ninja-build pkg-config \
        python3-pip python3-all-dev \
        libicu-dev

    update-ca-certificates -f

    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    echo "deb https://download.mono-project.com/repo/ubuntu stable-$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
    apt update
    retry 10 apt install -y mono-roslyn mono-complete mono-dbg msbuild

    hash cmake 2>/dev/null || { pip3 install -i https://mirrors.aliyun.com/pypi/simple cmake; }
    hash dotnet 2>/dev/null || { bash ./install-dotnet.sh; }
    ;;
Darwin*)
    machine=osx
    hash sudo 2>/dev/null || {
        echo >&2 "Plesse ensure you have executed 'xcode-select --install' to have build tools ready."
        exit
    }
    brew install boost@1.67 icu4c
    ;;
CYGWIN*) machine=win ;;
MINGW32_NT)
    machine=win
    arch=x86
    ;;
MINGW64_NT)
    machine=win
    ;;
*)
    machine="UNKNOWN:${unameOut}"
    echo "Not supported platform: ${machine}"
    exit 1
    ;;
esac
