package servlets;

import db.DBConnection;
import models.Course;
import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin/courses")
public class CourseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        List<Course> courses = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM courses ORDER BY category, name");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDuration(rs.getString("duration"));
                c.setDescription(rs.getString("description"));
                c.setCategory(rs.getString("category"));
                courses.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/admin/manageCourses.jsp").forward(request, response);
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
                    String sql = "INSERT INTO courses (name, duration, description, category) VALUES (?,?,?,?)";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setString(1, request.getParameter("name"));
                        ps.setString(2, request.getParameter("duration"));
                        ps.setString(3, request.getParameter("description"));
                        ps.setString(4, request.getParameter("category"));
                        ps.executeUpdate();
                    }
                    break;
                }
                case "update": {
                    String sql = "UPDATE courses SET name=?, duration=?, description=?, category=? WHERE id=?";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setString(1, request.getParameter("name"));
                        ps.setString(2, request.getParameter("duration"));
                        ps.setString(3, request.getParameter("description"));
                        ps.setString(4, request.getParameter("category"));
                        ps.setInt(5, Integer.parseInt(request.getParameter("id")));
                        ps.executeUpdate();
                    }
                    break;
                }
                case "delete": {
                    String sql = "DELETE FROM courses WHERE id=?";
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

        response.sendRedirect(request.getContextPath() + "/admin/courses");
    }
}