<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
</head>
<body>
<form method="post" action="registration">
    <label>
        Login: <input type="text" name="user_login" required><br>
    </label>
    <label>
        Password: <input type="password" name="user_password" required><br>
    </label>
    <label>
        Repeat password: <input type="password" name="user_password_2" required><br>
    </label>
    <label>
        Email: <input type="email" name="user_email" required><br>
    </label>
    <label hidden>
        <a href="<c:url value="/restore.jsp"/>">Restore Password</a><br>
    </label>
    <label hidden>
        <a href="<c:url value="/registration.jsp"/>">Registration</a><br>
    </label>
    <label>
        <a href="<c:url value="/login.jsp"/>">Log in</a><br>
    </label>
    <input type="submit">
</form>
</body>
</html>
