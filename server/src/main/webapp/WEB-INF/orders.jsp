<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Orders</title>
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
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4b5563;
            color: #000;
        }
        tr:hover {
            background-color: #f5f5f5;
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
        thead{
           background-color: #f1f5f9
        }
        table{
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <a href="/home" class="btn btn-secondary mb-3">Back to products</a>
    <div class="cart-container">
        <div class="cart-header">Your Orders</div>
        <table class="table">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Total Price</th>
                <th>Payment Method</th>
                <th>Is Paid</th>
                <th>Is Delivered</th>
                <th>Paid at</th>
                <th>Delivered at</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.id}</td>
                    <td>$<c:out value="${order.totalPrice}" /></td>
                    <td>PayPal</td>
                    <td>${order.paid ? 'Yes' : 'No'}</td>
                    <td>${order.delivered ? 'Yes' : 'No'}</td>
                    <td><fmt:formatDate value="${order.paidAt}" pattern="yyyy-MM-dd" /></td>
                    <td><fmt:formatDate value="${order.deliveredAt}" pattern="yyyy-MM-dd" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:if test="${empty orders}">
            <p>You have no orders.</p>
        </c:if>
    </div>
</div>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
