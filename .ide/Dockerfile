# .ide/Dockerfile，在项目根目录下增加此文件, 实际配置时可根据情况安装其他软件支持
FROM node:21-bullseye

# install vscode and extension
RUN curl -fsSL https://code-server.dev/install.sh | sh &&\
    code-server --install-extension redhat.vscode-yaml &&\
    code-server --install-extension orta.vscode-jest &&\
    code-server --install-extension dbaeumer.vscode-eslint &&\
    code-server --install-extension eamodio.gitlens &&\
    # code-server --install-extension moonbit.moonbit-lang &&\
    echo done

RUN /bin/bash -c "$(curl -fsSL https://cli.moonbitlang.cn/ubuntu_x86_64_moon_setup.sh)"

# 指定字符集支持命令行输入中文（根据需要选择字符集）
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8