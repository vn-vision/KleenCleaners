<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    // 'session' is an implicit object in JSP
    if (session != null) {
        session.invalidate();
    }
    response.sendRedirect("login.jsp");
%>
