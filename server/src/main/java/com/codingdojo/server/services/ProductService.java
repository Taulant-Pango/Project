package com.codingdojo.server.services;


import com.codingdojo.server.models.Product;
import com.codingdojo.server.models.Review;
import com.codingdojo.server.repositories.ProductRepository;
import com.codingdojo.server.repositories.ReviewRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    public Product findById(Long id){
        Optional<Product> result = productRepository.findById(id);
        if(result.isPresent()){
            return result.get();
        }
        return null;
    }

    public List<Product> getAll(){
        return productRepository.findAll();
    }

    public Product createProduct(Product product){
        Optional<Product> existingProduct = productRepository.findByName(product.getName());
        if (existingProduct.isPresent()) {
            throw new IllegalArgumentException("Product with the same title already exists");
        }
        return productRepository.save(product);
    }

    public Product updateProduct(Product product) {
        Optional<Product> existingProduct = productRepository.findByName(product.getName());
        if (existingProduct.isPresent() && !existingProduct.get().getId().equals(product.getId())) {
            throw new IllegalArgumentException("Product with the same title already exists");
        }
        return productRepository.save(product);
    }

    @Transactional
    public void deleteProduct(Long id){
        Optional<Product> optionalProduct = productRepository.findById(id);

        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();

            // Delete Review
            List<Review> reviews = reviewRepository.findByProductIdOrderByReviewDesc(id);
            for (Review review : reviews) {
                reviewRepository.delete(review);
            }

            // Delete the Product
            productRepository.delete(product);
        }
    }

    public List<Review> getReviewsForProduct(Long productId) {
        List<Review> reviews = reviewRepository.findByProductIdOrderByReviewDesc(productId);
        return reviews;
    }

    public Review addReview(Review review) {
        return reviewRepository.save(review);
    }


    public Optional<Review> findReviewsByUserAndProduct(Long userId, Long productId) {
        return reviewRepository.findByUserIdAndProductId(userId, productId);
    }

    public List<Product> getCartProductsByUserId(Long userId) {
        return productRepository.findCartProductsByUserId(userId);
    }

    public List<Product> searchProducts(String searchTerm) {
        return productRepository.findBySearchTerm(searchTerm);
    }
}
