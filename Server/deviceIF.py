# todo

def led(index, onoff):
	print (index)
	print (onoff)

def ledColor(r, g, b):
	print (r)
	print (g)
	print (b)

def motorPwm(speed):
	print (speed)

def servo(position):
	print (position)

i=0

def button(index):
	global i
	i = i+1
	if i%3 == 0:
		return "on"
	else:
		return "off"

def rotaryEncoder():
	return -10

def tap():
	return 1

def GSensor():
	return (20, 0, 20)
