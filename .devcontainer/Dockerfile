FROM storm:2.6.4 AS storm 
# RUN /docker-entrypoint.sh

FROM mcr.microsoft.com/devcontainers/java:1-21-bullseye
ARG DISTRO_NAME=apache-storm-2.6.4
ENV PATH=$PATH:/$DISTRO_NAME/bin \
    JAVA_HOME=/docker-java-home \
    STORM_CONF_DIR=/conf \
    STORM_DATA_DIR=/data \
    STORM_LOG_DIR=/logs 

RUN mkdir -p "$STORM_CONF_DIR" "$STORM_DATA_DIR" "$STORM_LOG_DIR"; \
    chown -R vscode:vscode "$STORM_CONF_DIR" "$STORM_DATA_DIR" "$STORM_LOG_DIR"; \
    alias mvn="mvn -Dmaven.repo.local=$$PWD/.repository"

COPY --from=storm --chown=vscode:vscode /$DISTRO_NAME /$DISTRO_NAME
# COPY --from=storm --chown=vscode:vscode ${STORM_CONF_DIR} ${STORM_CONF_DIR}
COPY ./storm.yaml ${STORM_CONF_DIR}/storm.yaml
