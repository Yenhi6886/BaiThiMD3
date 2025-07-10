package org.example.thuchanh.model;

public class Room {
    private int id;
    private String tenantName;
    private String phone;
    private String startDate;
    private int paymentMethodId;
    private String note;

    public Room() {}

    public Room(int id, String tenantName, String phone, String startDate, int paymentMethodId, String note) {
        this.id = id;
        this.tenantName = tenantName;
        this.phone = phone;
        this.startDate = startDate;
        this.paymentMethodId = paymentMethodId;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenantName() {
        return tenantName;
    }

    public void setTenantName(String tenantName) {
        this.tenantName = tenantName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public int getPaymentMethodId() {
        return paymentMethodId;
    }

    public void setPaymentMethodId(int paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}