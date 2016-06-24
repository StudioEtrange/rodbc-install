# Install RODBC package

* Build & Install unixODBC
* Build & Install RODBC package on a GNU/Linux system or on MacOs

* For ROracle see roracle-install https://github.com/StudioEtrange/roracle-install

## Prerequites

* R should be present on system
* Standard build tools
* HTTP should work to download R packages - so set http_proxy env var if needed

## Install

### Help

	./install.sh -h|--help

### Build & install RODBC package

	./install.sh [<path>]

NOTE : Default install path is R Packages default path.

### Install build tools

	./setup.sh

_NOTE : This script will test if build tools are installed. If you have already build tools or if your system package manager does not match, bypass this step and install build tools by yourself_


## Usage of RODBC

You can use it within your R script

	localRepo <- Sys.getenv("LOCAL_R_REPO")
	.libPaths( c( .libPaths(), localRepo) )
	library(RODBC)


And then call this R script from a shell (for example)

	export LOCAL_R_REPO=/path/to/rpackage/install/folder
	Rscript my_script.R

## Note on Stella

* This script is built on stella framework (https://github.com/StudioEtrange/stella)
* If you do not have stella on your system, it will be auto-installed when using this script
* OR you can install it manually with

	https_proxy=http://host:port ./stella-link.sh bootstrap

## Usefull Links

* http://carlo-hamalainen.net/blog/2012/5/11/r-makeflags-rpath-and-building-packages
* http://hiltmon.com/blog/2013/09/18/setup-odbc-for-r-on-os-x/
* http://stackoverflow.com/questions/26210317/installation-of-rodbc-roracle-packages-on-os-x-mavericks/26219189#26219189
