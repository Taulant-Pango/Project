<%--
  Created by IntelliJ IDEA.
  User: Artan
  Date: 2/4/2024
  Time: 3:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movies</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<style>
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
<body>
<div class="container my-4">

    <h1 class="mb-3">Add to Your Products</h1>

    <a href="/admin" class="btn btn-secondary mb-3">Back to products</a>

    <form:form action="/products" modelAttribute="product" method="post">

        <div class="mb-3">
            <form:label path="name" class="form-label">Name:</form:label>
            <form:input type="text" path="name" class="form-control"/>
            <form:errors path="name" class="text-danger"/>
        </div>

        <div class="mb-3">
            <form:label path="image" class="form-label">Picture URL:</form:label>
            <form:input type="text" path="image" class="form-control" placeholder="Picture URL"/>
            <form:errors path="image" class="text-danger"/>
        </div>

        <div class="mb-3">
            <form:label path="description" class="form-label">Description:</form:label>
            <form:input type="text" path="description" class="form-control"/>
            <form:errors path="description" class="text-danger"/>
        </div>

        <div class="mb-3">
            <form:label path="price" class="form-label">Price:</form:label>
            <form:input type="number" path="price" class="form-control" ></form:input>
            <form:errors path="price" class="text-danger"/>
        </div>

        <div class="mb-3">
            <form:label path="countInStock" class="form-label">Count In Stock:</form:label>
            <form:input type="number" path="countInStock" class="form-control"/>
            <form:errors path="countInStock" class="text-danger"/>
        </div>

        <div class="d-grid">
            <input type="submit" value="Submit" class="btn btn-primary"/>
        </div>


    </form:form>

</div>
</body>
</html>