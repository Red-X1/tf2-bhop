ARG REGISTRY=ghcr.io
ARG TF2_COMPETITIVE_VERSION=3.5.1
FROM ${REGISTRY}/melkortf/tf2-competitive:${TF2_COMPETITIVE_VERSION}
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

ARG SYSTEM2_FILE_NAME=system2.zip

ARG CONNECTOR_PLUGIN_FILE_NAME=connector.smx
ARG CONNECTOR_PLUGIN_VERSION=0.6.0
ARG CONNECTOR_PLUGIN_URL=https://github.com/tf2pickup-org/connector/releases/download/${CONNECTOR_PLUGIN_VERSION}/${CONNECTOR_PLUGIN_FILE_NAME}

ARG TEAMS_PLUGIN_FILE_NAME=teams.smx
ARG TEAMS_PLUGIN_URL=https://github.com/tf2pickup-org/stadium-sm-plugin/raw/master/${TEAMS_PLUGIN_FILE_NAME}

ARG MAPDL_PLUGIN_FILE_NAME=mapdownloader.smx
ARG MAPDL_PLUGIN_URL=https://github.com/spiretf/mapdownloader/raw/master/plugin/${MAPDL_PLUGIN_FILE_NAME}


COPY system2.zip .

RUN \
  # download all the plugins
  wget -nv "${CONNECTOR_PLUGIN_URL}" "${TEAMS_PLUGIN_URL}" "${MAPDL_PLUGIN_URL}" \
  # verify checksums
  && md5sum -c checksum.md5 \
  # install plugins
  && unzip -q "${SYSTEM2_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/" \
  && mv "${CONNECTOR_PLUGIN_FILE_NAME}" "$SERVER_DIR/tf/addons/sourcemod/plugins/${CONNECTOR_PLUGIN_FILE_NAME}" \
  && mv "${TEAMS_PLUGIN_FILE_NAME}" "$SERVER_DIR/tf/addons/sourcemod/plugins/${TEAMS_PLUGIN_FILE_NAME}" \
  && mv "${MAPDL_PLUGIN_FILE_NAME}" "$SERVER_DIR/tf/addons/sourcemod/plugins/${MAPDL_PLUGIN_FILE_NAME}" \
  # cleanup
  && rm "${SYSTEM2_FILE_NAME}" \
  && rm "checksum.md5"

ENV TEAM_SIZE=6
ENV TF2PICKUPORG_API_ADDRESS=
ENV TF2PICKUPORG_SECRET=
ENV TF2PICKUPORG_PRIORITY=1
ENV TF2PICKUPORG_OVERRIDE_INTERNAL_ADDRESS=
ENV TF2PICKUPORG_OVERRIDE_PUBLIC_ADDRESS=

COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template