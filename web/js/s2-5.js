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
    
    invSortList();
}

function invSortList(){
    var parent = document.getElementById("list");
    var children = parent.children;
    //console.log(children[children.length-1].innerHTML);
    
    //inverse sort
    for(let i = 0; i < children.length/2; i++){
        var temp = children[i].innerHTML;
        var str = children[children.length-1-i].innerHTML;
        children[i].innerHTML = str;
        children[children.length-1-i].innerHTML = temp;
    }

}