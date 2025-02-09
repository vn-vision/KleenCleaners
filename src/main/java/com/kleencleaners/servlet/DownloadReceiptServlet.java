package com.kleencleaners.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.kleencleaners.DBConnection;

@SuppressWarnings("serial")
@WebServlet("/DownloadReceiptServlet")
public class DownloadReceiptServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=receipt_" + orderId + ".pdf");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT o.id, o.total_price, o.order_date, i.item_name, i.price, i.quantity " +
                           "FROM orders o JOIN order_items i ON o.id = i.order_id WHERE o.id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            PdfDocument pdfDoc = new PdfDocument(new PdfWriter(response.getOutputStream()));
            Document document = new Document(pdfDoc);
            
            document.add(new Paragraph("KleenCleaners Receipt").setBold().setFontSize(18));
            document.add(new Paragraph("Order ID: " + orderId));
            
            Table table = new Table(3);
            table.addCell("Item Name");
            table.addCell("Quantity");
            table.addCell("Price (KES)");

            double totalPrice = 0;
            while (rs.next()) {
                table.addCell(rs.getString("item_name"));
                table.addCell(String.valueOf(rs.getInt("quantity")));
                table.addCell(String.valueOf(rs.getDouble("price")));
                totalPrice = rs.getDouble("total_price");
            }
            
            document.add(table);
            document.add(new Paragraph("Total Amount: KES " + totalPrice));
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
