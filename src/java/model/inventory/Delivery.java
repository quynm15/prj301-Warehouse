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
public class Delivery {
    private int id;
    private Date date;
    private Time time;
    private Account exporter;
    private String recipient;
    private String comment;
    private double value;

    public Delivery() {
    }

    public Delivery(int id, Date date, Time time, Account exporter, String recipient, String comment) {
        this.id = id;
        this.date = date;
        this.time = time;
        this.exporter = exporter;
        this.recipient = recipient;
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

    public Account getExporter() {
        return exporter;
    }

    public void setExporter(Account exporter) {
        this.exporter = exporter;
    }

    public String getRecipient() {
        return recipient;
    }

    public void setRecipient(String recipient) {
        this.recipient = recipient;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }
    
    
}
