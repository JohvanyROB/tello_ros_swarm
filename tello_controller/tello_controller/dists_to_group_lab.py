import rclpy
from rclpy.node import Node
from geometry_msgs.msg import PoseStamped
from std_msgs.msg import Float32MultiArray
import numpy as np


class DistsToGroup(Node):
    def __init__(self):
        Node.__init__(self, "dists_to_group")

        self.dists = [None, None, None, None]
        self.p1 = (None, None, None)
        self.p2 = (None, None, None)
        self.p3 = (None, None, None)
        self.p4 = (None, None, None)
        self.ready_to_publish = False

        self.create_subscription(PoseStamped, "/drone1/pose", self.pose1_cb, qos_profile=1)
        self.create_subscription(PoseStamped, "/drone2/pose", self.pose2_cb, qos_profile=1)
        self.create_subscription(PoseStamped, "/drone3/pose", self.pose3_cb, qos_profile=1)
        self.create_subscription(PoseStamped, "/drone4/pose", self.pose4_cb, qos_profile=1)

        self.dists_pub = self.create_publisher(Float32MultiArray, "/dists", qos_profile=1)
        self.create_timer(0.02, self.publish_distances)  #distances are published @ 2Hz
    

    def __del__(self):
        self.get_logger().warn("Shutting down...")
    

    def pose1_cb(self, msg):
        """ Get the current pose of UAV 1 """
        self.p1 = (msg.pose.position.x, msg.pose.position.y, msg.pose.position.z)    #position of UAV 1
    

    def pose2_cb(self, msg):
        """ Get the current pose of UAV 2 """
        self.p2 = (msg.pose.position.x, msg.pose.position.y, msg.pose.position.z)    #position of UAV 2
    

    def pose3_cb(self, msg):
        """ Get the current pose of UAV 3 """
        self.p3 = (msg.pose.position.x, msg.pose.position.y, msg.pose.position.z)    #position of UAV 3


    def pose4_cb(self, msg):
        """ Get the current pose of UAV 4 """
        self.p4 = (msg.pose.position.x, msg.pose.position.y, msg.pose.position.z)    #position of UAV 4
        if self.p1[0] != None and self.p2[0] != None and self.p3[0] != None:    #all positions are available
            self.compute_distances()    #compute distances btw UAV4 and the others
            if not self.ready_to_publish:   #if no distances have been published yet
                self.ready_to_publish = True
        
    
    def compute_distances(self):
        """ Noisy distances btw the 4th uav and the 3 others """
        d1 = self.dist_3D(self.p1, self.p4)
        d2 = self.dist_3D(self.p2, self.p4)
        d3 = self.dist_3D(self.p3, self.p4)
        d1_noisy = d1 + np.random.normal(0, 0.05)  #gaussian noise added
        d2_noisy = d2 + np.random.normal(0, 0.05)
        d3_noisy = d3 + np.random.normal(0, 0.05)
        self.dists = [d1, d2, d3, d1_noisy, d2_noisy, d3_noisy]

    
    def dist_3D(self, p1, p2):
        """ Return the length of a 3D vector considering 2 points p1 and p2 """
        return np.sqrt( (p2[0] - p1[0])**2 + (p2[1] - p1[1])**2 + (p2[2] - p1[2])**2 )
    

    def publish_distances(self):
        """ Publish distances to the topic /dists """
        if self.ready_to_publish:
            msg = Float32MultiArray()   #array of floats
            msg.data = self.dists   #assign distances to msg component
            self.dists_pub.publish(msg) #publish msg
            # self.get_logger().info(f"d1: {self.dists[0]:.2f}, d2: {self.dists[1]:.2f}, d3: {self.dists[2]:.2f}")    #display distances if needed

    

def main(args=None):
    rclpy.init(args=args)

    node = DistsToGroup()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()