package com.betaplan.taulant.housetest.models;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

public class LoginUser {
    @NotEmpty(message = "Email is required")
    @Email(message = "Please provide a valid email")
    public String email;
    @NotEmpty(message = "Password is required")
    @Size(min = 8, max = 255, message = "Password must be between 8 and 255")
    private String password;
    // Empty Constructor
    public LoginUser(){}
    // Getter and setter
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
}
