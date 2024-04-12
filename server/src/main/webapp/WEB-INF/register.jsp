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

<div class="form-container ">
    <h3 >Please Register</h3>
    <form:form action="/register" modelAttribute="newUser" method="post" class="form">
        <div >
            <form:label path="userName" class="form-label">User Name:</form:label>
            <form:input path="userName" class="form-control" type="text"/>
            <form:errors path="userName" class="text-danger"/>
        </div>
        <div >
            <form:label path="email" class="form-label">Email:</form:label>
            <form:input path="email" class="form-control" type="text"/>
            <form:errors path="email" class="text-danger"/>
        </div>
        <div >
            <form:label path="password" class="form-label">Password:</form:label>
            <form:input path="password" class="form-control" type="password"/>
            <form:errors path="password" class="text-danger"/>
        </div>
        <div >
            <form:label path="confirm" class="form-label">Confirm:</form:label>
            <form:input path="confirm" class="form-control" type="password"/>
            <form:errors path="confirm" class="text-danger"/>
        </div>
        <div >
            <p class="sign-up-label">
                Do you want to go back?<span class="sign-up-link"><a href="/" class="sign-up-link">Go Back</a></span>
            </p>
            <button class="form-btn">Register</button>
        </div>

    </form:form>


</div>

</body>
</html>