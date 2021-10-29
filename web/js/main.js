/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function submitForm(form) {
    document.getElementById(form).submit();
}

function createPaggerProduct(div, pageIndex, gap, totalPages) {
    var container = document.getElementById(div);
    var prevPage = pageIndex-1;
    var nextPage = pageIndex+1;
    if (container != null) {
        container.innerHTML += "<a id='firstPagger' class='pagger__link' href='product/list?page=1'><span class='material-icons'>first_page</span></a>";
        container.innerHTML += "<a id='prevPagger' class='pagger__link' href='product/list?page=" + prevPage + "'><span class='material-icons'>chevron_left</span></a>";
        if (pageIndex <= 1){
//            document.getElementById("firstPagger").classList.add("pagger__link--disable");
            document.getElementById("firstPagger").removeAttribute("href");
//            document.getElementById("prevPagger").classList.add("pagger__link--disable");
            document.getElementById("prevPagger").removeAttribute("href");
        }
        for (var i = pageIndex - gap; i < pageIndex; i++) {
            if (i > 0) {
                container.innerHTML += "<a class='pagger__link' href='product/list?page=" + i + "'>" + i + "</a>";
            }
        }
        container.innerHTML += "<a class='pagger__link pagger__link--active'>" + pageIndex + "</a>";
        for (var i = pageIndex + 1; i <= pageIndex + gap; i++) {
            if (i <= totalPages) {
                container.innerHTML += "<a class='pagger__link' href='product/list?page=" + i + "'>" + i + "</a>";
            }
        }
        container.innerHTML += "<a id='nextPagger' class='pagger__link' href='product/list?page=" + nextPage + "'><span class='material-icons'>chevron_right</span></i></a>";
        container.innerHTML += "<a id='lastPagger' class='pagger__link' href='product/list?page=" + totalPages + "'><span class='material-icons'>last_page</span></i></a>";
        if (pageIndex >= totalPages){
//            document.getElementById("nextPagger").classList.add("pagger__link--disable");
            document.getElementById("nextPagger").removeAttribute("href");
//            document.getElementById("lastPagger").classList.add("pagger__link--disable");
            document.getElementById("lastPagger").removeAttribute("href");
        }
    }
}

