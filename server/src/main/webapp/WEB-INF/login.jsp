<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>eCommerce</title>
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

<div class="form-container">

    <p class="title">Welcome back</p>
    <form class="form" action="/login" method="post" modelAttribute="newLogin">
        <input required="" type="email" name="email" class="input" placeholder="Email">
        <input required="" type="password" name="password" class="input" placeholder="Password">

        <button class="form-btn">Log in</button>
    </form>
    <p class="sign-up-label">
        Don't have an account?<span class="sign-up-link"><a href="/register" class="sign-up-link">Sign up</a></span>
    </p>
    <p class="sign-up-label">
        Do you want to go back?<span class="sign-up-link"><a href="/" class="sign-up-link">Go Back</a></span>
    </p>
</div>

</body>
</html>
