<%--
  Created by IntelliJ IDEA.
  User: Artan
  Date: 2/4/2024
  Time: 4:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    .center-align img,
    .center-align iframe {
        max-width: 200px;
        max-height: 500px;
        width: 100%;
    }
    .product-image {
        max-width: 100%;
        display: block;
        margin: 0 auto;
    }
    .product-info {
        background: #fff;
        padding: 20px;
        border-radius: 5px;
    }
    .size-selector button {
        margin: 0 5px;
        background: #f8f9fa;
        border: 1px solid #dee2e6;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
    }
    .size-selector button.active {
        background: #000;
        color: #fff;
    }
    .product-action {
        margin-top: 20px;
    }
    .product-action {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 20px;
    }

    .btn-heart .fa-heart {
        color: #ff0000;
    }

    .btn-add-to-bag {
        background-color: #000;
        color: #fff;
        padding: 20px 20px;
        border-color: #000;
        border-radius: 50px;
        font-size: 16px;
        width: 350px;
        margin-top: 10px;
    }


    .reviews-container {
        margin-top: 20px;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
    }

    .reviews-container h5 {
        margin-bottom: 16px;
        color: #333;
        font-weight: bold;
    }

    .review {
        display: flex;
        flex-direction: column;
        padding-bottom: 12px;
        margin-bottom: 12px;
        border-bottom: 1px solid #eaeaea;
        position: relative;
    }

    .review strong {
        color: #333;
        font-weight: bold;

    }

    .review-date {
        color: #666;
        font-size: 0.875rem;
        position: absolute;
        top: 0;
        right: 0;
    }

    .review-content {
        color: #333;
        line-height: 1.5;
        margin-top: 8px;
        padding-right: 100px;
    }


    .product-description {
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 8px;
        margin-top: 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .product-description h5 {
        margin-bottom: 15px;
        color: #333;
        font-weight: 600;
    }

    .product-description p {
        color: #666;
        line-height: 1.6;
        font-size: 1rem;
    }
    .review-form-container {
        margin-top: 20px;
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .form-group {
        margin-bottom: 1rem;
    }

    .form-group label {
        font-weight: 600;
        display: block;
        margin-bottom: .5rem;
    }

    .form-control {
        display: block;
        width: 100%;
        padding: .375rem .75rem;
        font-size: 1rem;
        line-height: 1.5;
        color: #495057;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid #ced4da;
        border-radius: .25rem;
        transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
    }

    .form-control:focus {
        color: #495057;
        background-color: #fff;
        border-color: #80bdff;
        outline: 0;
        box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
    }


    .btn-primary {
        color: #fff;
        background-color: #000;
        border-color: #000;
    }


    .btn-primary:hover {
        color: #fff;
        background-color: #5a6268;
        border-color: #545b62;
    }

    .mt-2 {
        margin-top: .5rem;
    }

    .btn-back-to-products {
        color: #fff;
        background-color: #000;
        border-color: #000;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
        margin-right: 10px;
    }

    .btn-back-to-products:hover, .btn-cart:hover, .btn-add-to-bag:hover{
        background-color: #ffffff;
        color: #000000;
    }

    .btn-cart {
        color: #fff;
        background-color: #000;
        border-color: #000;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
    }
    .button-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>
<body>
<div class="container mt-4">
    <div class="button-container mb-2">
        <a href="/home" class="btn btn-back-to-products">Back to products</a>
        <a href="/cart" class="btn btn-cart">Cart</a>
    </div>
    <div class="row">
        <div class="col-md-6">
            <img src="${products.image}" alt="${products.name} Picture" class="product-image"/>
        </div>
        <div class="col-md-6">
            <div class="product-info">
                <h3>${products.name}</h3>
                <h5>$${products.price}</h5>
                <div class="product-action">
                    <c:choose>
                        <c:when test="${cartService.isItemInCart(products.id)}">
                            <form action="/cart/remove" method="post">
                                <input type="hidden" name="productId" value="${products.id}" />
                                <button type="submit">Remove from Cart</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form action="${pageContext.request.contextPath}/cart/add" method="post">
                                <input type="hidden" name="productId" value="${products.id}" />
                                <button type="submit" class="btn-add-to-bag">Add to Cart</button>
                            </form>
                        </c:otherwise>
                    </c:choose>


                </div>

                <div class="product-description">
                    <h5>Product Description</h5>
                    <p>${products.description}</p>
                </div>
                <div class="reviews-container">
                    <h4>Reviews</h4>
                    <c:forEach items="${reviews}" var="review">
                        <div class="review">
                            <strong>${review.user.userName}</strong>
                            <span class="review-date"><fmt:formatDate value="${review.updatedAt}" pattern="MMM dd, yyyy"/></span>
                            <span class="review-content">${review.review}</span>
                        </div>
                    </c:forEach>
                </div>
                <div class="review-form-container">
                    <form action="/products/${products.id}/review" method="post">
                        <div class="form-group">
                            <label for="review">Leave a Review:</label>
                            <textarea name="review" id="review" class="form-control" rows="3"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary mt-2">Write a review</button>
                    </form>
                </div>
            </div>
            </div>
        </div>
</div>
</body>
</html>