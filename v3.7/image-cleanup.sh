#!/bin/sh

YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NO_COLOR='\033[0m'

echo_to_stderr()
{
  echo -e "${1}" >&2
}

echo_to_stderr ${BLUE}
echo_to_stderr "----------------------------------------------------------------------"
echo_to_stderr "${PURPLE}DEPRECATION NOTICE:${YELLOW} We're replacing image-cleanup with seiso"
echo_to_stderr "  Please, migrate your setup! seiso is incompatible with image-cleanup."
echo_to_stderr "  Migration guide: ${WHITE}https://github.com/appuio/seiso"
echo_to_stderr "${YELLOW}"
echo_to_stderr "  image-cleanup will be available until June 1, 2020."
echo_to_stderr "  Please update calls to 'image-cleanup' by 'seiso' before this change."
echo_to_stderr ${CYAN}
echo_to_stderr "  Thank you for using APPUiO!"
echo_to_stderr "  Technical support: ${WHITE}support@vshn.ch${BLUE}"
echo_to_stderr "----------------------------------------------------------------------"
echo_to_stderr ${NO_COLOR}

/opt/image-cleanup "${@}"
