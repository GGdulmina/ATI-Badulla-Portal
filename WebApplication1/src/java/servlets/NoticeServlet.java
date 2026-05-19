package servlets;

import db.DBConnection;
import models.Notice;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/notices")
public class NoticeServlet extends HttpServlet {

    // READ — load all notices
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        List<Notice> notices = new ArrayList<>();

        String sql = "SELECT * FROM notices ORDER BY priority DESC, posted_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Notice n = new Notice();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("title"));
                n.setContent(rs.getString("content"));
                n.setPriority(rs.getInt("priority"));
                n.setPostedDate(rs.getTimestamp("posted_date"));
                notices.add(n);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("notices", notices);
        request.getRequestDispatcher("/admin/manageNotices.jsp").forward(request, response);
    }

    // CREATE + UPDATE + DELETE
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try (Connection con = DBConnection.getConnection()) {

            if ("create".equals(action)) {

                String sql = "INSERT INTO notices (title, content, priority) VALUES (?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, request.getParameter("title"));
                    ps.setString(2, request.getParameter("content"));
                    ps.setInt(3, Integer.parseInt(request.getParameter("priority")));
                    ps.executeUpdate();
                }

            } else if ("update".equals(action)) {

                String sql = "UPDATE notices SET title=?, content=?, priority=? WHERE id=?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, request.getParameter("title"));
                    ps.setString(2, request.getParameter("content"));
                    ps.setInt(3, Integer.parseInt(request.getParameter("priority")));
                    ps.setInt(4, Integer.parseInt(request.getParameter("id")));
                    ps.executeUpdate();
                }

            } else if ("delete".equals(action)) {

                String sql = "DELETE FROM notices WHERE id=?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                    ps.executeUpdate();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/notices");
    }
}