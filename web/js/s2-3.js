window.onload = function () {
    var dateTime = new Date();
    var currentSec = dateTime.getSeconds();
    var target = document.getElementById("css");
    console.log(currentSec);

    if (currentSec < 20) {
        target.setAttribute("href", "./css/s2-orange.css");
    } else if (currentSec < 40) {
        target.setAttribute("href", "./css/s2-red.css");
    } else {
        target.setAttribute("href", "./css/s2-gray.css");
    }
}
