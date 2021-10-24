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
public class Product {
    private int id;
    private String name;
    private Category category;
    private Supplier supplier;
    private String unit;
    private double quantity;
    private double unitPrice;
    private String comment;
    private boolean active;

    public Product() {
    }

    public Product(int id, String name, Category category, Supplier supplier, String unit, double quantity, double unitPrice, String comment, boolean active) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.supplier = supplier;
        this.unit = unit;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
    
}
