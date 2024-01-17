package com.betaplan.taulant.housetest.repositories;

import com.betaplan.taulant.housetest.models.Cart;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartRepo extends CrudRepository<Cart, Long> {
    List<Cart> findAll();
}
