function change_ros()
{
    if [ "$#" -eq 0 ]; then
	profile=""
    elif [ "$#" -eq 1 ]; then
	profile="$1"
    else
	echo "change_ros [ROS version]"
	return 1
    fi

    test -f "$CONFIG_SH" && sed -i "s|^ROS_PROFILE=\"[^\"]*\"$|ROS_PROFILE=\"$profile\"|" "$CONFIG_SH"
    echo "profile switched, open a new terminal to apply."
}
