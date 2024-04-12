package com.codingdojo.server.services;

import com.codingdojo.server.models.Order;
import com.codingdojo.server.repositories.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    public Order saveOrder(Order order){
        return orderRepository.save(order);
    }
    public Optional<Order> findById(Long id) {
        return orderRepository.findById(id);
    }

    public List<Order> findAllOrders() {
        return (List<Order>) orderRepository.findAll();
    }

    public List<Order> findOrdersByUserId(Long userId) {
        return orderRepository.findByUserId(userId);
    }

    public boolean isOrderPaid(Long orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        return order.map(Order::getPaid).orElse(false);
    }

    public boolean isOrderDelivered(Long orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        return order.map(Order::getDelivered).orElse(false);
    }
    public Optional<Order> findByPaypalOrderId(String paypalOrderId) {
        return orderRepository.findByPaypalOrderId(paypalOrderId);
    }

    public void updateOrderWithPaypalOrderId(Long internalOrderId, String paypalOrderId) {
        Order order = orderRepository.findById(internalOrderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setPaypalOrderId(paypalOrderId);
        orderRepository.save(order);
    }

}
