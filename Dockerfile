FROM node:17.2.0-bullseye-slim

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

RUN apt-get update && apt-get install --no-install-recommends -y \
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
    xvfb \
    # Chrome dependencies
    fonts-liberation \
    libayatana-appindicator3-1 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install Google Chrome
ARG CHROME_VERSION=94.0.4606.71
RUN wget -O /tmp/google-chrome-stable_current_amd64.deb "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}-1_amd64.deb" && \
    dpkg -i /tmp/google-chrome-stable_current_amd64.deb ; \
    apt-get install -f -y && \
    rm -f /tmp/google-chrome-stable_current_amd64.deb
