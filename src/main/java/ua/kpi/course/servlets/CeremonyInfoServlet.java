package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "CeremonyInfoServlet", urlPatterns = "/ceremony_info")
public class CeremonyInfoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        final String userLogin = (String) session.getAttribute("user_login");
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT u_name,\n" +
                                "    u_groom_name, u_groom_surname, u_groom_birthday,\n" +
                                "    u_bride_name, u_bride_surname, u_bride_birthday,\n" +
                                "    c_date,\n" +
                                "    r_name, r_address, r_is_confirmed " +
                                "FROM ceremonyrestaurant " +
                                "WHERE u_name = '" + userLogin + "'");
                statement.executeQuery();

                ResultSet set = statement.getResultSet();

                if (set.next()) {
                    String groomInfo = set.getString(2) + " " + set.getString(3) + ", " + set.getDate(4);
                    req.setAttribute("cer_groom", groomInfo);

                    String brideInfo = set.getString(5) + " " + set.getString(6) + ", " + set.getDate(7);
                    req.setAttribute("cer_bride", brideInfo);

                    Date ceremonyDate = set.getDate(8);
                    req.setAttribute("cer_date", ceremonyDate);

                    String confirmationStatus = set.getInt(11) > 0 ? "confirmed" : "not confirmed";
                    String restaurantInfo = set.getString(9) + ", " + set.getString(10) + "," + confirmationStatus;
                    req.setAttribute("cer_rest", restaurantInfo);

                    getServletContext().getRequestDispatcher("/ceremony_info.jsp").forward(req, resp);
                } else {
                    req.setAttribute("problem", "failed to load ceremony");
                    getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
