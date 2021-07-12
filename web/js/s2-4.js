function getTime() {
    var target = document.getElementById("list");
    var newList = document.createElement("li");
    newList.innerHTML = new Date();
    target.appendChild(newList);
    
}

function clickHere() {
    var target = document.getElementById("list");
    var newList = document.createElement("li");
    newList.innerHTML = "clickHere";
    target.appendChild(newList);

}
