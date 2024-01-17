<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 1/3/2024
  Time: 3:09 PM
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
        <div class="d-flex justify-content-between">
            <h2>Welcome, ${user.userName}</h2>
            <a href="/logout">Logout</a>
    
        </div>
        <div class="container">
            <table id="display" class="table table-bordered table-striped center">
                <thead>
                    <th scope="col">Address</th>
                    <th scope="col">Listed On</th>
                    <th scope="col">Added By</th>
                    <th scope="col">Price</th>
                </thead>
                <tbody>
                <c:forEach items="${carts}" var="cart">
                    <tr class="table-active">
                        <td class="table-active"><a href="/listings/${cart.id}"><c:out value="${cart.address}"></c:out></a></td>
                        <td class="table-active"><fmt:formatDate value="${cart.createdAt}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                        <td class="table-active"><c:out value="${cart.user.userName}"></c:out></td>
                        <td class="table-active"><c:out value="${cart.price}"></c:out></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <a href="/listings/new">Add Listing</a>

    </body>
</html>
