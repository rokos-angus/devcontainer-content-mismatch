FROM ubuntu:22.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y curl software-properties-common ca-certificates git \
    build-essential libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev \
    libreadline-dev libbz2-dev libsqlite3-dev make gcc

ARG PYTHON_VERSION=3.9.10
ARG USERNAME=user
ENV HOME=/home/$USERNAME
RUN useradd -m $USERNAME
USER $USERNAME

RUN curl https://pyenv.run | bash
RUN env PYTHON_CONFIGURE_OPTS="--enable-shared" $HOME/.pyenv/bin/pyenv install $PYTHON_VERSION && \
  $HOME/.pyenv/bin/pyenv global $PYTHON_VERSION

# install poetry and configure it to create virtualenvs in the project folder
RUN curl -sSL 'https://install.python-poetry.org' | python3 -
ENV PATH="$HOME/.local/bin:$HOME/.pyenv/versions/$PYTHON_VERSION/bin:$PATH"
RUN poetry config virtualenvs.in-project true
