<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 1/14/2024
  Time: 10:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- New line below to use the JSP Standard Tag Library -->
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<html>
    <head>
        <title>Title</title>
        <!-- for Bootstrap CSS -->
        <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
        <link
                href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
                rel="stylesheet"
                integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
                crossorigin="anonymous">
        <!-- YOUR own local CSS -->
        <link rel="stylesheet" href="/css/main.css"/>
        <!-- For any Bootstrap that uses JS -->
        <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="d-flex flex-column justify-content-center align-items-center gap-2">
                <h1>User Authentication</h1>
            </div>
            <div class="d-flex justify-content-center gap-5 mt-3">
                <div class="bg-light p-5">
                    <h3>Register</h3>
                    <form:form class="form d-flex flex-column gap-3" action="/register" method="post" modelAttribute="newUser">
                        <div class="d-flex flex-column justify-content-center align-items-center gap-2">
                            <form:errors path="userName" class="erros text-danger"></form:errors>
                            <form:label path="userName">Name: </form:label>
                            <form:input class="form-control" type="text" path="userName"></form:input>
                        </div>
                        <div class="d-flex flex-column justify-content-center align-items-center gap-2">
                            <form:errors path="email" class="erros text-danger"></form:errors>
                            <form:label path="email">Email: </form:label>
                            <form:input class="form-control" type="text" path="email"></form:input>
                        </div>
                        <div class="d-flex flex-column justify-content-center align-items-center gap-2">
                            <form:errors path="password" class="erros text-danger"></form:errors>
                            <form:label path="password">Password: </form:label>
                            <form:input class="form-control" type="password" path="password"></form:input>
                        </div>
                        <div class="d-flex flex-column justify-content-center align-items-center gap-2">
                            <form:errors path="confirm" class="erros text-danger"></form:errors>
                            <form:label path="confirm">Confirm: </form:label>
                            <form:input class="form-control" type="password" path="confirm"></form:input>
                        </div>
                        <input class="w-50 btn btn-primary" type="submit" value="Submit">
                    </form:form>
                </div>
                <div class="bg-light p-5">
                    <h3>Log In</h3>
                    <form:form class="form d-flex flex-column gap-3" action="/login" method="post" modelAttribute="newLogin">
                        <div class="d-flex flex-column justify-content-center align-items-center gap-2">
                            <form:errors path="email" class="erros text-danger"></form:errors>
                            <form:label path="email">Name: </form:label>
                            <form:input class="form-control" type="text" path="email"></form:input>
                        </div>
                        <div class="d-flex flex-column justify-content-center align-items-center gap-2">
                            <form:errors path="password" class="erros text-danger"></form:errors>
                            <form:label path="password">Password: </form:label>
                            <form:input class="form-control" type="password" path="password"></form:input>
                        </div>
                        <input class="w-50 btn btn-primary" type="submit" value="Submit">
                    </form:form>
                </div>
            </div>
        </div>

    </body>
</html>
