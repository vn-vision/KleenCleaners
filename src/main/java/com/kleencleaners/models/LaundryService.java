package com.kleencleaners.models;

public class LaundryService {
    private int id;
    private String serviceName;
    private double price;

    public LaundryService(int id, String serviceName, double price) {
        this.id = id;
        this.serviceName = serviceName;
        this.price = price;
    }

    // Getters
    public int getId() { return id; }
    public String getServiceName() { return serviceName; }
    public double getPrice() { return price; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    public void setPrice(double price) { this.price = price; }
}
