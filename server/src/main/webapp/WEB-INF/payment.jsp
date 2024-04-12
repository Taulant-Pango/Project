<%--
  Created by IntelliJ IDEA.
  User: Artan
  Date: 2/9/2024
  Time: 6:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Payment</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <style>
        .container {
            width: 40%;
            margin: auto;
            margin-top: 100px;
            background: #fff;
            padding: 30px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .cart-header {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-check-label {
            margin-bottom: 16px;
            display: block;
            width: 100%;
            background: #f7f7f7;
            padding: 15px;
            border: 1px solid #e1e1e1;
            border-radius: 6px;
            cursor: pointer;
        }
        .form-check-input {
            margin-right: 10px;
            cursor: pointer;
        }
        .btn-checkout {
            width: 100%;
            background-color: #000;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 6px;
            font-size: 16px;
            margin-top: 20px;
            cursor: pointer;
        }
        .btn-checkout:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="cart-container">
        <div class="cart-header">SELECT PAYMENT METHOD</div>
        <form action="${pageContext.request.contextPath}/processPayment" method="post">
            <div class="form-check">
                <label class="form-check-label">
                    <input class="form-check-input" type="radio" name="paymentMethod" value="paypalOrCreditCard"> PayPal or Credit Card
                </label>
            </div>
            <input type="submit" value="CONTINUE" class="btn btn-checkout" />
        </form>
    </div>
</div>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
