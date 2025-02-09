package com.kleencleaners.dao;

import com.kleencleaners.models.LaundryService;
import com.kleencleaners.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LaundryServiceDAO {
    public static List<LaundryService> getAllLaundryServices() {
        List<LaundryService> services = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM laundry_list";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                LaundryService service = new LaundryService(
                    rs.getInt("id"),
                    rs.getString("service_name"),
                    rs.getDouble("price")
                );
                services.add(service);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return services;
    }
}
