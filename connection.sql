import java.sql.*;
import java.util.Scanner;

public class Main {
    private static final String url = "jdbc:postgresql://localhost:5432/users";
    private static final String user = "postgres";
    private static final String password = "postgres";

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Please, enter the product type: ");
        String productName = sc.next();
        System.out.println("Please, enter the product cost: ");
        int productCost = sc.nextInt();
        System.out.println("Please, enter the cost value to search: ");
        int costToSearch = sc.nextInt();
        String insertSQL = "INSERT INTO Product VALUES (?, ?)";
        String selectSQL = "SELECT * FROM  Product WHERE productCost > ?";
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet resultSet = null;
        try {
            con = DriverManager.getConnection(url, user, password);
            stmt = con.prepareStatement(insertSQL);
            stmt.setString(1, productName);
            stmt.setInt(2, productCost);
            stmt.executeUpdate();
            stmt = con.prepareStatement(selectSQL);
            stmt.setInt(1, costToSearch);
            resultSet = stmt.executeQuery();
            while (resultSet.next()) {
                System.out.println("Product type: " + resultSet.getString(1));
                System.out.println("Product cost: " + resultSet.getInt(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                }
            }
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                }
            }
        }
    }


}
