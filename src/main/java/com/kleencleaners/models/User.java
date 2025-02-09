package com.kleencleaners.models;

import java.io.Serializable;

@SuppressWarnings("serial")
public class User implements Serializable {
    private int id;
    private String fname;
    private String lname;
    private String email;
    private String password;

    // Constructor
    public User(int id, String fname, String sname, String email, String password) {
        this.id = id;
        this.fname = fname;
        this.lname = sname;
        this.email = email;
        this.password = password;
    }

	// Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFname() { return fname; }
    public void setFname(String fname) { this.fname = fname; }

    public String getSname() { return lname; }
    public void setSname(String sname) { this.lname = sname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
