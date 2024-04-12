package com.codingdojo.server.models;

import java.math.BigDecimal;

public class CartItem {
    private Long id;
    private String name;
    private String image;
    private int quantity;
    private BigDecimal price;
    private BigDecimal subtotal;

    public CartItem(Long id, String name, String image, int quantity, BigDecimal price, BigDecimal subtotal) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.quantity = quantity;
        this.price = price;
        this.subtotal = subtotal;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = BigDecimal.valueOf(price);
    }


    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public CartItem() {
    }


    public BigDecimal getSubtotal() {
        return price.multiply(new BigDecimal(quantity));
    }
}