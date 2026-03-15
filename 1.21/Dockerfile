FROM ubuntu:18.04

LABEL maintainer="Fábio Naspolini@fabionaspolini@gmail.com"

RUN apt-get update && apt-get install -y apt-transport-https gnupg2 curl gettext-base unzip
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl=1.21.3-00

# AWS EKS Support
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
