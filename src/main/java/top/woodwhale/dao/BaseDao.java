package top.woodwhale.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class BaseDao {
    private static final String driver;
    private static final String url;
    private static final String username;
    private static final String passwd;
    //公共的数据库连辅助对象
    private static Connection globalConn = null;
    private static PreparedStatement globalPstm = null;
    private static ResultSet globalRs = null;

    // 静态代码块、类加载就初始化了
    static {
        // 通过类加载器读取对应的资源
        InputStream is = BaseDao.class.getClassLoader().getResourceAsStream("db.properties");
        Properties properties = new Properties();
        try {
            properties.load(is);
        } catch (IOException e) {
            e.printStackTrace();
        }
        driver = properties.getProperty("driver");
        url = properties.getProperty("url");
        username = properties.getProperty("username");
        passwd = properties.getProperty("passwd");
    }

    // 获取数据库连接
    private static void getConnection() {
        if (globalConn == null) {
            try {
                Class.forName(driver);
                globalConn = DriverManager.getConnection(url, username, passwd);
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // 编写查询公共类
    public static ResultSet execute(String sql, Object[] params) {
        try {
            getConnection();    // 执行之前，先获取数据库连接
            globalPstm = globalConn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    globalPstm.setObject(i + 1, params[i]);
                }
            }
            globalRs = globalPstm.executeQuery();
            return globalRs;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 编写增删改查
    public static int executeUpdate(String sql, Object[] params) {
        try {
            getConnection();
            globalPstm = globalConn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    globalPstm.setObject(i + 1, params[i]);
                }
            }
            return globalPstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 关闭连接
    public static boolean closeResource() {
        boolean flag = true;
        if (globalRs != null) {
            try {
                globalRs.close();
                globalRs = null;
            } catch (SQLException e) {
                e.printStackTrace();
                flag = false;
            }
        }
        if (globalPstm != null) {
            try {
                globalPstm.close();
                globalPstm = null;
            } catch (SQLException e) {
                e.printStackTrace();
                flag = false;
            }
        }
        if (globalConn!= null) {
            try {
                globalConn.close();
                globalConn = null;
            } catch (SQLException e) {
                e.printStackTrace();
                flag = false;
            }
        }
        return flag;
    }
}
