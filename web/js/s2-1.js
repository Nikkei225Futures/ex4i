window.onload = function(){
    var ua = navigator.userAgent;
    var target = document.getElementById("browser");

    if(ua.indexOf("Firefox") != -1){
        target.innerHTML = "今開いているブラウザはFirefoxです";
    }else{
        target.innerHTML = "今開いているブラウザはFirefoxではありません";
    }
}