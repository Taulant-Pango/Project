<%--
  Created by IntelliJ IDEA.
  User: Artan
  Date: 2/13/2024
  Time: 2:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <style>
        body {
            background-color: #F8FAFC;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        }
        .container {
            max-width: 1800px;
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
    <div class="cart-container">
        <a href="/admin/login" class="btn btn-outline-secondary">Logout</a>
        <div class="cart-header">Admin Dashboard</div>
        <h2>All Orders</h2>
        <table class="table">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>User</th>
            <th>Total Price</th>
            <th>Payment Method</th>
            <th>Is Paid</th>
            <th>Is Delivered</th>
            <th>Paid at</th>
            <th>Delivered at</th>
            <th>Address</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.id}</td>
                <td>${order.user.userName}</td>
                <td>${order.totalPrice}</td>
                <td>'PayPal'</td>
                <td>${order.paid ? 'Yes' : 'No'}</td>
                <td>${order.delivered ? 'Yes' : 'No'}</td>
                <td><fmt:formatDate value="${order.paidAt}" pattern="yyyy-MM-dd" /></td>
                <td><fmt:formatDate value="${order.deliveredAt}" pattern="yyyy-MM-dd" /></td>
                <td>${order.shippingAddress.address}, ${order.shippingAddress.city}, ${order.shippingAddress.postalCode}, ${order.shippingAddress.country}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <h2>All Users</h2>
    <table class="table">
        <thead>
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Registered At</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td>${user.userName}</td>
                <td>${user.email}</td>
                <td><fmt:formatDate value="${user.createdAt}" pattern="dd-MM-yyyy HH:mm:ss" /></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
        <h2>All Products</h2>
        <table class="table">
            <thead>
            <tr>
                <th>Product ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Image</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="product" items="${products}">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.price}</td>
                    <td><img src="${product.image}" alt="${product.name}" style="width:80px; height:auto;"></td>
                    <td>
                        <c:if test="${sessionScope.isAdmin}">
                            <div>
                                <a href="/products/${product.id}/edit" class="btn btn-primary me-2">Edit</a>
                                <form action="/products/${product.id}/delete" method="post" class="d-inline">
                                    <input type="hidden" name="_method" value="delete" />
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </div>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <a href="/addPage" class="btn btn-primary mt-4">+ Add a product</a>

</div>

</body>
</html>
