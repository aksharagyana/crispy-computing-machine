FROM ghcr.io/aksharagyana/crispy-computing-machine:main

ENV TARGETARCH="linux-x64"

RUN apt-get update && apt-get install -y \
		 jq libicu70  \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

# Create agent user and set up home directory
RUN useradd -m -d /home/agent agent
RUN chown -R agent:agent /azp /home/agent

USER agent
# Another option is to run the agent as root.
# ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT ./start.sh