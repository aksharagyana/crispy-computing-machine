FROM ubuntu:22.04

ARG SOPS_VERSION=v3.8.1

RUN apt-get -y update \
    && update-ca-certificates \
    && apt-get install -y --no-install-recommends \
		curl wget uuid-dev git zip unzip gpg tar ca-certificates apt-transport-https openssh-client openssh-server \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv \
    && echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile \
    && echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc \
    && ln -s ~/.tfenv/bin/* /usr/local/bin \
    && git clone https://github.com/iamhsa/pkenv.git ~/.pkenv \
    && echo 'export PATH="${HOME}/.pkenv/bin:$PATH"' >> ~/.bash_profile \
    && echo 'export PATH=$PATH:$HOME/.pkenv/bin' >> ~/.bashrc \
    && ln -s ~/.pkenv/bin/* /usr/local/bin

RUN curl -o /usr/local/bin/sops -L https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64 \
    &&  chmod +x /usr/local/bin/sops
