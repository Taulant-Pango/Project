<%--
  Created by IntelliJ IDEA.
  User: Artan
  Date: 2/13/2024
  Time: 2:45 PM
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
    <title>Admin Login</title>
    <link rel="stylesheet" href="main.css">
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

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="col-md-6">
        <h2>Log In as Admin</h2>
        <form action="/admin/login" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input id="email" name="email" class="form-control" type="text"/>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input id="password" name="password" class="form-control" type="password"/>
            </div>
            <div class="d-grid">
                <input type="submit" value="Submit" class="btn btn-primary"/>
            </div>
        </form>
    </div>
</div>
</body>
</html>

