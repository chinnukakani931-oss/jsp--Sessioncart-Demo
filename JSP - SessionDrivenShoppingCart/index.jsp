<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Boolean loggedIn =
        (Boolean) session.getAttribute("loggedIn");

    if (loggedIn != null && loggedIn) {
%>

        <jsp:forward page="catalog.jsp" />

<%
    } else {
%>

        <jsp:forward page="login.jsp" />

<%
    }
%>