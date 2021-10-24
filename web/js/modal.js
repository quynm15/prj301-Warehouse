/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function passCateInfo(id, name, desc, active) {
    document.getElementById("updateID").value = "" + id;
    document.getElementById("updateIDSent").value = "" + id;
    document.getElementById("updateName").value = "" + name;
    document.getElementById("updateDesc").value = "" + desc;
    var status = document.getElementById("updateStatus");
    if (active) {
        status.checked = true;
        status.value = "active";
    } else {
        status.checked = false;
    }
}

function passToDelete(id){
    document.getElementById("confirmDelete").href = "category/update?id="+id;
}
function passToInactive(id){
    document.getElementById("confirmInactive").href = "category/inactive?id="+id;
}

