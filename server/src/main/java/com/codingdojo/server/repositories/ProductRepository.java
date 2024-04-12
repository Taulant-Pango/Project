package com.codingdojo.server.repositories;


import com.codingdojo.server.models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends CrudRepository<Product, Long> {
    List<Product> findAll();

    Optional<Product> findByName(String name);

    Optional<Product> findById(Long id);


    @Query("SELECT p FROM Product p WHERE p.cart = true AND p.user.id = :userId")
    List<Product> findCartProductsByUserId(@Param("userId") Long userId);

    @Query("SELECT p FROM Product p WHERE lower(p.name) LIKE lower(concat('%', :searchTerm, '%'))")
    List<Product> findBySearchTerm(@Param("searchTerm") String searchTerm);
}
