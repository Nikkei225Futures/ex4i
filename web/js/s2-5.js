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

    let i = 0;
    let j = children.length-1;

    for(k = 0; k < (children.length-1)/2; k++){
        temp = children[i].innerHTML;
        children[i].innerHTML = children[j].innerHTML;
        children[j].innerHTML = temp;
        i++;
        j--;
    }

}