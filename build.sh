#!/usr/bin/env bash
set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
EXPORT_SCRIPT="${ESP_IDF_EXPORT_SCRIPT:-${HOME}/esp/esp-idf/export.sh}"

# Default State
PORT="${ESPPORT:-}"
RUN_MONITOR=0
BUILD_ONLY=0
SELECTED_BOARD=""

# Hardware Definitions
declare -A TARGETS=(
    ["esp32s3"]="esp32s3"
    ["waveshare_c6"]="esp32c6"
    ["waveshare_c6_1.9"]="esp32c6"
    ["waveshare_c6_1.47"]="esp32c6"
    ["t_embed"]="esp32s3"
    ["paradoxt"]="esp32s3"
    ["cardputer"]="esp32s3"
)
declare -A NAMES=(
    ["esp32s3"]="esp32s3_generic"
    ["waveshare_c6"]="waveshare_c6_1.9"
    ["waveshare_c6_1.9"]="waveshare_c6_1.9"
    ["waveshare_c6_1.47"]="waveshare_c6_1.47"
    ["t_embed"]="lilygo_t_embed_cc1101"
    ["paradoxt"]="paradoxt"
    ["cardputer"]="m5stack_cardputer_adv"  # <-- ИСПРАВЛЕНО
)
declare -A DIRS=(
    ["esp32s3"]="build_s3"
    ["waveshare_c6"]="build_waveshare_c6"
    ["waveshare_c6_1.9"]="build_waveshare_c6"
    ["waveshare_c6_1.47"]="build_waveshare_c6_1.47"
    ["t_embed"]="build_t_embed"
    ["paradoxt"]="build_paradoxt"
    ["cardputer"]="build_cardputer"
)

usage() {
    cat <<EOF
Usage: $(basename "$0") --board <name> [options]
Boards: esp32s3, waveshare_c6, waveshare_c6_1.9, waveshare_c6_1.47, t_embed, paradoxt, cardputer
Options: -p|--port, -m|--monitor, --build-only
EOF
}
