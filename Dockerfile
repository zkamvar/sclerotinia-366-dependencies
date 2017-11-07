## This Dockerfile describes the R analysis environment for:
##
## Kamvar, Z.N., Amaradasa, B.S., Jhala, R., McCoy, S., Steadman, S., and
## Everhart, S.E. (2017). Population structure and phenotypic variation of
## _Sclerotinia sclerotiorum_ from dry bean in the United States PeerJ XXX
##
## package versions here are locked to those present in version 3.4.2
##
## Note: this Dockerfile was modified from
## https://github.com/NESCent/popgen-docker/blob/193387d3f1e5484ef8a1ddf6d66cfca64ccd40d7/Rpopgen/Dockerfile
##
## It also includes logic from
## https://github.com/benmarwick/mjbtramp/blob/898ee99f17d64a41161a8b6760325572c7406b4b/Dockerfile

## Lock in a specific SHA from rocker verse
FROM rocker/verse:3.4.2
MAINTAINER Zhian Kamvar <zkamvar@gmail.com>

# Prevent error messages from debconf about non-interactive frontend
# ARG TERM=linux
# ARG DEBIAN_FRONTEND=noninteractive

## Copy the current directory to /analysis
COPY DESCRIPTION /analysis/DESCRIPTION

# ggforce requires units which required udunits2
RUN apt-get update \
&&  apt-get install -y libudunits2-dev

## Install population genetics packages from MRAN and GitHub from 2017-09-18
## You can find the descriptions of the packages in the DESCRIPTION file
## I'm running devtools install twice here to force the github repos to install
RUN . /etc/environment \
&& R -e "devtools::install('/analysis', dep=TRUE, repos='$MRAN'); devtools::install('/analysis', dep=TRUE, repos='$MRAN')"
