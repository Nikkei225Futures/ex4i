function getTime() {
    var target = document.getElementById("list");
    var newList = document.createElement("li");
    var dateTime = new Date();
    var hour = dateTime.getHours();
    var min = dateTime.getMinutes();
    var sec = dateTime.getSeconds();
    newList.innerHTML = hour + "時" + min + "分" + sec + "秒";
    target.appendChild(newList);
    
}