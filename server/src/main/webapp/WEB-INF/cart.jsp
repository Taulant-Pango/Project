<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <style>
        body {
            background-color: #F8FAFC;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        }
        .container {
            max-width: 1200px;
            padding: 20px;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #000;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .product-img {
            width: 100px;
            height: auto;
        }
        .btn-primary {
            color: #fff;
            background-color: #000;
            border-color: #000;
            transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out;
        }
        .btn-primary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }

        .cart-total strong {
            color: #000;
        }

        .btn-continue {
            padding: 0.5rem 2rem;
            font-size: 1.1em;
        }

        .cart-container {
            background-color: #fff;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        .cart-header {
            border-bottom: 2px solid #eaeaea;
            padding-bottom: 1rem;
            margin-bottom: 1rem;
            font-size: 1.5rem;
            font-weight: 500;
        }

        .cart-table {
            width: 100%;
            margin-bottom: 2rem;
        }

        .cart-table th {
            background-color: #f9f9f9;
            color: #333;
            font-weight: 500;
        }

        .cart-table td {
            vertical-align: middle;
        }

        .cart-table img {
            width: 80px;
        }

        .quantity-select {
            display: inline-block;
            width: auto;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 0.25rem;
            background-color: #fff;
        }

        .total-row {
            font-size: 1.25rem;
            font-weight: 500;
            text-align: right;
            padding: 1rem 0;
        }

        .cart-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cart-actions .btn {
            padding: 0.75rem 2rem;
        }

        /* Responsive styling */
        @media (max-width: 768px) {
            .cart-actions {
                flex-direction: column;
            }

            .cart-actions .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }

            .total-row {
                text-align: left;
            }
        }

    </style>
</head>
<body>
<div class="container mt-4">
    <div class="cart-container">
        <div class="cart-header">Cart</div>
        <table class="cart-table">
            <thead>
            <tr>
                <th>Image</th>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cartItem" items="${cartProducts}" varStatus="status">
                <tr>
                    <td><img src="${cartItem.image}" alt="${cartItem.name}" class="product-img"></td>
                    <td>${cartItem.name}</td>
                    <td>$ <c:out value="${cartItem.price}" /></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/cart/update" method="post">
                            <input type="hidden" name="productId" value="${cartItem.id}" />
                            <select class="quantity-select" name="quantity" onchange="this.form.submit()">
                                <c:forEach begin="1" end="10" var="i">
                                    <option value="${i}" ${i == cartItem.quantity ? 'selected' : ''}>${i}</option>
                                </c:forEach>
                            </select>
                        </form>
                    </td>
                    <td>$ <c:out value="${cartItem.subtotal}" /></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                            <input type="hidden" name="productId" value="${cartItem.id}" />
                            <button type="submit" class="btn btn-danger">Remove</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="total-row">
            TOTAL: $<c:out value="${totalAmount}" />
        </div>
        <div class="cart-actions">
            <a href="/home" class="btn btn-outline-secondary btn-continue">Continue Shopping</a>
            <a href="/checkout" class="btn btn-primary">Checkout</a>
        </div>
    </div>
</div>
</body>
</html>
