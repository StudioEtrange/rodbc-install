#!/bin/bash
_CURRENT_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
_CURRENT_RUNNING_DIR="$( cd "$( dirname "." )" && pwd )"
source $_CURRENT_FILE_DIR/stella-link.sh include

usage() {
	echo "** Build & Install RODBC package"
	echo "$0 [<path>] [-h|--help]"
	echo " <path>    : path where to install RODBC package and its dependencies."
	echo "             Default is $(Rscript --vanilla -e 'cat(.libPaths()[1])')"
	echo
	echo " -h|--help : show help"
	echo " choose versions through environment variables :" 
	echo "             RODBC_VERSION=1.3-13 UNIXODBC_VERSION=2_3_4 $0 [<path>]"
}

[ "$1" = "-h" ] && usage && exit
[ "$1" = "--help" ] && usage && exit

# default versions
# available versions : https://github.com/cran/RODBC/releases
RODBC_VERSION="${RODBC_VERSION:-1.3-13}"
# available versions : https://github.com/StudioEtrange/stella/blob/stable/nix/pool/feature-recipe/feature_unixodbc.sh
UNIXODBC_VERSION="${UNIXODBC_VERSION:-2_3_4}"


# Check R Install
type Rscript &> /dev/null || _result=1
if [ "$_result" = "1" ]; then
	echo "ERROR : Rscript not found. Please install R/Rscript on your system"
	exit $_result
fi

# Install path
INSTALL_ROOT="$1"
if [ -z "$INSTALL_ROOT" ]; then
	# determine default package directory
	INSTALL_ROOT="$(Rscript --vanilla -e 'cat(.libPaths()[1])')"
fi
INSTALL_ROOT="$($STELLA_API rel_to_abs_path "$INSTALL_ROOT" $_CURRENT_RUNNING_DIR)"
mkdir -p "$INSTALL_ROOT"
mkdir -p "$STELLA_APP_CACHE_DIR"


# Define R local repo
export LOCAL_R_REPO="$INSTALL_ROOT"


echo "======> Installing RODBC package into $LOCAL_R_REPO <======"

# unixODBC
echo "-*--*-** Install unixODBC **-*--*-"
#rm -Rf "$INSTALL_ROOT/unixodbc"
$STELLA_API feature_install "unixodbc#${UNIXODBC_VERSION}" "EXPORT $INSTALL_ROOT"


# Install Package RODBC
echo "-*--*-** Install RODBC **-*--*-"
# download RODBC source
$STELLA_API get_resource "RODBC" "https://github.com/cran/RODBC/archive/${RODBC_VERSION}.tar.gz" "HTTP_ZIP" "$STELLA_APP_WORK_ROOT"
# patch RODBC.c
sed -i".bak" 's/include <config.h>/include "config.h"/' $STELLA_APP_WORK_ROOT/RODBC/src/RODBC.c

# build RODBC
# MAKEFLAGS are use with R CMD
# see R CMD config
#MAKEFLAGS="LDFLAGS=-L$INSTALL_ROOT/unixodbc/$UNIXODBC_VERSION/lib" DYLD_LIBRARY_PATH="$INSTALL_ROOT/unixodbc/$UNIXODBC_VERSION/lib"
MAKEFLAGS="LDFLAGS=-L$INSTALL_ROOT/unixodbc/$UNIXODBC_VERSION/lib" R CMD INSTALL -l $LOCAL_R_REPO --configure-args="--with-odbc-manager=odbc --with-odbc-include=$INSTALL_ROOT/unixodbc/$UNIXODBC_VERSION/include --with-odbc-lib=$INSTALL_ROOT/unixodbc/$UNIXODBC_VERSION/lib" $STELLA_APP_WORK_ROOT/RODBC/

# Check built package
$STELLA_API check_binary_file "$INSTALL_ROOT/RODBC"

# Test Package RODBC
echo "-*--*-** Testing RODBC **-*--*-"
Rscript "$STELLA_APP_ROOT/test.R"


echo "======> END <======"
