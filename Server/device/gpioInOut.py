def gpioOut(gpio, out):
	print (str(gpio) + " is set to " + str(out))


i=0
def gpioIn(gpio):
	global i
	i = i+1
	if i%3 == 0:
		return True
	else:
		return False
