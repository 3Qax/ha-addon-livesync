FROM couchdb:3.3

# Install additional tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
