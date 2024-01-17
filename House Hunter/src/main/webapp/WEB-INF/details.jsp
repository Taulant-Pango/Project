<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 1/3/2024
  Time: 4:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- New line below to use the JSP Standard Tag Library -->
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <h1>${cart.address}</h1>
        <a href="/home">dashboard</a>

        <table class="table table-bordered table-active table-striped center">

            <tbody>
                <tr class="table-active">
                    <td class="table-active">Address: <c:out value="${cart.address}"></c:out></td>
                </tr>
                <tr class="table-active">
                    <td class="table-active">Listing Date: <fmt:formatDate value="${cart.createdAt}" pattern="MMMM dd"/></td>
                </tr>
                <tr class="table-active">
                    <td class="table-active">Price: <c:out value="${cart.price}"></c:out></td>
                </tr>
            </tbody>
        </table>
        <c:if test="${cart.user.id.equals(user.id)}">
            <a href="/listings/${cart.id}/edit">Edit</a>
            <a href="/listings/delete/${cart.id}">Delete</a>
        </c:if>
    </body>
</html>
