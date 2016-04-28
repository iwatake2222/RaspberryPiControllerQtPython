import smbus

BUS_NUMBER = 1
i2cBus = None


def initAccel(address):
	global i2cBus
	i2cBus = smbus.SMBus(BUS_NUMBER)
	# init
	i2cBus.write_i2c_block_data(address, 0x2d, [0x00,])
	# range = +-2g, Left Justify, 10-bit mode(but will ignore tha right 2-bit)
	i2cBus.write_i2c_block_data(address, 0x31, [0x04,])
	# setings for tap (values are from data sheet)
	i2cBus.write_i2c_block_data(address, 0x1d, [0x60,])
	i2cBus.write_i2c_block_data(address, 0x21, [0x20,])
	i2cBus.write_i2c_block_data(address, 0x22, [0x20,])
	i2cBus.write_i2c_block_data(address, 0x23, [0x80,])
	# enable tap detection
	i2cBus.write_i2c_block_data(address, 0x2a, [0x07,])
	i2cBus.write_i2c_block_data(address, 0x2e, [0x60,])
	# start measurement
	i2cBus.write_i2c_block_data(address, 0x2d, [0x08,])


def getAccel(address):
	global i2cBus
	if i2cBus is None:
		initAccel(address)
	x = i2cBus.read_byte_data(address, 0x33)
	y = i2cBus.read_byte_data(address, 0x35)
	z = i2cBus.read_byte_data(address, 0x37)
	y -= 64
	x = 90 * x / 64
	y = 90 * y / 64
	z = 90 * z / 64
	# return (x, y, z)
	return (z, y, -x)


def getTap(address):
	global i2cBus
	if i2cBus is None:
		initAccel(address)
	data = i2cBus.read_byte_data(address, 0x30)
	if data & 0x20 != 0:
			accelTapNum = 2
	elif data & 0x40:
		accelTapNum = 1
	else:
		accelTapNum = 0
	return accelTapNum

