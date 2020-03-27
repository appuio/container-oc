#!/bin/sh -e

YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NO_COLOR='\033[0m'

echo_to_stderr() {
  echo -e "${1}" >&2
}

echo_to_stderr ${BLUE}
echo_to_stderr "----------------------------------------------------------------------"
echo_to_stderr "${PURPLE}DEPRECATION NOTICE:${YELLOW} We're replacing helm version 2 by version 3."
echo_to_stderr "  Please, migrate your setup! Helm v3 is incompatible with v2."
echo_to_stderr "  Migration guide: ${WHITE}https://helm.sh/docs/topics/v2_v3_migration/"
echo_to_stderr "${YELLOW}"
echo_to_stderr "  The binary /bin/helm will point to /bin/helm3 starting June 1, 2020."
echo_to_stderr "  Please update calls to 'helm' by 'helm2' before this change, if you don't migrate to v3."
echo >&2
echo_to_stderr "  The binary /bin/helm2 will be available as long as Helm v2 is officially supported."
echo_to_stderr "  You may update calls to 'helm' by 'helm2' during that period."
echo_to_stderr ${CYAN}
echo_to_stderr "  Thank you for using APPUiO!"
echo_to_stderr "  Technical support: ${WHITE}support@vshn.ch${BLUE}"
echo_to_stderr "----------------------------------------------------------------------"
echo_to_stderr ${NO_COLOR}

helm2 ${*}
