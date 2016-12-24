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

@WebServlet(name = "NewCeremonyServlet", urlPatterns = {"/new_ceremony"})
public class NewCeremonyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
/*
    private void doDisplay(HttpServletRequest request) {
        HttpSession session = request.getSession();
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

                if (set.next() && set.getDate(8) != null) {
                    String groomInfo = set.getString(2) + " " + set.getString(3) + ", " + set.getDate(4);
                    request.setAttribute("cer_groom", groomInfo);

                    String brideInfo = set.getString(5) + " " + set.getString(6) + ", " + set.getDate(7);
                    request.setAttribute("cer_bride", brideInfo);

                    Date ceremonyDate = set.getDate(8);
                    request.setAttribute("cer_date", ceremonyDate);

                    String confirmationStatus = set.getInt(11) > 0 ? "confirmed" : "not confirmed";
                    String restaurantInfo = set.getString(9) + ", " + set.getString(10) + "," + confirmationStatus;
                    request.setAttribute("cer_bride", restaurantInfo);

                } else {

                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
*/
}
