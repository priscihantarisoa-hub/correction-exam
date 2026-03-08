<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.exam.CandidatDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    String idParam = request.getParameter("id");
    String nom = request.getParameter("nom");
    
    try {
        if (idParam != null && !idParam.isEmpty()) {
            // Update
            int id = Integer.parseInt(idParam);
            CandidatDAO.update(id, nom);
        } else {
            // Insert
            CandidatDAO.insert(nom);
        }
        response.sendRedirect("candidat-list.jsp");
    } catch (Exception e) {
        out.println("<h2>Erreur: " + e.getMessage() + "</h2>");
        out.println("<a href='candidat-list.jsp'>Retour</a>");
    }
%>
