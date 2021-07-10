window.onload = function(){
    var target = document.getElementById("css");
    var ua = navigator.userAgent;

    if(ua.indexOf("Firefox") != -1){
        target.setAttribute("href", "./css/s2-orange.css");
    }else if (ua.indexOf("Chrome")){
        target.setAttribute("href", "./css/s2-blue.css");
    }else{
        target.setAttribute("href", "./css/s2-gray.css");
    }
}