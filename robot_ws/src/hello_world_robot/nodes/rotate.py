
#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist 


class Rotator():
    def __init__(self):
        self.command_publisher = rospy.Publisher('/cmd_vel', Twist, queue_size =1)
        
    def rotate_forever(self):
        twist = Twist()
        
        r = rospy.Rate(10)
        while not rospy.is_shutdown():
            twist.angular.z = 0.1
            self.command_publisher.publish(twist)
            rospy.loginfo("Rotating robot: %s", twist)
            r.sleep()


def main():
    rospy.init_node('rotate')
    rotator = Rotator()
    rotator.rotate_forever()
    

    
    
if __name__ == '__main__':
    main()