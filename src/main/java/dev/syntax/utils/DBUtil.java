package dev.syntax.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;
import java.io.IOException;

public class DBUtil {

    private static String url;
    private static String database;
    private static String user;
    private static String password;

    static {
        try (InputStream input = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("db.properties 파일을 찾을 수 없습니다.");
            }

            Properties prop = new Properties();
            prop.load(input);

            url = prop.getProperty("url");
            database = prop.getProperty("database");
            user = prop.getProperty("user");
            password = prop.getProperty("password");

            // 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("DBUtil 초기화 실패: " + e.getMessage(), e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url + database, user, password);
    }
}
