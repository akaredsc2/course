<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Vitaly Sharapov
  Date: 24-Dec-16
  Time: 3:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Complete password restoration</title>
</head>
<body>
Your password is:
${requestScope.password}
<p><a href="<c:url value="/login.jsp"/>">Login page</a>
</body>
</html>