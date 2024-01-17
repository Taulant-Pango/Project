package com.betaplan.taulant.housetest.services;

import com.betaplan.taulant.housetest.models.Cart;
import com.betaplan.taulant.housetest.repositories.CartRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {
    @Autowired
    private CartRepo cartRepo;

    public Cart create(Cart cart){
        return cartRepo.save(cart);
    }

    public List<Cart> allCarts(){
        return cartRepo.findAll();
    }

    public Cart findCart(Long id){
        return cartRepo.findById(id).orElse(null);
    }

    public Cart update(Cart cart){
        return cartRepo.save(cart);
    }
    public void deleteCart(Cart cart){
        cartRepo.delete(cart);
    }
}
