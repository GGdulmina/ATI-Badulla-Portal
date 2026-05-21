package listeners;

import db.DBConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class VisitorCounterListener
        implements ServletContextListener {

    @Override
    public void contextInitialized(
            ServletContextEvent sce
    ) {

        try (

            Connection con =
                    DBConnection.getConnection();

            Statement st =
                    con.createStatement();

            ResultSet rs =
                    st.executeQuery(
                            "SELECT hit_count FROM visitor_counter WHERE id=1"
                    )

        ) {

            if (rs.next()) {

                sce.getServletContext()
                        .setAttribute(
                                "visitorCount",
                                rs.getInt("hit_count")
                        );

                System.out.println(
                        "Visitor count loaded successfully"
                );

            } else {

                sce.getServletContext()
                        .setAttribute(
                                "visitorCount",
                                0
                        );
            }

        } catch (SQLException e) {

            sce.getServletContext()
                    .setAttribute(
                            "visitorCount",
                            0
                    );

            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(
            ServletContextEvent sce
    ) {

    }
}