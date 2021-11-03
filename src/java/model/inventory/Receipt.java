/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.inventory;

import java.sql.Date;
import java.sql.Time;
import model.account.Account;

/**
 *
 * @author quynm
 */
public class Receipt {
    private int id;
    private Date date;
    private Time time;
    private Account importer;
    private Supplier supplier;
    private String shipper;
    private String comment;
    private double value;

    public Receipt() {
    }

    public Receipt(int id, Date date, Time time, Account importer, Supplier supplier, String shipper, String comment) {
        this.id = id;
        this.date = date;
        this.time = time;
        this.importer = importer;
        this.supplier = supplier;
        this.shipper = shipper;
        this.comment = comment;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public Account getImporter() {
        return importer;
    }

    public void setImporter(Account importer) {
        this.importer = importer;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public String getShipper() {
        return shipper;
    }

    public void setShipper(String shipper) {
        this.shipper = shipper;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }
    
    
}
