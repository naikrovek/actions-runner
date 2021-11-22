FROM ubuntu:20.04

ARG GH_RUNNER_VERSION=2.284.0

ENV RUNNER_NAME=""
ENV GITHUB_SERVER=""
ENV GITHUB_TOKEN=""
ENV RUNNER_LABELS=""
ENV RUNNER_WORK_DIRECTORY="_work"
ENV RUNNER_ALLOW_RUNASROOT=false
ENV AGENT_TOOLS_DIRECTORY=/opt/hostedtoolcache

# Create a user for running actions
RUN useradd -m actions
RUN mkdir -p /home/actions ${AGENT_TOOLS_DIRECTORY}
WORKDIR /home/actions

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install curl jq git -y \
    && curl -L -O https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz \
    && tar -zxf actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz \
    && rm -f actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz \
    && ./bin/installdependencies.sh \
    && apt-get clean 

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh && chown -R actions:actions /home/actions ${AGENT_TOOLS_DIRECTORY}

USER actions
CMD ./entrypoint.sh