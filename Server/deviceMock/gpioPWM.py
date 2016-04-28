import threading
import time


PERIOD_MS = 20
ACTIVE_PERIOD_MAX_MS = 0.5
ACTIVE_PERIOD_MIN_MS = 2.5
thread = None
resource = None

dictThread = {"dummy":0}
dictResource = {"dummy":0}


class Resource(object):
	def __init__(self, periodMs, dutyRatio=0):
		self.lock = threading.Lock()
		self.periodMs = periodMs
		self.dutyRatio = dutyRatio
	def setDutyRatio(self, value):
		self.lock.acquire()
		try:
			self.dutyRatio = value
		finally:
			self.lock.release()


def setPwm(gpio, dutyRatio, periodMs):
	global dictThread
	global dictResource
	if gpio not in dictThread:
		startPwm(gpio, periodMs, dutyRatio)
	dictResource[gpio].setDutyRatio(dutyRatio)


def loopPwm(gpio, resource):
	while True:
		#print "High"
		print resource.periodMs*resource.dutyRatio/100.0/1000.0
		print resource.periodMs*(1-resource.dutyRatio/100.0)/1000.0
		time.sleep(1.01)
		#time.sleep(resource.periodMs*resource.dutyRatio/100/1000)
		#print "Low"
		#time.sleep(resource.periodMs*(1-resource.dutyRatio/100)/1000)


def startPwm(gpio, periodMs, dutyRatio):
	global dictThread
	global dictResource
	print "Start Thread"
	dictResource[gpio] = Resource(periodMs, dutyRatio)
	dictThread[gpio] = threading.Thread(target=loopPwm, args=(gpio, dictResource[gpio]))
	dictThread[gpio].daemon = True
	dictThread[gpio].start()
