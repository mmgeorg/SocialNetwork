package servlets.listeners;

import Dao.ConnectionPool;
import Dao.PersonDao;
import lombok.extern.java.Log;
import org.h2.Driver;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static servlets.ServletConst.*;

@Log
@WebListener
public class Init implements ServletContextListener {

    private static ConnectionPool connectionPool;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        String realPath = context.getRealPath("/");
        connectionPool = ConnectionPool.create(realPath + config);
        initDb(connectionPool, realPath + pathToInit);
        context.setAttribute(PERSON_DAO, new PersonDao(connectionPool));
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            connectionPool.close();
            Driver driver = Driver.load();
            DriverManager.deregisterDriver(driver);
        } catch (SQLException e) {
            log.warning(e::getMessage);
        }
        log.info(() -> "Connection pool and DBManager closed" );
    }

    public void initDb(ConnectionPool connectionPool, String pathToInit) {
        try (Stream<String> fileStream = Files.lines(Paths.get(pathToInit));
             Connection con = connectionPool.get();
             Statement statement = con.createStatement()) {
            Arrays.stream(fileStream.collect(Collectors.joining())
                    .split(";"))
                    .forEachOrdered(sql -> {
                        try {
                            statement.addBatch(String.valueOf(sql));
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    });
            statement.executeBatch();
        } catch (IOException | SQLException e) {
            e.printStackTrace();

        }
    }
}
