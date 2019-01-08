# В образе установлено и собрано окружение для запуска
# необходимых emacs команд

FROM ubuntu:16.04

LABEL description="Ubuntu image configured for emacs commands"
LABEL version="1.0"

WORKDIR /usr/src/app

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
                pandoc \
                markdown \
                build-essential \
                less \
                sbcl \
                clisp \
                git \
                curl \
                wget \
                clisp-dev \
                openssl \
                ca-certificates \
                aptitude \
                libxml2-dev \
                libxslt-dev \
                python-dev \
                libssl-dev zlib1g-dev libbz2-dev \
                libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils


RUN apt-get install -y --no-install-recommends mercurial mercurial-common

# Install pyenv for tox

RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH:$PYENV_ROOT/versions/2.7/bin/

RUN echo 'echo "Hello world"' >> ~/.bash_profile
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(pyenv init -)"' >> ~/.bash_profile

RUN exec $SHELL

RUN eval "$(pyenv init -)"

RUN pyenv install 2.7.15 && \
    pyenv install 3.6.8

#&& \
#    pyenv install 3.5.0 && \
#    pyenv install 3.6.0

RUN pyenv local 2.7.15 3.6.8

COPY req.txt /req.txt
COPY req_3_only.txt /req_3_only.txt

RUN pip2.7 install -U pip && \
    pip3.6 install -U pip && \
    pip2.7 install -U -r /req.txt && \
    pip3.6 install -U -r /req.txt && \
    pip3.6 install -U -r /req_3_only.txt
## && pip3.5 install -U -r /req.txt


COPY env.sh /usr/bin/env.sh


RUN chmod +x /usr/bin/env.sh
#RUN pyenv shell 2.7

CMD ["echo", "emacsd docker work"]
