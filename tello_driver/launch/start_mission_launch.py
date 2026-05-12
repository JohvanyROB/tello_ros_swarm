from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import ExecuteProcess
from launch.substitutions import FindExecutable


def generate_launch_description():
    nb_uavs = 3

    takeoff_cmds = []
    for i in range(nb_uavs):
        takeoff_cmds.append(
            ExecuteProcess(
                cmd=[
                    FindExecutable(name="ros2"),
                    "service",
                    "call",
                    f"/drone{i+1}/tello_action",
                    "tello_msgs/srv/TelloAction",
                    "{cmd : takeoff}"
                ],
                output="screen"
            )
        )
    

    ld = LaunchDescription()
    
    for action in takeoff_cmds:
        ld.add_action(action)
    
    ld.add_action(
        Node(
            package = "tello_controller",
            executable = "clock_publisher.py"
        )
    )

    ld.add_action(
        Node(
            package = "tello_controller",
            executable = "dists_to_group_lab.py"  #change btw real and sim dists_to_group_lab dists_to_group
        )
    )

    return ld