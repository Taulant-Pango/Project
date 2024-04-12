package com.codingdojo.server.services;

import com.codingdojo.server.models.CartItem;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
@SessionScope
public class CartService {
    private List<CartItem> cartItems;

    @PostConstruct
    public void init() {
        cartItems = new ArrayList<>();
    }

    public void addToCart(CartItem item) {
        CartItem existingItem = cartItems.stream()
                .filter(cartItem -> cartItem.getId().equals(item.getId()))
                .findFirst()
                .orElse(null);
        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + 1);
            existingItem.setSubtotal(existingItem.getSubtotal().add(item.getPrice()));
        } else {
            cartItems.add(item);
        }
    }


    public void removeFromCart(Long itemId) {
        cartItems.removeIf(item -> item.getId().equals(itemId));
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public BigDecimal getTotalAmount() {
        return cartItems.stream()
                .map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public void updateCartItemQuantity(Long productId, int quantity) {
        for (CartItem item : cartItems) {
            if (item.getId().equals(productId)) {
                item.setQuantity(quantity);
                item.setSubtotal(item.getPrice().multiply(BigDecimal.valueOf(quantity)));
                break;
            }
        }
    }

}
