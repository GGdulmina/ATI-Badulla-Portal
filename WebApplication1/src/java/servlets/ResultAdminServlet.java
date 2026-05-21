package servlets;

import db.DBConnection;
import models.Result;
import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/results")
public class ResultAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        List<Result> results = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM results ORDER BY exam_date DESC");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Result r = new Result();
                r.setId(rs.getInt("id"));
                r.setStudentIndex(rs.getString("student_index"));
                r.setCourseName(rs.getString("course_name"));
                r.setMarks(rs.getInt("marks"));
                r.setGrade(rs.getString("grade"));
                r.setExamDate(rs.getDate("exam_date"));
                results.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("results", results);
        request.getRequestDispatcher("/admin/manageResults.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try (Connection con = DBConnection.getConnection()) {

            switch (action) {

                case "create": {
                    // Auto-calculate grade from marks
                    int marks = Integer.parseInt(request.getParameter("marks"));
                    String grade = calculateGrade(marks);

                    String sql = "INSERT INTO results "
                               + "(student_index, course_name, marks, grade, exam_date) "
                               + "VALUES (?,?,?,?,?)";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setString(1, request.getParameter("studentIndex"));
                        ps.setString(2, request.getParameter("courseName"));
                        ps.setInt(3, marks);
                        ps.setString(4, grade);
                        ps.setDate(5, Date.valueOf(request.getParameter("examDate")));
                        ps.executeUpdate();
                    }
                    break;
                }

                case "delete": {
                    String sql = "DELETE FROM results WHERE id=?";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                        ps.executeUpdate();
                    }
                    break;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/results");
    }

    // Auto grade calculation — A:75+, B:65+, C:55+, S:40+, F:below 40
    private String calculateGrade(int marks) {
        if (marks >= 75) return "A";
        if (marks >= 65) return "B";
        if (marks >= 55) return "C";
        if (marks >= 40) return "S";
        return "F";
    }
}