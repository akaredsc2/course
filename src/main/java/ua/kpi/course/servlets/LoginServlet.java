package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String command = req.getParameter("command");
        switch (command) {
            case "login":
                HttpSession session = req.getSession();
                String userLogin = req.getParameter("user_login");
                session.setAttribute("user_login", userLogin);
                getServletContext().getRequestDispatcher("/about.jsp").forward(req, resp);
                break;
            case "logout":
                req.getSession().invalidate();
                getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
                break;
            default:
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                break;
        }
    }

}
