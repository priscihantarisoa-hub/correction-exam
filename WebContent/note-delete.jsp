<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.exam.NoteDAO" %>
<%
    String idParam = request.getParameter("id");
    
    try {
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            NoteDAO.delete(id);
        }
        response.sendRedirect("note-list.jsp");
    } catch (Exception e) {
        out.println("<h2>Erreur: " + e.getMessage() + "</h2>");
        out.println("<a href='note-list.jsp'>Retour</a>");
    }
%>
