FROM gitpod/workspace-base:2023-10-19-14-24-02

RUN /bin/bash -c "$(curl -fsSL https://cli.moonbitlang.com/ubuntu_x86_64_moon_setup.sh)"

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
