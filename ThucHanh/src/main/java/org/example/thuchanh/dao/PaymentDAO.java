package org.example.thuchanh.dao;

import org.example.thuchanh.model.PaymentMethod;
import org.example.thuchanh.until.DBConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    public List<PaymentMethod> findAll() throws SQLException {
        List<PaymentMethod> list = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        ResultSet rs = conn.prepareStatement("SELECT * FROM payment_method").executeQuery();
        while (rs.next()) {
            list.add(new PaymentMethod(rs.getInt("id"), rs.getString("name")));
        }
        return list;
    }
}