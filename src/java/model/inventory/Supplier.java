/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.inventory;

/**
 *
 * @author quynm
 */
public class Supplier {
    private int id;
    private String companyName;
    private String contactName;
    private String phone;
    private String email;
    private String address;
    private String province;
    private String distric;
    private String comment;
    private boolean active;

    public Supplier() {
    }

    public Supplier(int id, String companyName, String contactName, String phone, String email, String address, String province, String distric, String comment, boolean active) {
        this.id = id;
        this.companyName = companyName;
        this.contactName = contactName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.province = province;
        this.distric = distric;
        this.comment = comment;
        this.active = active;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistric() {
        return distric;
    }

    public void setDistric(String distric) {
        this.distric = distric;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
    
}
