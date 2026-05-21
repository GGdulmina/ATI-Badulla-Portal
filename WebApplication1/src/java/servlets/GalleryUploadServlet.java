package servlets;

import db.DBConnection;
import models.Gallery;
import java.io.*;
import java.nio.file.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/admin/gallery")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB — held in memory below this
    maxFileSize       = 1024 * 1024 * 10, // 10MB max per file
    maxRequestSize    = 1024 * 1024 * 50  // 50MB max total request
)
public class GalleryUploadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        List<Gallery> images = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM gallery ORDER BY upload_date DESC");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Gallery g = new Gallery();
                g.setId(rs.getInt("id"));
                g.setImagePath(rs.getString("image_path"));
                g.setCaption(rs.getString("caption"));
                g.setCarousel(rs.getInt("is_carousel") == 1);
                g.setUploadDate(rs.getTimestamp("upload_date"));
                images.add(g);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("images", images);
        request.getRequestDispatcher("/admin/manageGallery.jsp").forward(request, response);
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

                case "upload": {
                    Part filePart = request.getPart("imageFile");
                    String originalName = Paths.get(
                        filePart.getSubmittedFileName()).getFileName().toString();

                    // Make filename unique by prepending timestamp
                    String uniqueName = System.currentTimeMillis() + "_" + originalName;

                    // Save to the uploads folder inside the deployed web app
                    String uploadDir = getServletContext()
                        .getRealPath("/assets/uploads/");
                    filePart.write(uploadDir + File.separator + uniqueName);

                    String caption    = request.getParameter("caption");
                    int    isCarousel = "on".equals(
                        request.getParameter("isCarousel")) ? 1 : 0;

                    String sql = "INSERT INTO gallery (image_path, caption, is_carousel) VALUES (?,?,?)";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setString(1, uniqueName);
                        ps.setString(2, caption);
                        ps.setInt(3, isCarousel);
                        ps.executeUpdate();
                    }
                    break;
                }

                case "toggleCarousel": {
                    // Flip the is_carousel flag for one image
                    String sql = "UPDATE gallery SET is_carousel = NOT is_carousel WHERE id=?";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                        ps.executeUpdate();
                    }
                    break;
                }

                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));

                    // Get filename first so we can delete the actual file too
                    String filename = null;
                    try (PreparedStatement ps = con.prepareStatement(
                            "SELECT image_path FROM gallery WHERE id=?")) {
                        ps.setInt(1, id);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) filename = rs.getString("image_path");
                    }

                    // Delete DB row
                    try (PreparedStatement ps = con.prepareStatement(
                            "DELETE FROM gallery WHERE id=?")) {
                        ps.setInt(1, id);
                        ps.executeUpdate();
                    }

                    // Delete physical file
                    if (filename != null) {
                        String filePath = getServletContext()
                            .getRealPath("/assets/uploads/") + File.separator + filename;
                        Files.deleteIfExists(Paths.get(filePath));
                    }
                    break;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/gallery");
    }
}