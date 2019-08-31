FROM ubuntu:19.04

RUN apt-get update \
  && apt-get install -y unzip wget python3-pip \
  && apt-get autoremove

# install the AWS CLI (which requires python), see https://github.com/aws/aws-cli/releases for latest versions
ARG AWS_CLI_VERSION=1.16.230
RUN pip3 install --upgrade pip \
  && pip install --no-cache-dir awscli==${AWS_CLI_VERSION}

# install the latest version of TF
ARG tf_version="0.12.7"
RUN wget -nv https://releases.hashicorp.com/terraform/${tf_version}/terraform_${tf_version}_linux_amd64.zip \
  && unzip terraform_${tf_version}_linux_amd64.zip \
  && mv terraform /usr/local/bin \
  && terraform --version

ARG terragrunt_version="v0.19.21"
RUN wget -nv https://github.com/gruntwork-io/terragrunt/releases/download/${terragrunt_version}/terragrunt_linux_amd64 \
  && mv terragrunt_linux_amd64 /usr/local/bin/terragrunt \
  && chmod +x /usr/local/bin/terragrunt \
  && terragrunt --version

RUN mkdir -p ~/.aws \
  && touch ~/.aws/credentials
