package servlets;

import db.DBConnection;
import models.Course;

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

@WebServlet("/courses")
public class CoursesServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        List<Course> courses = new ArrayList<>();

        try (

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                            "SELECT * FROM courses ORDER BY category, name"
                    );

            ResultSet rs =
                    ps.executeQuery()

        ) {

            while (rs.next()) {

                Course c = new Course();

                c.setId(
                        rs.getInt("id")
                );

                c.setName(
                        rs.getString("name")
                );

                c.setDuration(
                        rs.getString("duration")
                );

                c.setDescription(
                        rs.getString("description")
                );

                c.setCategory(
                        rs.getString("category")
                );

                courses.add(c);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        request.setAttribute(
                "courses",
                courses
        );

        request.getRequestDispatcher(
                "/courses.jsp"
        ).forward(request, response);
    }
}