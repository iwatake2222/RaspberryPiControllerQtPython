import sys

sys.path.append("./device")
#sys.path.append("./deviceMock")
from gpioPWM import *
from gpioInOut import *
import gpioRotaryEncoder
from i2cAccel import *


# portmap
portLed = (17, 27)
portColor = (23, 24, 25)
portMotor = (16, )
portServo = (26, )
portButton = (5, 6)
portRotaryEncoder = (13, 12)
i2cAddressAccel = 0x53

# PWM setting
PWM_PERIOD_MS = 5

# Servo PWM setting
SERVO_PERIOD_MS = 14
SERVO_ACTIVE_PERIOD_MIN_MS = 0.5
SERVO_ACTIVE_PERIOD_MAX_MS = 2.5


def led(index, onoff):
	gpioOut(portLed[index], onoff)


def ledColor(r, g, b):
	setPwm(portColor[0], r, PWM_PERIOD_MS)
	setPwm(portColor[1], g, PWM_PERIOD_MS)
	setPwm(portColor[2], b, PWM_PERIOD_MS)


def motorPwm(speed):
	setPwm(portMotor[0], speed, PWM_PERIOD_MS)


def servo(position):
	duty = (SERVO_ACTIVE_PERIOD_MAX_MS - SERVO_ACTIVE_PERIOD_MIN_MS) * position / 100.0 + SERVO_ACTIVE_PERIOD_MIN_MS
	duty = duty / SERVO_PERIOD_MS * 100
	setPwm(portServo[0], duty, SERVO_PERIOD_MS)


def button(index):
	return gpioIn(portButton[index])


def rotaryEncoder():
	return gpioRotaryEncoder.getDiffRotate(portRotaryEncoder[0], portRotaryEncoder[1])


def tap():
	return getTap(i2cAddressAccel)


def GSensor():
	return getAccel(i2cAddressAccel)
