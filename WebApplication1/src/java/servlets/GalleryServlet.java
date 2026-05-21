package servlets;

import db.DBConnection;
import models.Gallery;

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

@WebServlet("/gallery")
public class GalleryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Gallery> images = new ArrayList<>();

        String sql = "SELECT * FROM gallery ORDER BY upload_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Gallery g = new Gallery();
                g.setId(rs.getInt("id"));
                g.setImagePath(rs.getString("image_path"));
                g.setCaption(rs.getString("caption"));
                g.setCarousel(rs.getInt("is_carousel") == 1);

                images.add(g);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("images", images);
        request.getRequestDispatcher("/gallery.jsp").forward(request, response);
    }
}