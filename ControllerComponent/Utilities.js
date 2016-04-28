
function calcInternalColor(colorStart, colorEnd, ratio) {
    var rStart = parseInt(String(colorStart).slice(1, 3), 16)
    var gStart = parseInt(String(colorStart).slice(3, 5), 16)
    var bStart = parseInt(String(colorStart).slice(5, 7), 16)
    var rEnd = parseInt(String(colorEnd).slice(1, 3), 16)
    var gEnd = parseInt(String(colorEnd).slice(3, 5), 16)
    var bEnd = parseInt(String(colorEnd).slice(5, 7), 16)
    var r = parseInt((rEnd - rStart)*ratio/100 + rStart, 10)
    var g = parseInt((gEnd - gStart)*ratio/100 + gStart, 10)
    var b = parseInt((bEnd - bStart)*ratio/100 + bStart, 10)
    r = ("00"+r.toString(16)).slice(-2)
    g = ("00"+g.toString(16)).slice(-2)
    b = ("00"+b.toString(16)).slice(-2)

    //console.log("#" + r + g + b )
    return "#" + r + g + b
}
