<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Contact</title>
    <style>
        textarea {
            width: 200px;;
            height: 50px;;
            resize: none;
        }
    </style>
</head>
<body>
<c:if test="${!empty sessionScope.user_login}">
    <header>
        <form method="post" action="login">
            Hello, ${sessionScope.user_login}!
            <input type="hidden" name="command" value="logout">
            <input type="submit" value="Logout"/>
        </form>
        <br/>
        <form method="post" action="ceremony_switch">
            <input type="submit" value="manage ceremony">
        </form>
        <a href="<c:url value="/contact.jsp"/>">Contact Manager</a>
        <a href="<c:url value="/about.jsp"/>">About</a>
        <form method="post" action="personal_page">
            <input name="command" type="hidden" value="load">
            <input type="submit" value="personal page">
        </form>
    </header>
    <label>
        Message History<br>
        <textarea name="message_history" disabled>
    [09:15 23-Nov-16] Manager: your GUI is garbage
    </textarea>
    </label>
    <form method="post" action="message">
        <label>
            New message<br>
            <textarea name="user_new_message">

        </textarea><br>
            <input type="submit" value="send">
        </label>
    </form>
</c:if>
</body>
</html>