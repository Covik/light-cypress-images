FROM node:17.2.0-bullseye-slim

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    ca-certificates \
    gnupg \
    wget \
    # Cypress dependencies
    libgtk2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb

# Install Google Chrome
ARG CHROME_VERSION=96.0.4664.110
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | gpg --dearmor \
    | tee /usr/share/keyrings/google-chrome-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/google-chrome-archive-keyring.gpg] https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y google-chrome-stable=${CHROME_VERSION}-1

RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean
