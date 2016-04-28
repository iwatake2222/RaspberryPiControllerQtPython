
function monitor() {
    callApiButton(0, function(index, onoff){button0.pushed = onoff});
    callApiButton(1, function(index, onoff){button1.pushed = onoff});
    callApiRotaryEncoder(function(rotate){rotaryEncoder.rotation+=rotate});
    callApiTap(function(tapNum){
        if (tapNum === 1) {
            tap.singleTap()
        } else if (tapNum === 2) {
            tap.doubleTap()
        }
    });
    callApiGSensor(function(x, y, z){
        object3D.rotate(x,y,z)
    });

}


function callApiLed(index, state) {
    callApi(
        'http://192.168.0.144:8080/led',
        {"index": index, "onoff": state===false?"off":"on"});
}

function callApiLed3Color(r, g, b) {
    callApi(
        'http://192.168.0.144:8080/ledColor',
        {"r": r, "g": g, "b": b});
}

function callApiMotorPwm(speed) {
    callApi(
        'http://192.168.0.144:8080/motorPwm',
        {"speed": speed});
}

function callApiServo(position) {
    callApi(
        'http://192.168.0.144:8080/servo',
        {"position": position});
}

function callApiButton(index, cb) {
    callApi(
        'http://192.168.0.144:8080/button',
        {"index": index},
        function (o) {
            //console.log(o.responseText);
            var retJson = eval('new Object(' + o.responseText + ')');
            //console.log(retJson.onoff)
            if(retJson.onoff !== "off")
                cb(index, false)
            else
                cb(index, true)
        });
}

function callApiRotaryEncoder(cb) {
    callApi(
        'http://192.168.0.144:8080/rotaryEncoder',
        {"dummy": 0},
        function (o) {
            //console.log(o.responseText);
            var retJson = eval('new Object(' + o.responseText + ')');
            cb(retJson.rotate)
        });
}

function callApiTap(cb) {
    callApi(
        'http://192.168.0.144:8080/tap',
        {"dummy": 0},
        function (o) {
            console.log(o.responseText);
            var retJson = eval('new Object(' + o.responseText + ')');
            cb(retJson.tapNum)
        });
}

function callApiGSensor(cb) {
    callApi(
        'http://192.168.0.144:8080/GSensor',
        {"dummy": 0},
        function (o) {
            console.log(o.responseText);
            var retJson = eval('new Object(' + o.responseText + ')');
            cb(retJson.x, retJson.y, retJson.z)
        });
}

function callApi(url, jsonObj, callback) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', url);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.setRequestHeader('Accept', 'application/json');

    xhr.onreadystatechange = (function(myxhr) {
        return function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                if(callback !== undefined) {
                    callback(myxhr);
                }
            }
        }

    })(xhr);

    xhr.send(JSON.stringify(jsonObj));
}
