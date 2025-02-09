package com.kleencleaners.models;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private int serviceId;
    private int quantity;
    private double totalPrice;
    private String status;
    private Timestamp orderDate;

    public Order(int id, int userId, int serviceId, int quantity, double totalPrice, String status, Timestamp orderDate) {
        this.id = id;
        this.userId = userId;
        this.serviceId = serviceId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.status = status;
        this.orderDate = orderDate;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
}
