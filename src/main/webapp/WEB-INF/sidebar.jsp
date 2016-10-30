<jsp:useBean id="person" scope="session" type="models.Person"/>
<%@ page contentType="text/html, ;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>sidebar</title>
    <link rel="stylesheet" href="/css/styles.css" type="text/css">
    <fmt:setLocale value="${sessionScope.lang}" />
    <fmt:setBundle basename="localization.message" var="loc" />
    <fmt:message bundle="${loc}" key="friends" var="friends" />
    <fmt:message bundle="${loc}" key="messages" var="messages" />
    <fmt:message bundle="${loc}" key="music" var="music" />
</head>
<body>
    <p><img src="/WEB-INF/images/ALF.jpg" width="300" height="200"/></p>
    <nav>
        <ul class="aside-menu">
            <li><a href="${pageContext.request.contextPath}/Profile">${friends}</a></li>
            <li><a href="${pageContext.request.contextPath}/Profile">${messages}</a></li>
            <li><a href="${pageContext.request.contextPath}/Profile">${music}</a></li>
        </ul>
    </nav>
</body>
</html>