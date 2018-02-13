import os
import time
os.system ("sudo pigpiod") #Launching GPIO library
time.sleep(1) #avoid the error
import pigpio

ESC=26  #Connect the ESC in this GPIO pin
SERVO=18
MIN=1500

pi = pigpio.pi();
pi.set_servo_pulsewidth(ESC, MIN)
pi.set_servo_pulsewidth(SERVO, MIN)

from aiohttp import web
import socketio

sio = socketio.AsyncServer()
app = web.Application()
sio.attach(app)

async def index(request):
    """Serve the client-side application."""
    with open('index.html') as f:
        return web.Response(text=f.read(), content_type='text/html')

@sio.on('connect', namespace='/drive')
def connect(sid, environ):
    print("connect ", sid)

@sio.on('setSpeed', namespace='/drive')
async def setSpeed(sid, data):
    val = data * 250 + 1500 # max speed is 500, but 250 is more than enough, yet
    pi.set_servo_pulsewidth(ESC, val)
    print("setSpeed ", val)
    #await sio.emit('reply', room=sid)

@sio.on('setSteering', namespace='/drive')
async def setSteering(sid, data):
    val = data * 250 + 1500
    pi.set_servo_pulsewidth(SERVO, val)
    print("setSteering ", val)
    #await sio.emit('reply', room=sid)

@sio.on('disconnect', namespace='/drive')
def disconnect(sid):
    print('disconnect ', sid)
    # Reset to avoid nasty events
    pi.set_servo_pulsewidth(ESC, MIN)
    pi.set_servo_pulsewidth(SERVO, MIN)

#app.router.add_static('/static', 'static')
app.router.add_get('/', index)

if __name__ == '__main__':
    web.run_app(app)