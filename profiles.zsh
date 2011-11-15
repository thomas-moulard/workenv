# -*- shell-script -*-

# Development profile management.
##################################

PROFILES_DIR="$HOME/profiles"

CONFIG_SH="$HOME/profiles/$PROFILE/config.sh"
test -f "$CONFIG_SH" && source "$CONFIG_SH" \
 || echo "failed to load profile $PROFILE"

function setup_profiles()
{
 mkdir -p "$PROFILES_DIR"
 mkdir -p "$PROFILES_DIR/licenses"
}

function make_profile()
{
 if test x"$1" = x; then
  echo "make_profile needs a profile name"
  echo "To make a profile which match your computer architecture, use make_profile_native"
  return 1
 fi

 if test -d "$PROFILES_DIR/$1"; then
     echo "profile already exists"
     return 1
 fi

 mkdir -p "$PROFILES_DIR/$1"
 mkdir -p "$PROFILES_DIR/$1/src"
 mkdir -p "$PROFILES_DIR/$1/src/stable"
 mkdir -p "$PROFILES_DIR/$1/src/unstable"
 mkdir -p "$PROFILES_DIR/$1/install"
 mkdir -p "$PROFILES_DIR/$1/install/stable"
 mkdir -p "$PROFILES_DIR/$1/install/unstable"
 mkdir -p "$PROFILES_DIR/$1/build"
 mkdir -p "$PROFILES_DIR/$1/build/stable"
 mkdir -p "$PROFILES_DIR/$1/build/unstable"

 # Fill directories.
 cp "$WORKENV_DIR/config.sh.in" "$PROFILES_DIR/$1/config.sh"
 sed -i -e "s|@PROFILE_DIR@|$PROFILES_DIR/$1|g" "$PROFILES_DIR/$1/config.sh"

 DG_SETUP="$PROFILES_DIR/$1/install/unstable/bin/dg-setup.sh"
 mkdir -p "$PROFILES_DIR/$1/install/unstable/bin"
 cp "$WORKENV_DIR/dg-setup.sh.in" "$DG_SETUP"
 sed -i \
     -e "s|@SRC_DIR@|$PROFILES_DIR/$1/src/unstable|g" \
     -e "s|@INSTALL_DIR@|$PROFILES_DIR/$1/install/unstable|g" \
     "$DG_SETUP"

 # Setup robotpkg
 git clone --depth 1 ssh://softs.laas.fr/git/robots/robotpkg.git \
 "$PROFILES_DIR/$1/src/stable"
 git clone --depth 1 ssh://softs.laas.fr/git/robots/robotpkg-wip.git \
 "$PROFILES_DIR/$1/src/stable/wip"

 # Bootstrap robotpkg
 "$PROFILES_DIR/$1/src/stable/bootstrap/bootstrap" --prefix "$PROFILES_DIR/$1/install/stable"

 # Prepare rosinstall
 ROS_DIR="$PROFILES_DIR/$1/src/unstable/ros"
 mkdir "$ROS_DIR"
 wget "https://raw.github.com/laas/ros/master/laas.rosinstall" \
     -O "$ROS_DIR/.rosinstall"
 rosinstall "$ROS_DIR" /opt/ros/diamondback

 echo "Profile $1 created!"
}

function make_profile_native()
{
    ARCH=`uname -a | sed 's|.* \(.*\) GNU/Linux$|\1|'`
    KERNEL=`uname -s | tr '[:upper:]' '[:lower:]'`
    DIST='unknown'
    if test -f /etc/issue; then
	DIST=`cat /etc/issue | sed 's|\([^ ]*\) \([0-9.]*\) .*|\1-\2|' | tr '[:upper:]' '[:lower:]'`
    fi
    make_profile "default-$ARCH-$KERNEL-$DIST"
}

function setup_ros_on_profile()
{
}
