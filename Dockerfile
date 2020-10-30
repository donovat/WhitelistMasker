FROM openliberty/open-liberty:full-java11-openj9-ubi

ARG VERSION=1.0.7
ARG REVISION=RELEASE

LABEL \
  org.opencontainers.image.authors="Nathaniel Mills" \
  org.opencontainers.image.vendor="IBM" \
  org.opencontainers.image.url="local" \
  org.opencontainers.image.source="https://github.com/IBM/WhitelistMasker/tree/master/MaskWebServices" \
  org.opencontainers.image.version="$VERSION" \
  org.opencontainers.image.revision="$REVISION" \
  vendor="IBM" \
  name="MaskWebServices" \
  version="$VERSION-$REVISION" \
  summary="MaskWebServices" \
  description="This image contains the Open Source MaskWebServices microservice running with the Open Liberty runtime."

COPY --chown=1001:0 MaskWebServices/server.xml /config/
COPY --chown=1001:0 MaskWebServices/target/*.war /config/dropins/
COPY --chown=1001:0 MaskWebServices/properties/  /opt/ol/wlp/output/defaultServer/properties/
COPY --chown=1001:0 MaskWebServices/server.env /config/
COPY --chown=1001:0 Masker/properties/  /opt/ol/wlp/output/defaultServer/properties/

ENV AIDEN_HOME=/opt/ol/wlp/output/defaultServer
ENV ENV SEC_TLS_TRUSTDEFAULTCERTS=true
ENV ENV SEC_IMPORT_K8S_CERTS=true

RUN configure.sh
