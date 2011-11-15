#! /bin/sh
# Please set these values before running the script!
# We recommend something like:
#   SRC_DIR=$HOME/profile/default/src/unstable
#   INSTALL_DIR=$HOME/profile/default/install/unstable

set -e

SRC_DIR=/home/thomas/profiles/laas/src/unstable
INSTALL_DIR=/home/thomas/profiles/laas/install/unstable


# Use environment variables to override these options
: ${GIT=/usr/bin/git}
: ${CMAKE=/usr/bin/cmake}
: ${MAKE=/usr/bin/make}

: ${GIT_CLONE_OPTS=}
: ${MAKE_OPTS=-j3 -k}

: ${BUILD_TYPE=Release}
: ${ROBOT=HRP2LAAS}

# Compilation flags
: ${CFLAGS="-march=pentium-m -O3 -pipe -fomit-frame-pointer -ggdb -DNDEBUG"}

# Git URLs
JRL_URI=git@github.com:jrl-umi3218
LAAS_URI=git@github.com:laas

# If you do not have a GitHub account (read-only):
#JRL_URI=git://github.com:jrl-umi3218
#LAAS_URI=git://github.com:laas

# HTTP protocol can also be used:
#JRL_URI=https://thomas-moulard@github.com/jrl-umi3218
#LAAS_URI=https://thomas-moulard@github.com/laas

LAAS_PRIVATE_URI=ssh://softs.laas.fr/git/jrl

################
# Installation #
################
set -e
if test x"$SRC_DIR" = x; then
    echo "Please set the source dir"
    exit 1
fi
if test x"$INSTALL_DIR" = x; then
    echo "Please set the install dir"
    exit 1
fi

mkdir -p                \
    $INSTALL_DIR	\
    $SRC_DIR/oss        \
    $SRC_DIR/roboptim   \
    $SRC_DIR/laas       \
    $SRC_DIR/jrl        \
    $SRC_DIR/sot        \
    $SRC_DIR/robots

install_git()
{
    cd /tmp
    rm -f git-1.7.6.1.tar.bz2
    wget http://kernel.org/pub/software/scm/git/git-1.7.6.1.tar.bz2
    mv git-1.7.6.1.tar.bz2 $SRC_DIR/oss/
    cd $SRC_DIR/oss
    tar xjvf git-1.7.6.1.tar.bz2
    cd git-1.7.6.1
    ./configure --prefix=${INSTALL_DIR}
    ${MAKE} ${MAKE_OPTS}
    ${MAKE} ${MAKE_OPTS} install
}

install_doxygen()
{
    cd /tmp
    rm -f doxygen-1.7.3.src.tar.gz
    wget http://ftp.stack.nl/pub/users/dimitri/doxygen-1.7.3.src.tar.gz
    mv doxygen-1.7.3.src.tar.gz $SRC_DIR/oss/
    cd $SRC_DIR/oss
    tar xzvf doxygen-1.7.3.src.tar.gz
    cd doxygen-1.7.3
    ./configure --prefix ${INSTALL_DIR}
    ${MAKE} ${MAKE_OPTS}
    ${MAKE} ${MAKE_OPTS} install
}

install_pkg()
{

    cd $1
    if test -d "$2"; then
	cd $2
    	${GIT} pull
    else
    	${GIT} ${GIT_CLONE_OPTS} clone $3/$2
        cd $2
    fi
    if ! test x"$4" = x; then
       if ${GIT} branch | grep $4 ; then
	   ${GIT} checkout $4
       else
	   ${GIT} checkout -b $4 origin/$4
       fi
    fi
    ${GIT} submodule init && ${GIT} submodule update
    mkdir -p _build-${BUILD_TYPE}
    cd _build-${BUILD_TYPE}
    ${CMAKE} \
	-DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
	-DCMAKE_C_FLAGS_${BUILD_TYPE}="${CFLAGS}" \
	-DCMAKE_CXX_FLAGS_${BUILD_TYPE}="${CFLAGS}" \
	-DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
	-DSMALLMATRIX=jrl-mathtools -DROBOT="${ROBOT}" ..
    ${MAKE} ${MAKE_OPTS}
    ${MAKE} install ${MAKE_OPTS}
}

