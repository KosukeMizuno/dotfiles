FROM centos:centos8.3.2011
LABEL maintainer "Kosuke Mizuno <dotmapu@gmail.com>"

RUN yum update -y
ENV TZ Asia/Tokyo

RUN yum groupinstall -y "Development Tools"
RUN yum install -y sudo git wget openssh tree man cmake yum-utils

# python dependencies
## 名前解決がおかしくて失敗するやつが混ざってるので個別指定＆エラーを無視して進める
## 下記はpyenvのwikiから: https://github.com/pyenv/pyenv/wiki#suggested-build-environment
RUN yum install -y bzip2-devel bzip2 readline-devel sqlite sqlite-devel openssl-devel libffi-devel zlib-devel tk-devel xz-devel; \
    yum-builddep -y python3 ; exit 0

RUN yum clean all

# make a user who can sudo
ARG USERNAME=u1
ARG USERPASSWD=xxx

RUN useradd ${USERNAME} \
   && echo "root:${USERPASSWD}" | chpasswd \
   && echo "${USERNAME}:${USERPASSWD}" | chpasswd
RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}/

#### install tools ####
ENV DOTPATH /home/${USERNAME}/dotfiles

ENV PREFIX /home/${USERNAME}/.local
ENV PATH $PREFIX/bin:$PATH
ENV LD_RUN_PATH $PREFIX/lib64:$PREFIX/lib:/usr/lib64:/usr/lib:/lib64:/lib
ENV LD_LIBRARY_PATH $PREFIX/lib64:$PREFIX/lib:/usr/lib64:/usr/lib:/lib64:/lib
ENV PKG_CONFIG_PATH $PREFIX/lib64/pkgconfig:$PREFIX/lib/pkgconfig

RUN mkdir -p $PREFIX/src
WORKDIR $PREFIX/src

ENV DOTINSTALL_TMUX true
ENV DOTINSTALL_FONTS true
ENV DOTINSTALL_GOLANG true
ENV DOTINSTALL_RUST true
ENV DOTINSTALL_NODEJS true
ENV DOTINSTALL_PYTHON true
ENV DOTINSTALL_PERL true
ENV DOTINSTALL_LATEX true

WORKDIR /home/${USERNAME}/dotfiles
