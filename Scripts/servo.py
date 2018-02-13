import time
import pigpio
 
servos = 18 #GPIO number
 
pi = pigpio.pi()

#pulsewidth can only set between 500-2500
try:
    while True:
 
        pi.set_servo_pulsewidth(servos, 1250) #0 degree
        print("Servo {} {} micro pulses".format(servos, 1000))
        time.sleep(2)
        pi.set_servo_pulsewidth(servos, 1500) #90 degree
        print("Servo {} {} micro pulses".format(servos, 1500))
        time.sleep(2)
        pi.set_servo_pulsewidth(servos, 1750) #180 degree
        print("Servo {} {} micro pulses".format(servos, 2000))
        time.sleep(2)
 
   # switch all servos off
except KeyboardInterrupt:
    pi.set_servo_pulsewidth(servos, 0);
 
pi.stop()
