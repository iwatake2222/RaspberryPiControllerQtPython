import threading
import time
import RPi.GPIO as GPIO

TICK_DEGREE = 360/20

thread = None
resource = None

def getDiffRotate(gpio0, gpio1):
	global thread
	global resource
	if thread is None:
		startThread(gpio0, gpio1)
	ret = resource.diffRotate
	resource.diffRotate = 0
	return ret

def getTotalRotate(gpio0, gpio1):
	global thread
	global resource
	if thread is None:
		startThread(gpio0, gpio1)
	ret = resource.totalRotate
	return ret

class Resource(object):
	def __init__(self):
		self.diffRotate = 0
		self.totalRotate = 0

def loop(gpio0, gpio1, resource):
	print (str(gpio0) + " " + str(gpio1))
	GPIO.setwarnings(False)
	GPIO.setmode(GPIO.BCM)
	GPIO.setup(gpio0, GPIO.IN, pull_up_down=GPIO.PUD_UP)
	GPIO.setup(gpio1, GPIO.IN, pull_up_down=GPIO.PUD_UP)
	previousCode = 0
	while True:
		# code(FW) = 0 1 3 2 0 1 3 2 0 1 3 2
		rotationTable = [0,1,-1,0,-1,0,0,1,1,0,0,-1,0,-1,1,0]
		val0 = GPIO.input(gpio0)
		val1 = GPIO.input(gpio1)
		currentCode = val0 << 1 | val1
		# todo: chattering
		if currentCode != previousCode:
			code = previousCode << 2 | currentCode
			rotation = rotationTable[code & 0x0f]
			resource.diffRotate += rotation * TICK_DEGREE
			resource.totalRotate += rotation * TICK_DEGREE
		previousCode = currentCode
		time.sleep(0.002)


def startThread(gpio0, gpio1):
	global thread
	global resource
	print "Start Thread"
	resource = Resource()
	thread = threading.Thread(target=loop, args=(gpio0, gpio1, resource))
	thread.daemon = True
	thread.start()