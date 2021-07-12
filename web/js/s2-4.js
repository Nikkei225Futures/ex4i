function getTime() {
    var target = document.getElementById("list");
    var newList = document.createElement("li");
    var dateTime = new Date();
    var hour = dateTime.getHours();
    var min = dateTime.getMinutes();
    var sec = dateTime.getSeconds();
    var str = document.createTextNode(hour + "時" + min + "分" + sec + "秒");
    newList.appendChild(str);
    target.appendChild(newList);
    
}