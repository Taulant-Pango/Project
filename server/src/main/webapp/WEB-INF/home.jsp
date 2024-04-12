<%--
  Created by IntelliJ IDEA.
  User: Artan
  Date: 1/20/2023
  Time: 4:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <style>
        .card {
            width: 22rem;
            height: 40rem;
            margin-bottom: 20px;
        }
        .card-img-top {
            width: 100%;
            height: 358vw;
            object-fit: cover;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .card-title {
            font-size: 1rem;
        }
        .container {
            max-width: 1200px;
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
    </style>
</head>
<body style="background-color: #F8FAFC;">

<div class="container mt-4">
    <h1 class="mb-3">Welcome, <c:out value="${user.userName}"/></h1>
    <div class="d-flex justify-content-between mb-3">
        <a href="/logout" class="btn btn-outline-secondary">Logout</a>
        <a href="/orders">View Your Orders</a>
    </div>

    <div class="container mt-4">
        <form class="d-flex mb-4" method="get" action="/home">
            <input class="form-control me-2" type="search" name="search" placeholder="Search products" aria-label="Search" value="${searchTerm}">
            <button class="btn btn-primary" type="submit">Search</button>
        </form>
    </div>

    <div class="row">
        <c:forEach var="product" items="${products}" varStatus="status">
        <div class="col-md-4">
            <div class="card">
                <img src="${product.image}" class="card-img-top" alt="${product.name}">
                <div class="card-body">
                    <h5 class="card-title">${product.name}</h5>
                    <p class="card-text">$ ${product.price}</p>
                    <a href="/products/${product.id}" class="btn btn-primary">View</a>
                </div>
            </div>
        </div>
        <c:if test="${status.count % 3 == 0}">
    </div>
    <div class="row">
        </c:if>
        </c:forEach>
    </div>
</div>

<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
