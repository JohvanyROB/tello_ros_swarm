# tello_ros_swarm
This repository contains the required ROS pkgs to enable the communication with a swarm of Tello drones


```bash
mkdir -p ~/tello_swarm_ws/src && cd ~/tello_swarm_ws/src
git clone https://github.com/JohvanyROB/tello_ros_swarm
git clone https://github.com/ptrmu/ros2_shared.git
cd tello_ros_swarm && ./install_dependencies.sh
source ~/tello_swarm_ws/install/setup.bash
```

---
## Real experiments
### Start the positioning system
On the computer connected to the positioning system, run Motive and place the UAVs in the flight area.

### Start the message redirection on each Raspberry Pi
Using VNC Viewer, connect to each Pi, wait for it to connect to the corresponding Tello UAV then open a terminal and run the following instruction:
```bash
./Desktop/run_redirection.sh
```

### Start the communication with the positionning system
```bash
ros2 launch mocap_optitrack mocap.launch.py 
```

### Start the Tello driver multi launch file (communication btw the laptop and the UAVs)
```bash
ros2 launch tello_driver multi_launch.py
```


### Start the mission (drones takeoff and clock_publisher node start)
```bash
ros2 launch tello_driver start_mission_launch.py
```

### Stop the mission (drones land)
```bash
ros2 launch tello_driver stop_mission_launch.py
```