FROM mcr.microsoft.com/devcontainers/base:ubuntu
ARG DEBIAN_FRONTEND=noninteractive
run apt update; apt install texlive-latex-recommended texlive-xetex texlive-fonts-extra wget --no-install-recommends -y; rm -rf /var/lib/apt/lists/*
run wget https://github.com/jgm/pandoc/releases/download/3.1.11/pandoc-3.1.11-1-amd64.deb; apt install ./pandoc-3.1.11-1-amd64.deb -y
workdir /app
copy . /app
# Change the ownership of the working directory to the non-root user "user"
RUN chown -R 1000:1000 /app
ENV PATH="${PATH}:/app"
# USER 1000