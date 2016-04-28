#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from os.path import (
    join,
    dirname,
)

from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView

app = QGuiApplication(sys.argv)
view = QQuickView()

view.engine().quit.connect(app.quit)

url = QUrl(join(dirname(__file__), 'ControllerComponent/ControllerComponent.qml'))
view.setSource(url)
view.show()
sys.exit(app.exec_())
