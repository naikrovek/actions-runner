FROM ubuntu:20.04

ARG GH_RUNNER_VERSION=2.284.0

ENV RUNNER_NAME=""
ENV GITHUB_SERVER=""
ENV GITHUB_TOKEN=""
ENV RUNNER_LABELS=""
ENV RUNNER_WORK_DIRECTORY="_work"
ENV RUNNER_ALLOW_RUNASROOT=false

# Create a user for running actions
RUN useradd -m actions
RUN mkdir -p /home/actions 
WORKDIR /home/actions

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install curl sudo jq git -y \
    && curl -L -O https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz \
    && tar -zxf actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz \
    && rm -f actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz \
    && ./bin/installdependencies.sh \
    && apt-get clean \
    && echo "actions ALL=(ALL) NOPASSWD:apt, apt-get" > /etc/sudoers.d/0-actions-runner

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh && chown -R actions:actions /home/actions
USER actions
CMD ./entrypoint.sh