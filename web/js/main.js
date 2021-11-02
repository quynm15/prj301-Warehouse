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
    var prevPage = pageIndex - 1;
    var nextPage = pageIndex + 1;
    if (container != null) {
        container.innerHTML += "<a id='firstPagger' class='pagger__link' href='product/list?page=1'><span class='material-icons'>first_page</span></a>";
        container.innerHTML += "<a id='prevPagger' class='pagger__link' href='product/list?page=" + prevPage + "'><span class='material-icons'>chevron_left</span></a>";
        if (pageIndex <= 1) {
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
        if (pageIndex >= totalPages) {
//            document.getElementById("nextPagger").classList.add("pagger__link--disable");
            document.getElementById("nextPagger").removeAttribute("href");
//            document.getElementById("lastPagger").classList.add("pagger__link--disable");
            document.getElementById("lastPagger").removeAttribute("href");
        }
    }
}

//This part is for delivery/receipt activity

function addReceiptProductRow() {
    var list = document.getElementById("productList");
    var lastRow = document.getElementById("lastRow");
    var newNode = document.createElement("tr");
    newNode.classList.add("content__list-receipt-row");

    var col;
    var input;
    //id
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    input = document.createElement("input");
    input.classList.add("content__list-receipt-col-input");
    input.type = "text";
    input.name = "productID";
    input.required = "true";
    input.setAttribute("onchange", "getProductInfo(this)");
    col.appendChild(input);
    newNode.appendChild(col);
    //name
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    input = document.createElement("input");
    input.classList.add("content__list-receipt-col-input");
    input.type = "text";
    input.name = "productName";
    col.appendChild(input);
    newNode.appendChild(col);
    //unit
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    input = document.createElement("input");
    input.classList.add("content__list-receipt-col-input");
    input.type = "text";
    input.name = "productUnit";
    col.appendChild(input);
    newNode.appendChild(col);
    //unitPrice
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    input = document.createElement("input");
    input.classList.add("content__list-receipt-col-input");
    input.type = "text";
    input.name = "productUnitPrice";
    input.required = "true";
    col.appendChild(input);
    newNode.appendChild(col);
    //quantity
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    input = document.createElement("input");
    input.classList.add("content__list-receipt-col-input");
    input.type = "text";
    input.name = "quantity";
    input.required = "true";
    col.appendChild(input);
    newNode.appendChild(col);
    //mgf
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    input = document.createElement("input");
    input.classList.add("content__list-receipt-col-input");
    input.type = "date";
    input.name = "mgf";
    col.appendChild(input);
    newNode.appendChild(col);
    //exp
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    input = document.createElement("input");
    input.classList.add("content__list-receipt-col-input");
    input.type = "date";
    input.name = "exp";
    col.appendChild(input);
    newNode.appendChild(col);
    //comment
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    input = document.createElement("input");
    input.classList.add("content__list-receipt-col-input");
    input.type = "text";
    input.name = "commentProduct";
    col.appendChild(input);
    newNode.appendChild(col);
    //delete
    col = document.createElement("td");
    col.classList.add("content__list-receipt-col");
    col.setAttribute("onclick", "deleteRow(this)");
    var deleteBtn = document.createElement("a");
    deleteBtn.classList.add("button--small");
    deleteBtn.classList.add("button--transparent");
    deleteBtn.setAttribute("data-toggle", "modal");
    deleteBtn.setAttribute("data-target", "#modalConfirmDelete");
    var icon = document.createElement("span");
    icon.classList.add("lnr");
    icon.classList.add("lnr-trash");
    deleteBtn.appendChild(icon);
    col.appendChild(deleteBtn);
    newNode.appendChild(col);

    list.insertBefore(newNode, lastRow);
}

