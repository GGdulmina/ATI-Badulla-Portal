package servlets;

import db.DBConnection;
import models.Result;

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

@WebServlet("/results")
public class ResultsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchIndex = request.getParameter("index");
        List<Result> results = new ArrayList<>();

        String sql;
        boolean hasSearch = searchIndex != null && !searchIndex.trim().isEmpty();

        if (hasSearch) {
            sql = "SELECT * FROM results WHERE student_index = ? ORDER BY exam_date DESC";
        } else {
            sql = "SELECT * FROM results ORDER BY exam_date DESC";
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (hasSearch) {
                ps.setString(1, searchIndex.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
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
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("results", results);
        request.setAttribute("searchIndex", searchIndex);
        request.getRequestDispatcher("/results.jsp").forward(request, response);
    }
}