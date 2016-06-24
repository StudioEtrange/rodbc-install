# Install RODBC package

* Build & Install unixODBC
* Build & Install RODBC package on a GNU/Linux system or on MacOs

## Prerequites

* R should be present on system
* Standard build tools
* HTTP should work to download R packages - so set http_proxy env var if needed

## Install

### Build & install RODBC package

	./install.sh [<path>]

NOTE : Default install path is rodbc-install/workspace.

### Install build tools

	./setup.sh

_NOTE : This script will test if build tools are installed. If you have already build tools or if your system package manager does not match, bypass this step and install build tools by yourself_


## Usage of RODBC

You can use it within your R script

	localRepo <- Sys.getenv("LOCAL_R_REPO")
	.libPaths( c( .libPaths(), localRepo) )
	library(DBI)
	library(ROracle)

And then call this R script from a shell (for example)

	export LOCAL_R_REPO=/path/to/rpackage/install/folder
	# Optional
	export TNS_ADMIN="/path/folder/"
	Rscript my_script.R

Your /etc/host **MUST** be correctly defined. Oracle Instant Client must resolve your hostname

	127.0.0.1 localhost my_host_name

If you use tnsnames.ora file, put it in a folder and set TNS_ADMIN env var (only folder path, without tnsnames.ora)

	export TNS_ADMIN="/path/folder/"

## Note on Stella

* This script is built on stella framework (https://github.com/StudioEtrange/stella)
* If you do not have stella on your system, it will be auto-installed when using this script
* OR you can install it manually with

	https_proxy=http://host:port ./stella-link.sh bootstrap

## Usefull Links

* http://carlo-hamalainen.net/blog/2012/5/11/r-makeflags-rpath-and-building-packages
* http://hiltmon.com/blog/2013/09/18/setup-odbc-for-r-on-os-x/
* http://stackoverflow.com/questions/26210317/installation-of-rodbc-roracle-packages-on-os-x-mavericks/26219189#26219189
