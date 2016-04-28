#!/bin/env python
# coding: utf-8
import os
import sys
import json
from bottle import route, run, request, HTTPResponse
from deviceIFMock import *

@route('/')
def root():
	return 'Hello'


@route('/led', method='POST')
def ledIf():
	var = request.json
	# print (var)
	index = int(var["index"])
	if var["onoff"] == "off":
		onoff = False
	else:
		onoff = True
	led(index, onoff)


@route('/ledColor', method='POST')
def ledColorIf():
	var = request.json
	# print (var)
	ledColor(int(var["r"]), int(var["g"]), int(var["b"]))


@route('/motorPwm', method='POST')
def motorPwmIf():
	var = request.json
	# print (var)
	motorPwm(int(var["speed"]))


@route('/servo', method='POST')
def servoIf():
	var = request.json
	# print (var)
	servo(int(var["position"]))


@route('/button', method='POST')
def buttonIf():
	var = request.json
	# print (var)
	index = int(var["index"])
	onoff = button(index)
	retBody = {
		"ret": "ok",
		"onoff": onoff
	}
	r = HTTPResponse(status=200, body=retBody)
	r.set_header('Content-Type', 'application/json')
	return r


@route('/rotaryEncoder', method='POST')
def rotaryEncoderIf():
	var = request.json
	# print (var)
	rotate = rotaryEncoder()
	retBody = {
		"ret": "ok",
		"rotate": rotate
	}
	r = HTTPResponse(status=200, body=retBody)
	r.set_header('Content-Type', 'application/json')
	return r


@route('/tap', method='POST')
def tapIf():
	var = request.json
	# print (var)
	tapNum = tap()
	retBody = {
		"ret": "ok",
		"tapNum": tapNum
	}
	r = HTTPResponse(status=200, body=retBody)
	r.set_header('Content-Type', 'application/json')
	return r


@route('/GSensor', method='POST')
def GSensorIf():
	var = request.json
	# print (var)
	xyz = GSensor()
	retBody = {
		"ret": "ok",
		"x": xyz[0],
		"y": xyz[1],
		"z": xyz[2],
	}
	r = HTTPResponse(status=200, body=retBody)
	r.set_header('Content-Type', 'application/json')
	return r


if __name__ == '__main__':
	print('Server Start')
	run(host='0.0.0.0', port=8080, debug=True, reloader=True)
	# run(host='0.0.0.0', port=8080, debug=True, reloader=False)
