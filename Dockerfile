ARG REGISTRY=ghcr.io
ARG TF2_COMPETITIVE_VERSION=3.5.1
FROM ${REGISTRY}/melkortf/tf2-competitive:${TF2_COMPETITIVE_VERSION}
LABEL maintainer="garrappachc@gmail.com"

COPY checksum.md5 .

ARG ATRSMX_PLUGIN_FILE_NAME=tf2attributes.smx
ARG ATRSMX_PLUGIN_URL=https://github.com/FlaminSarge/tf2attributes/releases/download/v1.7.3.3/${ATRSMX_PLUGIN_FILE_NAME}

ARG ATRINC_PLUGIN_FILE_NAME=tf2attributes.inc
ARG ATRINC_PLUGIN_URL=https://github.com/FlaminSarge/tf2attributes/releases/download/v1.7.3.3/${ATRINC_PLUGIN_FILE_NAME}

ARG ATRTXT_PLUGIN_FILE_NAME=tf2.attributes.txt
ARG ATRTXT_PLUGIN_URL=https://github.com/FlaminSarge/tf2attributes/releases/download/v1.7.3.3/${ATRTXT_PLUGIN_FILE_NAME}

ARG BHOP_PLUGIN_VERSION=1.8.0
ARG BHOP_PLUGIN_FILE_NAME=tf-bhop.zip
ARG BHOP_PLUGIN_URL=https://github.com/Mikusch/tf-bhop/releases/download/${BHOP_PLUGIN_VERSION}/${BHOP_PLUGIN_FILE_NAME}

ARG SCRMBL_PLUGIN_VERSION=0.7.1.4
ARG SCRMBL_PLUGIN_FILE_NAME=package.tar.gz
ARG SCRMBL_PLUGIN_URL=https://github.com/nosoop/SMExt-SourceScramble/releases/download/0.7.1.4/${SCRMBL_PLUGIN_FILE_NAME}


RUN \
  # download all the plugins
  wget -nv "${SCRMBL_PLUGIN_URL}" "${ATRSMX_PLUGIN_URL}" "${ATRINC_PLUGIN_URL}" "${ATRTXT_PLUGIN_URL}" "${BHOP_PLUGIN_URL}" \
  # verify checksums
  && md5sum -c checksum.md5 \
  # install plugins
  && tar -xzf "${SCRMBL_PLUGIN_FILE_NAME}" -C "${SERVER_DIR}/tf/" \
  && mv "${ATRSMX_PLUGIN_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/plugins/${ATRSMX_PLUGIN_FILE_NAME}" \
  && mv "${ATRINC_PLUGIN_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/scripting/include/${ATRINC_PLUGIN_FILE_NAME}" \
  && mv "${ATRTXT_PLUGIN_FILE_NAME}" "${SERVER_DIR}/tf/addons/sourcemod/gamedata/${ATRTXT_PLUGIN_FILE_NAME}" \
  && unzip -q -o "${BHOP_PLUGIN_FILE_NAME}" -d "${SERVER_DIR}/tf/addons/sourcemod/" \
  # cleanup
  && rm "${SCRMBL_PLUGIN_FILE_NAME}" \
  && rm "${BHOP_PLUGIN_FILE_NAME}" \
  && rm "checksum.md5"


COPY server.cfg.template ${SERVER_DIR}/tf/cfg/server.cfg.template