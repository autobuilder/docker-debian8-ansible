FROM debian:stretch
LABEL maintainer="AutoBuilder24x7"

ENV DEBIAN_FRONTEND noninteractive

ENV pip_packages "ansible cryptography"

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       sudo systemd \
       build-essential wget libffi-dev libssl-dev \
       python-pip python-dev python-setuptools python-wheel \
    && apt-get clean \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py

# Install Ansible via pip.
RUN pip install $pip_packages

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

CMD ["/lib/systemd/systemd"]
