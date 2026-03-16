FROM ubuntu:24.04

LABEL maintainer="Fábio Naspolini@fabionaspolini@gmail.com"

ARG KUBECTL_VERSION

# from https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
RUN apt-get update && apt-get install -y curl apt-transport-https ca-certificates gnupg unzip
RUN curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
RUN curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256"
RUN echo "$(cat kubectl.sha256) kubectl" | sha256sum --check
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# AWS EKS Support - from https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    rm awscliv2.zip && \
    ./aws/install

ENV HOME=/root
ENV KUBECONFIG=$HOME/.kube/config
WORKDIR $HOME
RUN mkdir $HOME/.kube
COPY start.sh .
RUN chmod +x start.sh
ENTRYPOINT [ "./start.sh" ]
