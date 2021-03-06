package session;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionLogic {
    public static boolean flag = true;
    private static final int timeLive = 30 * 60;

    public static HttpSession getSession(HttpServletRequest request) {
        HttpSession session ;
        if (flag) {
            session = request.getSession();
           // session.setMaxInactiveInterval(timeLive);
            flag = false;
        } else {
            session = request.getSession(false);
        }
        return session;
    }

    public static boolean isSessionNotAlive(HttpSession session) {
        if (session == null) {
            return true;
        }
        return false;
    }
}