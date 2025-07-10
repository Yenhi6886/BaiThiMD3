package org.example.thuchanh.dao;

import org.example.thuchanh.model.Room;
import org.example.thuchanh.until.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class RoomDAO {
    public List<Room> findAll(String keyword) throws SQLException {
        Connection conn = DBConnection.getConnection();
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM room";
        if (keyword != null && !keyword.isEmpty()) {
            sql += " WHERE id LIKE ? OR tenant_name LIKE ? OR phone LIKE ?";
        }
        PreparedStatement ps = conn.prepareStatement(sql);
        if (keyword != null && !keyword.isEmpty()) {
            for (int i = 1; i <= 3; i++) ps.setString(i, "%" + keyword + "%");
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Room(
                rs.getInt("id"),
                rs.getString("tenant_name"),
                rs.getString("phone"),
                rs.getString("start_date"),
                rs.getInt("payment_method_id"),
                rs.getString("note")
            ));
        }
        return list;
    }

    public void insert(Room room) throws SQLException {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO room(tenant_name, phone, start_date, payment_method_id, note) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, room.getTenantName());
        ps.setString(2, room.getPhone());
        ps.setString(3, room.getStartDate());
        ps.setInt(4, room.getPaymentMethodId());
        ps.setString(5, room.getNote());
        ps.executeUpdate();
    }

    public void deleteByIds(List<Integer> ids) throws SQLException {
        if (ids.isEmpty()) return;

        String inSql = ids.stream().map(i -> "?").collect(Collectors.joining(","));
        String sql = "DELETE FROM room WHERE id IN (" + inSql + ")";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < ids.size(); i++) {
                ps.setInt(i + 1, ids.get(i));
            }

            ps.executeUpdate();
        }
    }


}