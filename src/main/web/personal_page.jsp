<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Personal Page</title>
</head>
<body>
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

<form method="post" action="personal_page">

    <label>
        User name (login) :
        <input type="text" name="user_name" value="${requestScope.user_name}" readonly>
    </label> <br>
    <label>
        Email :
        <input type="text" name="user_email" value="${requestScope.user_email}">
    </label> <br>
    <label>
        User status :
        <input type="text" name="user_status" value="${requestScope.user_status}">
    </label> <br><br>

    <label>
        Groom name :
        <input type="text" name="user_groom_name" value=" ${requestScope.user_groom_name}">
    </label> <br>
    <label>
        Groom surname :
        <input type="text" name="user_groom_surname" value="${requestScope.user_groom_surname}">
    </label> <br>
    <label>
        Groom birthday :
        <input type="date" name="user_groom_birthday" value="${requestScope.user_groom_birthday}">
    </label> <br><br>

    <label>
        Bride name :
        <input type="text" name="user_bride_name" value="${requestScope.user_bride_name}">
    </label> <br>
    <label>
        Bride surname :
        <input type="text" name="user_bride_surname" value="${requestScope.user_bride_surname}">
    </label> <br>
    <label>
        Bride birthday :
        <input type="date" name="user_bride_birthday" value="${requestScope.user_bride_birthday}">
    </label> <br>

    <input name="command" type="hidden" value="update">
    <input type="submit" value="update personal data">
</form>
</body>
</html>
