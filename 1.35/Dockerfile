FROM ubuntu:24.04

LABEL maintainer="Fábio Naspolini@fabionaspolini@gmail.com"

ARG KUBECTL_VERSION=v1.35

# from https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
RUN apt-get update && apt-get install -y curl apt-transport-https ca-certificates curl gnupg unzip
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/${KUBECTL_VERSION}/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring
RUN echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${KUBECTL_VERSION}/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list
RUN chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly
RUN apt-get update && apt-get install -y kubectl

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
