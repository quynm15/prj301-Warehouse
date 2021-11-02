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
public class ReceiptDetail {
    private int receiptID;
    private Product product;
    private double unitPrice;
    private double quantity;
    private double inStock;
    private Date mgf;
    private Date exp;
    private String comment;

    public ReceiptDetail() {
    }

    public ReceiptDetail(int receiptID, Product product, double unitPrice, double inStock, double quantity, Date mgf, Date exp, String comment) {
        this.receiptID = receiptID;
        this.product = product;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.inStock = inStock;
        this.mgf = mgf;
        this.exp = exp;
        this.comment = comment;
    }

    public double getInStock() {
        return inStock;
    }

    public void setInStock(double inStock) {
        this.inStock = inStock;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getReceiptID() {
        return receiptID;
    }

    public void setReceiptID(int receiptID) {
        this.receiptID = receiptID;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public Date getMgf() {
        return mgf;
    }

    public void setMgf(Date mgf) {
        this.mgf = mgf;
    }

    public Date getExp() {
        return exp;
    }

    public void setExp(Date exp) {
        this.exp = exp;
    }
    
    
}
