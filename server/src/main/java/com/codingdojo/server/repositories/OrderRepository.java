package com.codingdojo.server.repositories;

import com.codingdojo.server.models.Order;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends CrudRepository<Order, Long> {
    List<Order> findAll();
    List<Order> findByUserId(Long userId);

    Optional<Order> findByPaypalOrderId(String paypalOrderId);

}