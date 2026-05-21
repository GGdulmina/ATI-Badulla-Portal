package listeners;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Application started successfully");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        try {
            AbandonedConnectionCleanupThread.uncheckedShutdown();
            System.out.println("MySQL cleanup thread stopped successfully");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}