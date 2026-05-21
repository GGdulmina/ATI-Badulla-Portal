package servlets;

import db.DBConnection;
import models.Gallery;
import models.Notice;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(
        name = "HomeServlet",
        urlPatterns = {"/home", "/index"}
)

public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        /*
         * VISITOR COUNTER
         */

        ServletContext ctx = getServletContext();

        synchronized (ctx) {

            int count =
                    (int) ctx.getAttribute("visitorCount") + 1;

            ctx.setAttribute(
                    "visitorCount",
                    count
            );

            try (

                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(
                                "UPDATE visitor_counter SET hit_count=? WHERE id=1"
                        )

            ) {

                ps.setInt(1, count);

                ps.executeUpdate();

            } catch (SQLException e) {

                e.printStackTrace();
            }
        }

        /*
         * LISTS FOR DATA
         */

        List<Gallery> carouselImages =
                new ArrayList<>();

        List<Notice> notices =
                new ArrayList<>();

        /*
         * DATABASE OPERATIONS
         */

        try (

            Connection con =
                    DBConnection.getConnection()

        ) {

            /*
             * LOAD CAROUSEL IMAGES
             */

            String imgSql =
                    "SELECT * FROM gallery " +
                    "WHERE is_carousel=1 " +
                    "ORDER BY upload_date DESC " +
                    "LIMIT 10";

            try (

                PreparedStatement ps =
                        con.prepareStatement(imgSql);

                ResultSet rs =
                        ps.executeQuery()

            ) {

                while (rs.next()) {

                    Gallery g = new Gallery();

                    g.setId(
                            rs.getInt("id")
                    );

                    g.setImagePath(
                            rs.getString("image_path")
                    );

                    g.setCaption(
                            rs.getString("caption")
                    );

                    carouselImages.add(g);
                }
            }

            /*
             * LOAD NOTICES
             */

            String noticeSql =
                    "SELECT * FROM notices " +
                    "ORDER BY priority DESC, posted_date DESC " +
                    "LIMIT 10";

            try (

                PreparedStatement ps =
                        con.prepareStatement(noticeSql);

                ResultSet rs =
                        ps.executeQuery()

            ) {

                while (rs.next()) {

                    Notice n = new Notice();

                    n.setId(
                            rs.getInt("id")
                    );

                    n.setTitle(
                            rs.getString("title")
                    );

                    n.setContent(
                            rs.getString("content")
                    );

                    n.setPostedDate(
                            rs.getTimestamp("posted_date")
                    );

                    notices.add(n);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        /*
         * SEND DATA TO JSP
         */

        request.setAttribute(
                "carouselImages",
                carouselImages
        );

        request.setAttribute(
                "notices",
                notices
        );

        request.getRequestDispatcher(
                "/index.jsp"
        ).forward(request, response);
    }
}