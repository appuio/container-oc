#!/bin/sh -e

YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NO_COLOR='\033[0m'

echo -e ${BLUE}
echo -e "----------------------------------------------------------------------"
echo -e "${PURPLE}DEPRECATION NOTICE:${YELLOW} We're replacing helm version 2 by version 3."
echo -e "  Please, migrate your setup! Helm v3 is incompatible with v2."
echo -e "  Migration guide: ${WHITE}https://helm.sh/docs/topics/v2_v3_migration/"
echo -e "${YELLOW}"
echo -e "  The binary /bin/helm will point to /bin/helm3 starting June 1, 2020."
echo -e "  Please update calls to 'helm' by 'helm3' before this change."
echo
echo -e "  The binary /bin/helm2 will be available until December 1, 2020."
echo -e "  You may update calls to 'helm' by 'helm2' during that period."
echo -e ${CYAN}
echo -e "  Thank you for using APPUiO!"
echo -e "  Technical support: ${WHITE}support@vshn.ch${BLUE}"
echo -e "----------------------------------------------------------------------"
echo -e ${NO_COLOR}

helm2 ${*}
