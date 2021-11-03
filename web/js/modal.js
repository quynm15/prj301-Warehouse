/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function passCateInfo(id, name, desc, active) {
    document.getElementById("cateID").value = "" + id;
    if (document.getElementById("cateIDSent") != null)
        document.getElementById("cateIDSent").value = "" + id;
    document.getElementById("cateName").value = "" + name;
    document.getElementById("cateDesc").value = "" + desc;
    var status = document.getElementById("cateStatus");
    if (active) {
        status.checked = true;
        status.value = "on";
    } else {
        status.checked = false;
    }
}

function passToDeleteCategory(id) {
    document.getElementById("confirmDelete").href = "category/update?id=" + id;
}
function passToInactiveCategory(id) {
    document.getElementById("confirmInactive").href = "category/inactive?id=" + id;
}

function passSupplierInfo(id, companyName, contactName, phone, email, address, district, province, active, comment) {
    document.getElementById("supID").value = "" + id;
    if (document.getElementById("supIDSent") != null)
        document.getElementById("supIDSent").value = "" + id;
    document.getElementById("supCompanyName").value = "" + companyName;
    document.getElementById("supContactName").value = "" + contactName;
    document.getElementById("supPhone").value = "" + phone;
    document.getElementById("supEmail").value = "" + email;
    document.getElementById("supAddress").value = "" + address;
    document.getElementById("supDistrict").value = "" + district;
    document.getElementById("supProvince").value = "" + province;
    document.getElementById("supComment").value = "" + comment;
    var status = document.getElementById("supStatus");
    if (active) {
        status.checked = true;
        status.value = "on";
    } else {
        status.checked = false;
    }
}

function passToDeleteSupplier(id) {
    document.getElementById("confirmDelete").href = "supplier/update?id=" + id;
}
function passToInactiveSupplier(id) {
    document.getElementById("confirmInactive").href = "supplier/inactive?id=" + id;
}

function passProInfo(id, name, category, supplier, unit, quantity, unitPrice, active, comment) {
    document.getElementById("proID").value = "" + id;
    if (document.getElementById("proIDSent") != null)
        document.getElementById("proIDSent").value = "" + id;
    document.getElementById("proName").value = "" + name;
    document.getElementById("proCategory").value = "" + category;
    document.getElementById("proSupplier").value = "" + supplier;
    document.getElementById("proUnit").value = "" + unit;
    document.getElementById("proQuantity").value = "" + quantity;
    document.getElementById("proQuantitySent").value = "" + quantity;
    document.getElementById("proUnitPrice").value = "" + unitPrice;
    document.getElementById("proComment").value = "" + comment;
    var status = document.getElementById("proStatus");
    if (active) {
        status.checked = true;
        status.value = "on";
    } else {
        status.checked = false;
    }
}

function passToDeleteProduct(id) {
    document.getElementById("confirmDelete").href = "product/update?id=" + id;
}
function passToInactiveProduct(id) {
    document.getElementById("confirmInactive").href = "product/inactive?id=" + id;
}

function passToDeleteReceipt(id) {
    document.getElementById("confirmDelete").href = "receipt/delete?id=" + id;
}