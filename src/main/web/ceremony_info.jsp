<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ceremony</title>
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
    <form method="post" action="update_ceremony">
        <label>
            Ceremony date :
            <input type="date" name="cer_date" value="${requestScope.cer_date}" required>
            <input type="hidden" name="command" value="edit date">
            <input type="submit" value="edit date">
            <br>
        </label>
    </form>
    Groom :         ${requestScope.cer_groom}<br>
    Bride :         ${requestScope.cer_bride}<br>
    <form method="post" action="update_ceremony">
        <label>
            Restaurant : ${requestScope.cer_rest}<br>
            Other restaurant options :
            <select name="rest_number" required>
                <c:forEach items="${requestScope.restMap}" var="entry">
                    <option value="${entry.key}">${entry.value}</option>
                </c:forEach>
            </select>
            <input type="hidden" name="command" value="edit rest">
            <input type="submit" value="edit restaurant">
            <br>
        </label>
    </form>
    <form method="post" action="update_ceremony">
        <label>
            Artists : <br>
            <c:forEach items="${requestScope.cer_art}" var="item">
                ${item}<br>
            </c:forEach>
            Other artists :
            <select name="art_number" required>
                <c:forEach items="${requestScope.artMap}" var="entry">
                    <option value="${entry.key}">${entry.value}</option>
                </c:forEach>
            </select>
            <input type="hidden" name="command" value="add artist">
            <input type="submit" value="add artist">
        </label>
    </form>
</c:if>
</body>
</html>
