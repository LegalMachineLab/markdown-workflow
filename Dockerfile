FROM pandoc/latex:latest-ubuntu
ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN apt update \
    && apt install fonts-texgyre -y \
    && rm -rf /var/lib/apt/lists/*
# ENV PANDOC_VERSION=$(curl -o /dev/null -sL -w %{url_effective} https://github.com/jgm/pandoc/releases/latest | cut -d"/" -f8)
# ENV PANDOC_VERSION=3.1.13
# RUN wget https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-1-amd64.deb \
#     && apt install ./pandoc-$PANDOC_VERSION-1-amd64.deb -y
RUN tlmgr install footmisc sectsty titling academicons fvextra lineno fontawesome datetime2 truncate
WORKDIR /app
COPY --chown=1000:1000 extension/markdownworkflow-0.0.1.vsix /app
COPY --chown=1000:1000 z-lib /app/z-lib
COPY --chown=1000:1000 *.sh /app
ENV PATH="/app:${PATH}"