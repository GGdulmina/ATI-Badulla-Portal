package servlets;

import db.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(
        name = "AdminLoginServlet",
        urlPatterns = {"/adminLogin"}
)
public class AdminLoginServlet
        extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        try (

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                            "SELECT * FROM users " +
                            "WHERE username=? " +
                            "AND password_hash=SHA2(?,256)"
                    )

        ) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session =
                        request.getSession();

                session.setAttribute(
                        "adminUser",
                        username
                );

                session.setMaxInactiveInterval(
                        30 * 60
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/dashboard.jsp"
                );

            } else {

                request.setAttribute(
                        "errorMsg",
                        "Invalid username or password."
                );

                request.getRequestDispatcher(
                        "/admin/login.jsp"
                ).forward(request, response);
            }

        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMsg",
                    "Database error. Please try again."
            );

            request.getRequestDispatcher(
                    "/admin/login.jsp"
            ).forward(request, response);
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/login.jsp"
        );
    }
}