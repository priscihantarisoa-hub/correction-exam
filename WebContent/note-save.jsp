<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.exam.NoteDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    String idParam = request.getParameter("id");
    String noteStr = request.getParameter("note");
    String idCandidat = request.getParameter("idCandidat");
    String idMatiere = request.getParameter("idMatiere");
    String idCorrecteur = request.getParameter("idCorrecteur");
    
    try {
        double note = Double.parseDouble(noteStr);
        int idC = Integer.parseInt(idCandidat);
        int idM = Integer.parseInt(idMatiere);
        int idCo = Integer.parseInt(idCorrecteur);
        
        if (idParam != null && !idParam.isEmpty()) {
            // Update
            int id = Integer.parseInt(idParam);
            NoteDAO.update(id, note, idC, idM, idCo);
        } else {
            // Insert
            NoteDAO.insert(note, idC, idM, idCo);
        }
        response.sendRedirect("note-list.jsp");
    } catch (Exception e) {
        out.println("<h2>Erreur: " + e.getMessage() + "</h2>");
        out.println("<a href='note-list.jsp'>Retour</a>");
    }
%>
