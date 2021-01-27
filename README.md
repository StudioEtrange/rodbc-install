# Install RODBC package

* Build & Install unixODBC
* Build & Install RODBC package on a GNU/Linux system or on MacOs

_For ROracle see roracle-install https://github.com/StudioEtrange/roracle-install_

## Prerequites

* R should be present on system
* Standard build tools
* HTTP should work to download R packages

## Install

### Help

	./install.sh -h|--help

### Build & install RODBC package

	./install.sh [<path>]

NOTE : Default install path is R Packages default path. Inside path, RODBC and its dependencies will be installed.

### OPTIONAL : Choose versions

	RODBC_VERSION="1.3-13" UNIXODBC_VERSION="2_3_4" ./install.sh [<path>]

### OPTIONAL : Install build tools

	./buildtools.sh

_NOTE : This script will test if build tools are installed on your system and will try to install them. You should bypass this step and install build tools by yourself if needed_

## Dependencies

RODBC package have unixodbc library has dependency

## Usage of RODBC

You can use it within your R script

	localRepo <- Sys.getenv("LOCAL_R_REPO")
	.libPaths( c( .libPaths(), localRepo) )
	library(RODBC)


And then call this R script from a shell (for example)

	export LOCAL_R_REPO=<path>
	Rscript my_script.R

## Note on Stella

* This script is built on stella framework (https://github.com/StudioEtrange/stella)


## Usefull Links

* http://carlo-hamalainen.net/blog/2012/5/11/r-makeflags-rpath-and-building-packages
* http://hiltmon.com/blog/2013/09/18/setup-odbc-for-r-on-os-x/
* http://stackoverflow.com/questions/26210317/installation-of-rodbc-roracle-packages-on-os-x-mavericks/26219189#26219189
