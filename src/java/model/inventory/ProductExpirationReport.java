/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.inventory;

import java.sql.Date;

/**
 *
 * @author quynm
 */
public class ProductExpirationReport extends Product{
    private int dateDiff;
    private double inStock;
    private Date expDate;
    private Date receiptDate;

    public ProductExpirationReport() {
    }

    public ProductExpirationReport(int dateDiff, double inStock, Date expDate, Date receiptDate) {
        this.dateDiff = dateDiff;
        this.inStock = inStock;
        this.expDate = expDate;
        this.receiptDate = receiptDate;
    }

    public int getDateDiff() {
        return dateDiff;
    }

    public void setDateDiff(int dateDiff) {
        this.dateDiff = dateDiff;
    }

    public double getInStock() {
        return inStock;
    }

    public void setInStock(double inStock) {
        this.inStock = inStock;
    }

    public Date getExpDate() {
        return expDate;
    }

    public void setExpDate(Date expDate) {
        this.expDate = expDate;
    }

    public Date getReceiptDate() {
        return receiptDate;
    }

    public void setReceiptDate(Date receiptDate) {
        this.receiptDate = receiptDate;
    }
    
}
