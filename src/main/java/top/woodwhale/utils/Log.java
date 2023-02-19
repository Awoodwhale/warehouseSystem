package top.woodwhale.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Log {
    public static void d(Object obj, String info) {
        System.out.println("[" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + "] " +
                obj.getClass().getSimpleName() + " " + info);
    }
}
