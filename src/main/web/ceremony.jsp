<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ceremony</title>
</head>
<body>
<header>
    <c:if test="${!empty sessionScope.user_login}">
        <form method="post" action="login">
            Hello, ${user_login}!
            <input type="hidden" name="command" value="logout">
            <input type="submit" value="Logout"/>
        </form>
        <br/>
    </c:if>
    <a href="<c:url value="/ceremony.jsp"/>">Manage Ceremony</a>
    <a href="<c:url value="/contact.jsp"/>">Contact Manager</a>
    <a href="<c:url value="/about.jsp"/>">About</a>
</header>
<form action="ceremony" method="post">
    <label>
        Restaurant
        <select name="restaurant" required>
            <option>Lion's Pride Inn, Elwynn Forest</option>
            <option>Pig and Whistle Tavern, Stormwind</option>
            <option>Salty Sailor Tavern, Booty Bay</option>
        </select>
    </label><br>
    <label>
        Artist
        <select name="artist" required>
            <option>Corey Todd Taylor, Slipknot</option>
            <option>Mikhail Poplavsky</option>
            <option>Jon Bon Jovi</option>
        </select>
        <button>add</button>
    </label><br>
    <input type="submit" value="Submit">
</form>
</body>
</html>