install_python_pkg()
{
    cd "$1"
    if test -d "$2"; then
	cd "$2"
	${GIT} pull
    else
	${GIT} ${GIT_CLONE_OPTS} clone "$3/$2"
	cd "$2"
    fi
    if ! test x"$4" = x; then
       if ${GIT} branch | grep "$4" ; then
	   ${GIT} checkout "$4"
       else
	   ${GIT} checkout -b "$4" "origin/$4"
       fi
    fi
    ${GIT} submodule init && ${GIT} submodule update
    python setup.py install --prefix=${INSTALL_DIR}
}


# Setup environment variables.
export LD_LIBRARY_PATH="${INSTALL_DIR}/lib"
export PKG_CONFIG_PATH="${INSTALL_DIR}/lib/pkgconfig"
export PYTHONPATH="${INSTALL_DIR}/lib/python2.6/dist-packages"
export PATH="${INSTALL_DIR}/bin:${INSTALL_DIR}/sbin:$PATH"

# --- Third party tools
install_git
install_doxygen

# --- Roboptim
install_pkg $SRC_DIR/roboptim roboptim-core ${LAAS_URI}

install_pkg $SRC_DIR/roboptim cfsqp \
    ${LAAS_PRIVATE_URI}/roboptim/core-plugin
install_pkg $SRC_DIR/roboptim roboptim-trajectory ${LAAS_URI}

# --- Mathematical tools
install_pkg $SRC_DIR/jrl jrl-mathtools ${JRL_URI}
install_pkg $SRC_DIR/jrl jrl-mal ${JRL_URI} topic/python

# --- Interfaces
install_pkg $SRC_DIR/laas abstract-robot-dynamics ${LAAS_URI}

# --- Dynamics implementation
install_pkg $SRC_DIR/jrl jrl-dynamics ${JRL_URI}


# --- Robots private data
# Install by hand the following packages to have hrp-2 support:
# - hrp2_10
# - hrp2_14
# - hrp2Dynamics
# - hrp2-10-optimized
#
install_pkg $SRC_DIR/robots hrp2_10 ${LAAS_PRIVATE_URI}
install_pkg $SRC_DIR/robots hrp2_14 ${LAAS_PRIVATE_URI}
install_pkg $SRC_DIR/robots hrp2Dynamics ${LAAS_PRIVATE_URI}
install_pkg $SRC_DIR/robots hrp2-10-optimized ${LAAS_PRIVATE_URI}/robots


# --- Dynamic graph and associated bindings.
install_pkg $SRC_DIR/sot dynamic-graph ${JRL_URI} topic/singleton
install_pkg $SRC_DIR/sot dynamic-graph-python ${JRL_URI} topic/singleton

install_pkg $SRC_DIR/laas hpp-template-corba ${LAAS_URI}

install_pkg $SRC_DIR/sot sot-core ${JRL_URI} topic/python
install_pkg $SRC_DIR/laas dynamic-graph-corba ${LAAS_URI}

# Optional CORBA bindings:
#  install_pkg $SRC_DIR/sot dg-middleware ${JRL_URI}

# --- Control architecture

install_pkg $SRC_DIR/sot sot-dynamic ${JRL_URI} topic/python

# Additionally, you can also compile:
#
# Pattern generator support:
#  install_pkg $SRC_DIR/jrl jrl-walkgen ${JRL_URI}
#  install_pkg $SRC_DIR/sot sot-pattern-generator ${JRL_URI}
#
# OpenHRP support:
install_pkg $SRC_DIR/sot sot-openhrp ${JRL_URI} topic/python
#  install_pkg $SRC_DIR/sot sot-openhrp-scripts ${JRL_URI}
#
# Visualization tools:
#install_python_pkg $SRC_DIR/laas robot-viewer ${LAAS_URI}
#  install_python_pkg $SRC_DIR/laas sot-gui ${LAAS_URI}


install_pkg $SRC_DIR/sot sot-motion-planner "git@github.com:thomas-moulard"
