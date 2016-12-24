package ua.kpi.course.servlets;

import ua.kpi.course.util.ConnectionProperties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "PersonalPageServlet", urlPatterns = "/personal_page")
public class PersonalPageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String command = req.getParameter("command");

        switch (command) {
            case "load":
                HttpSession session = req.getSession();
                final String userLogin = (String) session.getAttribute("user_login");
                try {
                    Class.forName(ConnectionProperties.DRIVER);

                    try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                        PreparedStatement statement = connection.prepareStatement(
                                "SELECT u_name, u_email, u_is_manager," +
                                        "    u_groom_name, u_groom_surname, u_groom_birthday, " +
                                        "    u_bride_name, u_bride_surname, u_bride_birthday " +
                                        "FROM PersonalInfo " +
                                        "WHERE u_name = '" + userLogin + "'");
                        statement.executeQuery();

                        ResultSet resultSet = statement.getResultSet();

                        if (resultSet.next()) {
                            req.setAttribute("user_name", resultSet.getString(1));
                            req.setAttribute("user_email", resultSet.getString(2));
                            String userStatus = resultSet.getInt(3) > 0 ? "manager" : "regular";
                            req.setAttribute("user_status", userStatus);

                            req.setAttribute("user_groom_name", resultSet.getString(4));
                            req.setAttribute("user_groom_surname", resultSet.getString(5));
                            req.setAttribute("user_groom_birthday", resultSet.getDate(6));

                            req.setAttribute("user_bride_name", resultSet.getString(7));
                            req.setAttribute("user_bride_surname", resultSet.getString(8));
                            req.setAttribute("user_bride_birthday", resultSet.getDate(9));
                            getServletContext().getRequestDispatcher("/personal_page.jsp").forward(req, resp);
                        } else {
                            req.setAttribute("problem", "failed to get personal data");
                            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                break;
            case "update":
                break;
            default:
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                break;
        }
    }

}
