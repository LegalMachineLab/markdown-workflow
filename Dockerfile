FROM mcr.microsoft.com/devcontainers/base:ubuntu
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update \
    && apt install texlive-latex-recommended texlive-xetex texlive-fonts-extra wget -y \
    && rm -rf /var/lib/apt/lists/*
# ENV PANDOC_VERSION=$(curl -o /dev/null -sL -w %{url_effective} https://github.com/jgm/pandoc/releases/latest | cut -d"/" -f8)
ENV PANDOC_VERSION=3.1.13
RUN wget https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION/pandoc-$PANDOC_VERSION-1-amd64.deb \
    && apt install ./pandoc-$PANDOC_VERSION-1-amd64.deb -y
COPY extension/markdownworkflow-0.0.1.vsix /
WORKDIR /app
COPY --chown=1000:1000 z-lib /app/z-lib
COPY --chown=1000:1000 *.sh /app
ENV PATH="/app:${PATH}"