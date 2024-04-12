package com.codingdojo.server.repositories;

import com.codingdojo.server.models.Review;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReviewRepository extends CrudRepository<Review, Long> {
    List<Review> findByProductIdOrderByReviewDesc(Long productId);
    Optional<Review> findByUserIdAndProductId(Long userId, Long productId);
}

