package ua.kpi.course.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.Map;
import java.util.TreeMap;

import static ua.kpi.course.util.ConnectionProperties.*;

@WebServlet(name = "CeremonySwitchServlet", urlPatterns = "/ceremony_switch")
public class CeremonySwitchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final String userLogin = (String) req.getSession().getAttribute("user_login");
        try {
            Class.forName(DRIVER);

            try (Connection connection = DriverManager.getConnection(URL, LOGIN, PASSWORD)) {
                PreparedStatement statement = connection.prepareStatement(
                        "SELECT c_date FROM ceremonyDates WHERE u_name = '" + userLogin + "'");
                statement.executeQuery();

                ResultSet resultSet = statement.getResultSet();

                if (resultSet.next()) {
                    getServletContext().getRequestDispatcher("/ceremony.jsp").forward(req, resp);
                } else {
                    Map<Integer, String> restaurantMap = new TreeMap<>();
                    PreparedStatement restaurantStatement = connection.prepareStatement(
                            "SELECT r_contract, r_name, r_address, r_price_per_day FROM viewrestaurants ORDER BY 1 ASC");

                    restaurantStatement.executeQuery();

                    ResultSet restaurantResultSet = restaurantStatement.getResultSet();
                    while (restaurantResultSet.next()) {
                        String restaurantInfo = restaurantResultSet.getString(2) + ", " +
                                restaurantResultSet.getString(3) + ", " +
                                restaurantResultSet.getString(4) + " money units per day";

                        restaurantMap.put(restaurantResultSet.getInt(1), restaurantInfo);
                    }
                    restaurantStatement.close();
                    req.setAttribute("restMap", restaurantMap);

                    Map<Integer, String> artistMap = new TreeMap<>();
                    PreparedStatement artistStatement = connection.prepareStatement(
                            "SELECT a_contract, a_name, a_genre, a_price_per_day FROM viewartists ORDER BY 1 ASC");
                    artistStatement.executeQuery();
                    ResultSet artistResultSet = artistStatement.getResultSet();
                    while (artistResultSet.next()) {
                        String artistInfo = artistResultSet.getString(2) + ", " +
                                artistResultSet.getString(3) + ", " +
                                artistResultSet.getString(4) + " money units per day";

                        artistMap.put(artistResultSet.getInt(1), artistInfo);
                    }
                    req.setAttribute("artMap", artistMap);

                    getServletContext().getRequestDispatcher("/new_ceremony.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            getServletContext().getRequestDispatcher("/error.jsp").forward(req, resp);
            e.printStackTrace();
        }
    }

}