function addDeliveryProductRow() {
    var list = document.getElementById("productList");
    var lastRow = document.getElementById("lastRow");
    var newNode = document.createElement("tr");
    newNode.classList.add("content__list-delivery-row");

    var col;
    var input;
    //id
    col = document.createElement("td");
    col.classList.add("content__list-delivery-col");
    input = document.createElement("input");
    input.classList.add("content__list-delivery-col-input");
    input.type = "text";
    input.name = "productID";
    input.required = "true";
    input.setAttribute("onchange", "getProductInfo(this)");
    col.appendChild(input);
    newNode.appendChild(col);
    //name
    col = document.createElement("td");
    col.classList.add("content__list-delivery-col");
    input = document.createElement("input");
    input.classList.add("content__list-delivery-col-input");
    input.type = "text";
    input.name = "productName";
    col.appendChild(input);
    newNode.appendChild(col);
    //unit
    col = document.createElement("td");
    col.classList.add("content__list-delivery-col");
    input = document.createElement("input");
    input.classList.add("content__list-delivery-col-input");
    input.type = "text";
    input.name = "productUnit";
    col.appendChild(input);
    newNode.appendChild(col);
    //unitPrice
    col = document.createElement("td");
    col.classList.add("content__list-delivery-col");
    input = document.createElement("input");
    input.classList.add("content__list-delivery-col-input");
    input.type = "text";
    input.name = "productUnitPrice";
    input.required = "true";
    col.appendChild(input);
    newNode.appendChild(col);
    //quantity
    col = document.createElement("td");
    col.classList.add("content__list-delivery-col");
    input = document.createElement("input");
    input.classList.add("content__list-delivery-col-input");
    input.type = "text";
    input.name = "quantity";
    input.setAttribute("onkeydown", "checkOverQuantityToDelivery(this.parentNode.parentNode)");
    input.required = "true";
    col.appendChild(input);
    newNode.appendChild(col);
    //comment
    col = document.createElement("td");
    col.classList.add("content__list-delivery-col");
    input = document.createElement("input");
    input.classList.add("content__list-delivery-col-input");
    input.type = "text";
    input.name = "commentProduct";
    col.appendChild(input);
    newNode.appendChild(col);
    //delete
    col = document.createElement("td");
    col.classList.add("content__list-delivery-col");
    col.setAttribute("onclick", "deleteRow(this)");
    var deleteBtn = document.createElement("a");
    deleteBtn.classList.add("button--small");
    deleteBtn.classList.add("button--transparent");
    deleteBtn.setAttribute("data-toggle", "modal");
    deleteBtn.setAttribute("data-target", "#modalConfirmDelete");
    var icon = document.createElement("span");
    icon.classList.add("lnr");
    icon.classList.add("lnr-trash");
    deleteBtn.appendChild(icon);
    col.appendChild(deleteBtn);
    newNode.appendChild(col);

    list.insertBefore(newNode, lastRow);
}

function deleteRow(td) {
    if (document.getElementById("confirmDelete") != null) {
        document.getElementById("confirmDelete").onclick = function () {
            td.parentNode.remove();
            $('#modalConfirmDelete').modal('hide');
        };
    }
}

function getProductInfo(input) {
    var pid = input.value;
    var td = input.parentNode;
    var tr = td.parentNode;

    var name = tr.childNodes[1].childNodes[0];
    var unit = tr.childNodes[2].childNodes[0];
    var unitPrice = tr.childNodes[3].childNodes[0];
    $.ajax({
        type: "GET",
        data: {id: pid},
        url: "get-product-info",
        success: function (responseJson) {
            if (responseJson.id != null) {
                input.style.color = 'unset';
                name.value = responseJson.name;
                name.disabled = "true";
                unit.value = responseJson.unit;
                unit.disabled = "true";
                unitPrice.value = responseJson.unitPrice;
                checkOverQuantityToDelivery(tr);
            } else {
                input.style.color = 'red';
                name.removeAttribute("disabled");
                unit.removeAttribute("disabled");
            }
        }
    });
}

function checkOverQuantityToDelivery(row) {
    var cols = row.children;
    var pidValue = cols[0].children[0].value;
    var quantityInput = cols[4].children[0];
    $.ajax({
        type: "GET",
        data: {id: pidValue},
        url: "get-product-info",
        success: function (responseJson) {
            if (responseJson.id != null) {
                if (responseJson.quantity < quantityInput.value) {
                    //if over, set the color to red
                    quantityInput.style.color = 'red';
                } else {
                    quantityInput.style.color = 'unset';
                }
            }
        }
    });
}

function validateSubmit(list) {
    var list = document.getElementById(list);
    var flagID = true;
    var flagUnitPrice = true;
    var flagQuantity = true;
    var flagOverQuantity = true;
    //first row is header and last row is add row
    var rows = list.children;
    for (var i = 1; i < rows.length - 1; i++) {
        checkOverQuantityToDelivery(rows[i]);
        var cols = rows[i].children;
        //col 0 is the first col (productID)
        //col 3 is the unitPrice col
        //col 4 is the quantity col
        //the input is the first children of col
        //--> if the input is red or blank, cannot submit the form
        var proID = cols[0].children[0];
        var unitPrice = cols[3].children[0];
        var quantity = cols[4].children[0];
        if (proID.style.color == 'red' || proID.value.trim() == '') {
            flagID = false;
            break;
        }
        //isNumeric is a jquery function to check the data is a number or not (include fraction number)
        if (!$.isNumeric(unitPrice.value) || unitPrice.value < 0) {
            flagUnitPrice = false;
            break;
        }
        if (!$.isNumeric(quantity.value) || quantity.value < 0) {
            flagQuantity = false;
            break;
        }
        if (quantity.style.color == 'red') {
            flagOverQuantity = false;
            break;
        }
    }

    if (flagID && flagUnitPrice && flagQuantity && flagOverQuantity) {
        document.getElementById("createForm").submit();
    } else {
        if (!flagID)
            document.getElementById("errorSubmit").innerHTML = "Cannot create because some products are invalid or blank!<br/>";
        if (!flagUnitPrice)
            document.getElementById("errorSubmit").innerHTML = "Unit price must be a positive number!<br/>";
        if (!flagQuantity)
            document.getElementById("errorSubmit").innerHTML = "Quantity must be a positive number!<br/>";
        if (!flagOverQuantity)
            document.getElementById("errorSubmit").innerHTML = "There is a quantity which over instock!<br/>";
    }
}


