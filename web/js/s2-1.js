window.onload = function(){
    var ua = navigator.userAgent;
    var target = document.getElementById("browser");

    if(ua.indexOf("Firefox") != -1){
        target.innerHTML = "you are accessing this page via Firefox";
    }else{
        target.innerHTML = "you are NOT accessing this page via Firefox";
    }
}