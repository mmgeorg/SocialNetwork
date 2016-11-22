<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:useBean id="person" scope="session" type="models.Person"/>
<jsp:useBean id="user" scope="request" type="models.Person"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Profile</title>
    <link rel="stylesheet" href="/css/styles.css" type="text/css">
    <script src="/js/websocket.js"></script>
    <fmt:setLocale value="${sessionScope.lang}"/>
    <fmt:setBundle basename="localization.message" var="loc"/>
    <fmt:message bundle="${loc}" key="dob" var="dob"/>
    <fmt:message bundle="${loc}" key="email" var="mail"/>
    <fmt:message bundle="${loc}" key="telephone" var="telephone"/>
    <fmt:message bundle="${loc}" key="address" var="address"/>
</head>
<body>
<div id="wrapper">
    <jsp:include page="/WEB-INF/header.jsp"/>
    <div class="page_layout">
        <jsp:include page="/WEB-INF/sidebar.jsp"/>
        <div class="fl_r">
            <div class="page_body">
                <div class="avatar_block">
                    <div class="page_block">
                        <div class="avatar_wrap">
                            <div>
                                <img class="page_avatar" src='/images/${user.id}.jpg'/>
                            </div>
                            <c:if test="${person.id ne user.id}">
                                <form class="only_button" action="/AddRemoveFriend" method="get">
                                    <input type="hidden" name="user_id" value="${user.id}"/>
                                    <c:choose>
                                        <c:when test="${requestScope.friendStatus eq 1}">
                                            <button class="avatar_button" type="submit" name="status" value="0">
                                                remove
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="avatar_button" type="submit" name="status" value="1">
                                                add
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="main_section">
                    <div class="page_block fl_l">
                        <div class="avatar_wrap">
                            <div>
                                <h2 class="page_name"> ${user.firstName} ${user.lastName}</h2>
                            </div>
                            <div class="profile_info">
                                <c:if test="${not empty user.dob}">
                                    <div class="info_line">
                                        <div class="label fl_l">
                                                ${dob}:
                                        </div>
                                        <div>
                                                ${user.dob}
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty user.telephone}">
                                    <div class="info_line">
                                        <div class="label fl_l">
                                                ${telephone}:
                                        </div>
                                        <div>
                                                ${user.telephone}
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty user.email}">
                                    <div class="info_line">
                                        <div class="label fl_l">
                                                ${mail}:
                                        </div>
                                        <div>
                                                ${user.email}
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty user.address}">
                                    <div class="info_line">
                                        <div class="label fl_l">
                                                ${address}:
                                        </div>
                                        <div>
                                                ${user.address}
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty user.info}">
                                    <div class="info_line">
                                        <div class="label fl_l">
                                            info:
                                        </div>
                                        <div>
                                                ${user.info}
                                        </div>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </div>

                    <div class="page_block">

                        <p>Chat room</p>
                        <br/>
                        <div id="addMsg">
                            <button onclick=showForm()>Add a msg</button>
                            <%--<div class="button"><a href="#" OnClick="showForm()">Add a msg</a></div>--%>
                            <form id="msgForm" action="">
                                <input type="hidden" name="userId" value="${user.id}">
                                <textarea name="text" id="text" title="123123"></textarea>
                                <input type="button" class="msg-button" value="Send" onclick=formSubmit()>
                                <input type="reset" class="button" value="Cancel" onclick=hideForm()>

                            </form>
                        </div>
                        <br/>

                        <div id="content">
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>