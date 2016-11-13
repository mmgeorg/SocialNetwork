<!DOCTYPE html>
<jsp:useBean id="person" scope="session" type="models.Person"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>header</title>
    <%--<link rel="stylesheet" href="/css/styles.css" type="text/css">--%>

</head>
<body>
<header>
    <div class="lang">
        <a href="/Location">${sessionScope.lang}</a>
    </div>
    <div class="fio inline">
        ${person.firstName} ${person.lastName}
    </div>
</header>
</body>
</html>