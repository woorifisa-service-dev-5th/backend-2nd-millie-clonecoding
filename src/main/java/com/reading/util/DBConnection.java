package com.reading.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    // 데이터베이스 연결 정보 (본인 환경에 맞게 수정하세요)
    private static final String URL; 
    private static final String USERNAME;
    private static final String PASSWORD;
    private static final String DRIVER;
    static {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("db.properties 파일을 찾을 수 없습니다.");
            }

            Properties prop = new Properties();
            prop.load(input);

            URL = prop.getProperty("URL");
            USERNAME = prop.getProperty("USERNAME");
            PASSWORD = prop.getProperty("PASSWORD");
            DRIVER = prop.getProperty("DRIVER");

            // 드라이버 로드
            Class.forName(DRIVER);

        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("DBUtil 초기화 실패: " + e.getMessage(), e);
        }
    }
    // 연결 가져오기
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
    
    // 연결 닫기
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // 연결 테스트 메서드
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.out.println("DB 연결 실패: " + e.getMessage());
            return false;
        }
    }
}