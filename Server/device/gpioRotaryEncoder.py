import threading
import time

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
	while True:
		resource.diffRotate = resource.diffRotate + 10
		resource.totalRotate += resource.diffRotate
		time.sleep(1.01)


def startThread(gpio0, gpio1):
	global thread
	global resource
	print "Start Thread"
	resource = Resource()
	thread = threading.Thread(target=loop, args=(gpio0, gpio1, resource))
	thread.daemon = True
	thread.start()