import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

GPIO.setup(18, GPIO.OUT)

p = GPIO.PWM(18, 50)

p.start(7.0)

try:
    while True:
        p.ChangeDutyCycle(5.5)  # right
        time.sleep(1) # sleep 1 second
        p.ChangeDutyCycle(6.0)  # middle
        time.sleep(1) # sleep 1 second
        p.ChangeDutyCycle(6.5)  # middle
        time.sleep(1) # sleep 1 second
        p.ChangeDutyCycle(7.0)  # middle
        time.sleep(1) # sleep 1 second
        p.ChangeDutyCycle(7.5)  # middle
        time.sleep(1) # sleep 1 second
        p.ChangeDutyCycle(8.0)  # middle
        time.sleep(1) # sleep 1 second
        p.ChangeDutyCycle(8.5)  # left
        time.sleep(1) # sleep 1 second

except KeyboardInterrupt:
    p.stop()
    GPIO.cleanup()
