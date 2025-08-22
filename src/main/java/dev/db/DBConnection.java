package dev.db;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static Properties properties = new Properties();

    static {
        try (InputStream inputStream = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (inputStream != null) {
                properties.load(inputStream);
            } else {
                throw new IOException("db.properties 파일을 찾을 수 없습니다.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 중앙에서 관리되는 데이터베이스 연결 객체를 반환하는 메서드.
     * @return 데이터베이스 연결을 위한 Connection 객체
     * @throws SQLException 연결 실패 시 SQL 예외 발생
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // properties 파일에서 DB 정보 가져오기
        String dbDriver = properties.getProperty("driver");
        String dbUrl = properties.getProperty("url");
        String dbUsername = properties.getProperty("username");
        String dbPassword = properties.getProperty("password");
        
        Class.forName(dbDriver);
        return DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
    }
}