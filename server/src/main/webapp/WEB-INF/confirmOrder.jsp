<%--
  Created by IntelliJ IDEA.
  User: Artan
  Date: 2/9/2024
  Time: 6:54 PM
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
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <script src="https://www.paypal.com/sdk/js?client-id=ARx3JWcLot1-0MkR4AYqTLPocUSi53gAKuKPqF7p66wLqVt1uHr7KgM9MmjYV6xFg5Z3caLu_JgqtkDC"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .cart-container {
            background-color: #fff;
            border-radius: 0.25rem;
            padding: 20px;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            margin-bottom: 20px;
        }
        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            background-color: #e9ecef;
            border-radius: 0.25rem;
            padding: 10px;
            text-align: center;
        }
        .icon-circle {
            width: 60px;
            height: 60px;
            background-color: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        .info-section {
            display: flex;
            align-items: center;
            justify-content: space-evenly;
            gap: 15px;
            margin: 20px 0px;
            background-color: #f1f5f9;
            padding: 20px;
            border-radius: 5px;
        }
        .info-section h3 {
            margin: 0;
        }
        .info-section p {
            margin: 0;
        }
        .btn-checkout {
            background-color: #000000;
            border-color: #5a6268;
        }
        .btn-checkout:hover {
            background-color: #5a6268;
            border-color: #000000;
        }
        .cart-item-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem;
            border-bottom: 1px solid #ccc;
        }

        .cart-item-image {
            width: 100px;
        }

        .cart-item-details {
            flex-grow: 1;
            padding-left: 1rem;
        }

        .cart-item-name {
            margin-bottom: 0.5rem;
        }

        .cart-item-quantity,
        .cart-item-subtotal {
            text-align: center;
            padding: 20px;
        }

        .cart-total-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 1rem;
            border-top: 1px solid #ccc;
        }

        .cart-total-label {
            margin-right: 1rem;
        }

        .cart-total-amount {
            font-weight: bold;
            font-size: 1.25rem;
        }
        #payment-status, #delivery-status {
        color: red;
        display: none;
        }

    </style>
</head>
<body>
<div class="container mt-4">
    <div class="cart-container">
        <div class="cart-header">Order Confirmation
            <a href="/home" class="btn btn-secondary" >Continue Shopping</a>
        </div>
        <div class="info-section">
            <div class="icon-circle">
                <i class="fas fa-user" style="color: #191919;"></i>
            </div>
            <div>
                <h3>Customer</h3>
                <p><c:out value="${user.userName}" /></p>
                <p><c:out value="${user.email}" /></p>
            </div>

            <div class="icon-circle">
                <i class="fas fa-truck" style="color: #191919;"></i>
            </div>
            <div>
                <h3>Order Info</h3>
                <p>Shipping: ${shippingAddress.country}</p>
                <p>Payment Method: PayPal</p>
                <p id="payment-status">Not Paid</p>
            </div>

            <div class="icon-circle">
                <i class="fas fa-map-marker-alt" style="color: #191919;"></i>
            </div>
            <div>
                <h3>Deliver To</h3>
                <p>Address: ${shippingAddress.address}, ${shippingAddress.city}, </p>
                <p>${shippingAddress.postalCode}, ${shippingAddress.country}</p>
                <p id="delivery-status">Not Delivered</p>
            </div>
        </div>

        <c:forEach items="${cartItems}" var="cartItem">
            <div class="cart-item-container">
                <div>
                    <img src="${cartItem.image}" alt="${cartItem.name}" class="cart-item-image"/>
                </div>
                <div class="cart-item-details">
                    <p class="cart-item-name">${cartItem.name}</p>
                </div>
                <div class="cart-item-quantity">
                    <p>QUANTITY</p>
                    <p>${cartItem.quantity}</p>
                </div>
                <div class="cart-item-subtotal">
                    <p>SUBTOTAL</p>
                    <p>$ ${cartItem.subtotal}</p>
                </div>
            </div>
        </c:forEach>

        <div class="cart-total-container">
            <div class="cart-total-label">
                <p>Total: </p>
            </div>
            <div class="cart-total-amount">
                <p>$<c:out value="${totalAmount}" /></p>
            </div>
        </div>
        <form id="placeOrderForm" action="${pageContext.request.contextPath}/placeOrder" method="post" class="mt-4">
            <input type="submit" value="Place Order" class="btn btn-primary btn-checkout" />
        </form>

        <div id="paypal-button-container" style="display:none; width: 400px;"></div>
    </div>
</div>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('placeOrderForm').addEventListener('submit', function(e) {
        e.preventDefault();

        this.querySelector('input[type="submit"]').style.display = 'none';

        document.getElementById('paypal-button-container').style.display = 'block';
        document.getElementById('payment-status').style.display = 'block';
        document.getElementById('delivery-status').style.display = 'block';

        paypal.Buttons({
            createOrder: function(data, actions) {
                return actions.order.create({
                    purchase_units: [{
                        amount: {
                            value: '${totalAmount}'
                        }
                    }]
                });
            },
            onApprove: function(data, actions) {
                return actions.order.capture().then(function(details) {
                    return fetch('${pageContext.request.contextPath}/captureOrder', {
                        method: 'post',
                        headers: {
                            'content-type': 'application/json'
                        },
                        body: JSON.stringify({
                            orderID: data.orderID,
                            details: details
                        })
                    }).then(function(response) {
                        if (response.ok) {
                            document.getElementById('payment-status').textContent = 'Paid';
                            document.getElementById('delivery-status').textContent = 'Delivered';
                            window.location.href = '${pageContext.request.contextPath}/orderSuccess';
                        } else {
                            console.error('Server responded with an error status.');
                        }
                    }).catch(function(error) {
                        console.error('Fetch request failed:', error);
                    });
                });
            }
        }).render('#paypal-button-container');
    });

</script>


</body>
</html>
