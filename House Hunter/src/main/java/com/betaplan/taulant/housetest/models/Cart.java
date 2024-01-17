package com.betaplan.taulant.housetest.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Past;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Entity
 @Table(name = "carts")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotBlank(message = "Address must not be empty")
    private String address;
    @Min(value = 1)
    private double price;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Past
    private Date createdAt;
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    // many to one connection cart with user
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    // empty and loaded constructor
    public Cart(){}

    public Cart(Long id, String address, double price, Date createdAt, User user) {
        this.id = id;
        this.address = address;
        this.price = price;
        this.createdAt = createdAt;
        this.user = user;
    }

    // Getter and setter

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
