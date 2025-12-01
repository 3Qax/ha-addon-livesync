ARG BUILD_FROM=couchdb:3.3
FROM ${BUILD_FROM}

# Install additional tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Jakub Towarek" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.authors="Jakub Towarek" \
    org.opencontainers.image.source="https://github.com/3Qax/ha-addon-livesync" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

CMD [ "/run.sh" ]
