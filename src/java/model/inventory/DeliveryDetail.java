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
public class DeliveryDetail {
    private int deliveryID;
    private Product product;
    private double quantity;
    private String comment;

    public DeliveryDetail() {
    }

    public DeliveryDetail(int deliveryID, Product product, double quantity, String comment) {
        this.deliveryID = deliveryID;
        this.product = product;
        this.quantity = quantity;
        this.comment = comment;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getDeliveryID() {
        return deliveryID;
    }

    public void setDeliveryID(int deliveryID) {
        this.deliveryID = deliveryID;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }
    
}
