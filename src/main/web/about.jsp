<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>About</title>
</head>
<body>
<header>
    <c:if test="${!empty sessionScope.user_login}">
        <form method="post" action="login">
            Hello, ${sessionScope.user_login}!
            <input type="hidden" name="command" value="logout">
            <input type="submit" value="Logout"/>
        </form>
        <br/>
    </c:if>
    <a href="<c:url value="/ceremony.jsp"/>">Manage Ceremony</a>
    <a href="<c:url value="/contact.jsp"/>">Contact Manager</a>
    <a href="<c:url value="/about.jsp"/>">About</a>
    <form method="post" action="personal_page">
        <input name="command" type="hidden" value="load">
        <input type="submit" value="personal page">
    </form>
</header>
Created by Vitaly Sharapov KM33
</body>
</html>
