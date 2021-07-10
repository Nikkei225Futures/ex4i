
var startTime = Date.now();
window.onload = function(){
    var startTime = Date.now();
    console.log(startTime);
    counting = setInterval("changeColor()", 500);
}
function changeColor(){
    var target = document.getElementById("css");
    var currentTime = Date.now();
    var passed = currentTime - startTime;
    console.log(passed);
    if(passed < 20000){
        target.setAttribute("href", "./css/s2-red.css");
    }else if(passed >= 2000 && passed < 40000){
        target.setAttribute("href", "./css/s2-orange.css");
    }else if(passed > 60000){
        clearInterval(counting);
    }else{
        target.setAttribute("href", "./css/s2-gray.css");
    }
}