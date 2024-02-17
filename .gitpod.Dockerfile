FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

# Install:
# - git (and git-lfs), for git operations (to e.g. push your work).
#   Also required for setting up your configured dotfiles in the workspace.
# - sudo, while not required, is recommended to be installed, since the
#   workspace user (`gitpod`) is non-root and won't be able to install
#   and use `sudo` to install any other tools in a live workspace.
RUN apt-get update && \
    apt-get install -yq \
        git \
        git-lfs \
        sudo \
        lsb-release \
        curl wget \
        apt-transport-https gnupg ca-certificates \
        build-essential ccache ninja-build pkg-config \
        python3-pip python3-all-dev \
        libicu-dev

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-$(lsb_release -cs) main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt update && \
    apt install -yq mono-roslyn mono-complete mono-dbg msbuild

RUN curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 8.0 --install-dir /usr/local/bin/ && \
    dotnet --info

RUN pip3 install cmake

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt update \
    && apt install -yq docker-ce docker-ce-cli containerd.io docker-buildx-plugin

# Install docker-compose
RUN curl -o /usr/local/bin/docker-compose -fsSL https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-linux-$(uname -m) \
    && chmod +x /usr/local/bin/docker-compose && mkdir -p /usr/local/lib/docker/cli-plugins && \
    ln -s /usr/local/bin/docker-compose /usr/local/lib/docker/cli-plugins/docker-compose

# https://github.com/wagoodman/dive
RUN curl -o /tmp/dive.deb -fsSL https://github.com/wagoodman/dive/releases/download/v0.11.0/dive_0.11.0_linux_amd64.deb \
    && apt install /tmp/dive.deb \
    && rm /tmp/dive.deb

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod
