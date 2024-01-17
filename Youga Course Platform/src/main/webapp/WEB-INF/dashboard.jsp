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
        <div class="container">
            <div class="d-flex justify-content-between">
                <h2>Welcome, ${user.userName}</h2>
                <a href="/logout">Logout</a>
                <a href="/classes/new">New Course</a>
            </div>
        </div>
        <h1>${user.userName}</h1>
        <div class="container">
            <h1 class="center">Course Schedule</h1>
            <table id="display" class="table table-bordered table-striped center">
                <thead>
                <th scope="col">Class Name</th>
                <th scope="col">Instructor</th>
                <th scope="col">Weekday</th>
                <th scope="col">Price</th>
                <th scope="col">Time</th>
                </thead>
                <tbody>
                <c:forEach items="${courses}" var="coureses">
                    <tr class="table-active">
                        <td class="table-active"><a href="/classes/${coureses.id}"><c:out value="${coureses.name}"></a></c:out></td>
                        <td class="table-active"><c:out value="${coureses.creator.userName}"></c:out></td>
                        <td class="table-active"><c:out value="${coureses.weekday}"></c:out></td>
                        <td class="table-active"><c:out value="${coureses.price}"></c:out></td>
                        <td class="table-active"><fmt:formatDate value="${coureses.dueTime}" pattern="HH:mm"></fmt:formatDate></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </body>
</html>
