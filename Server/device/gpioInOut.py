import RPi.GPIO as GPIO

initializedList = []

def gpioOut(gpio, out):
	if gpio not in initializedList:
		GPIO.setwarnings(False)
		GPIO.setmode(GPIO.BCM)
		GPIO.setup(gpio, GPIO.OUT)
		initializedList.append(gpio)
	print (str(gpio) + " is set to " + str(out))
	if out is False:
		GPIO.output(gpio, GPIO.LOW)
	else:
		GPIO.output(gpio, GPIO.HIGH)


def gpioIn(gpio):
	if gpio not in initializedList:
		GPIO.setwarnings(False)
		GPIO.setmode(GPIO.BCM)
		GPIO.setup(gpio, GPIO.IN, pull_up_down=GPIO.PUD_UP)
		initializedList.append(gpio)
	val = GPIO.input(gpio)
	print (str(gpio) + " is " + str(val))
	if val == 0:
		return False
	else:
		return True
