<%--
  Created by IntelliJ IDEA.
  User: Artan
  Date: 2/9/2024
  Time: 5:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Checkout</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <style>
        .container {
            width: 400px;
            margin: auto;
            margin-top: 150px;
            background: #f7f7f7;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }
        .cart-header {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 20px;
        }
        .form-control {
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ced4da;
        }
        .form-control:focus {
            border-color: #4a4a4a;
            box-shadow: none;
        }
        .btn-checkout {
            width: 100%;
            background-color: #000;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 20px;
            font-size: 16px;
            margin-top: 20px;
            cursor: pointer;
        }
        .btn-checkout:hover {
            background-color: #ced4da;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="cart-container">
        <div class="cart-header">Delivery Address</div>
        <form:form action="${pageContext.request.contextPath}/processDeliveryAddress" modelAttribute="shippingAddress" method="post">
            <form:input path="address" placeholder="Address" cssClass="form-control" />
            <form:input path="city" placeholder="City" cssClass="form-control" />
            <form:input path="postalCode" placeholder="Postal Code" cssClass="form-control" />
            <form:input path="country" placeholder="Country" cssClass="form-control" />
            <input type="submit" value="Continue to Payment" class="btn btn-checkout" />
        </form:form>
    </div>
</div>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>

