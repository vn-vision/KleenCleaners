package com.kleencleaners.servlet;

import com.kleencleaners.dao.LaundryServiceDAO;
import com.kleencleaners.models.LaundryService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/LaundryListServlet")
public class LaundryListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<LaundryService> laundryServices = LaundryServiceDAO.getAllLaundryServices();
        request.setAttribute("laundryServices", laundryServices);
        request.getRequestDispatcher("laundry-list.jsp").forward(request, response);
    }
}
