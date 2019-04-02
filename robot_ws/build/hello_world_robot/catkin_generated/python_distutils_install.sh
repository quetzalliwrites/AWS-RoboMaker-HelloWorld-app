#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/src/hello_world_robot"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/install/hello_world_robot/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/install/hello_world_robot/lib/python2.7/dist-packages:/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/build/hello_world_robot/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/build/hello_world_robot" \
    "/usr/bin/python" \
    "/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/src/hello_world_robot/setup.py" \
    build --build-base "/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/build/hello_world_robot" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/install/hello_world_robot" --install-scripts="/home/ubuntu/environment/AWS-RoboMaker-HelloWorld-app/robot_ws/install/hello_world_robot/bin"
