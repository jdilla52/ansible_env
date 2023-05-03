FROM ubuntu:focal as linux_headless
ARG TAGS
WORKDIR /usr/local/bin
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y software-properties-common && apt-add-repository -y ppa:ansible/ansible && apt-add-repository -y ppa:neovim-ppa/unstable && apt update && apt install -y curl git ansible build-essential neovim
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS main.yml"]


FROM sickcodes/docker-osx:latest as mac

COPY . .
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install ansible
# RUN xcode-select --install
# RUN yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# # RUN yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# RUN (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/arch/.profile
# RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# RUN echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
# RUN echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile

# RUN brew install ansible

# CMD ["sh", "-c", "ansible-playbook $TAGS local-mac.yml"]