/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.inventory;

import dal.DBContext;
import dal.account.AccountDBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.account.Account;
import model.inventory.Delivery;
import model.inventory.DeliveryDetail;
import model.inventory.Product;

/**
 *
 * @author quynm
 */
public class DeliveryDBContext extends DBContext {

    public int insertDelivery(Delivery delivery, ArrayList<DeliveryDetail> dds) {
        try {
            connection.setAutoCommit(false);
            //create delivery
            String sql_D = "INSERT INTO [Delivery]\n"
                    + "           ([DeliveryDate]\n"
                    + "           ,[DeliveryTime]\n"
                    + "           ,[Exporter]\n"
                    + "           ,[Recipient]\n"
                    + "           ,[Comment])\n"
                    + "     VALUES (?,?,?,?,?)";
            PreparedStatement stm_D = connection.prepareStatement(sql_D);
            stm_D.setDate(1, delivery.getDate());
            stm_D.setTime(2, delivery.getTime());
            stm_D.setString(3, delivery.getExporter().getUsername());
            stm_D.setString(4, delivery.getRecipient());
            stm_D.setString(5, delivery.getComment());
            stm_D.executeUpdate();

            //get delivery ID has already added
            String sql_get_did = "SELECT @@IDENTITY as did";
            PreparedStatement stm_get_did = connection.prepareStatement(sql_get_did);
            ResultSet rs = stm_get_did.executeQuery();
            if (rs.next()) {
                delivery.setId(rs.getInt("did"));
            }

            for (DeliveryDetail dd : dds) {
                //insert to delivery detail
                String sql_DD = "INSERT INTO [DeliveryDetail]\n"
                        + "           ([DeliveryID]\n"
                        + "           ,[ProductID]\n"
                        + "           ,[Quantity]\n"
                        + "           ,[Comment])\n"
                        + "     VALUES (?,?,?,?)";
                PreparedStatement stm_DD = connection.prepareStatement(sql_DD);
                stm_DD.setInt(1, delivery.getId());
                stm_DD.setString(2, dd.getProduct().getId());
                stm_DD.setDouble(3, dd.getQuantity());
                stm_DD.setString(4, dd.getComment());
                stm_DD.executeUpdate();

                //update Quantity to product
                String sql_up = "UPDATE [Products]\n"
                        + "   SET [Quantity] = ?\n"
                        + " WHERE [ProductID] = ?";
                PreparedStatement stm_up = connection.prepareStatement(sql_up);
                //dd.getProduct.quantity is the quantity of product in warehouse
                //dd.getQuantity is the quantity to delivery read from user
                stm_up.setDouble(1, dd.getProduct().getQuantity());
                stm_up.setString(2, dd.getProduct().getId());
                stm_up.executeUpdate();

                //update inStock in receiptDetail
                //goods are delivery in order to oldest received first by default
                double quantity = dd.getQuantity();
                while (quantity > 0) {
                    double oldestQuantityInStock = 0;
                    int oldest_in_stock_receiptID = 0;
                    //get oldest inStock value and row id to update
                    String sql_get_oldest_instock = "SELECT [ReceiptID], [inStock]\n"
                            + "FROM [ReceiptDetail]\n"
                            + "WHERE [ProductID] = ? \n"
                            + "     AND [ReceiptID] = (SELECT TOP 1 r.[ReceiptID]\n"
                            + "                         FROM [ReceiptDetail] as rd JOIN [Receipt] as r \n"
                            + "                         ON rd.ReceiptID = r.ReceiptID\n"
                            + "                         WHERE [ProductID] = ? AND [inStock] > 0\n"
                            + "                         ORDER BY [ReceiptDate], [ReceiptTime])";
                    PreparedStatement stm_get_oldest_instock = connection.prepareStatement(sql_get_oldest_instock);
                    stm_get_oldest_instock.setString(1, dd.getProduct().getId());
                    stm_get_oldest_instock.setString(2, dd.getProduct().getId());
                    ResultSet rs1 = stm_get_oldest_instock.executeQuery();
                    if (rs1.next()) {
                        oldest_in_stock_receiptID = rs1.getInt(1);
                        oldestQuantityInStock = rs1.getDouble(2);
                    }

                    double valueToUpdate = (quantity < oldestQuantityInStock) ? (oldestQuantityInStock - quantity) : 0;
                    //update
                    String sql_uv = "UPDATE [ReceiptDetail]\n"
                            + "   SET [inStock] = ?\n"
                            + " WHERE [ProductID] = ? \n"
                            + "     AND [ReceiptID] = ?";
                    PreparedStatement stm_uv = connection.prepareStatement(sql_uv);
                    stm_uv.setDouble(1, valueToUpdate);
                    stm_uv.setString(2, dd.getProduct().getId());
                    stm_uv.setInt(3, oldest_in_stock_receiptID);
                    stm_uv.executeUpdate();

                    //update quantity for new iterator
                    quantity -= oldestQuantityInStock;
                }
            }
            connection.commit();
            return delivery.getId();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(DeliveryDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(DeliveryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(DeliveryDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return 0;
    }

    public Delivery getDelivery(int id) {
        try {
            String sql = "SELECT [DeliveryID]\n"
                    + "      ,[DeliveryDate]\n"
                    + "      ,[DeliveryTime]\n"
                    + "      ,[Exporter]\n"
                    + "      ,[Recipient]\n"
                    + "      ,[Comment]\n"
                    + "  FROM [Delivery]\n"
                    + "  WHERE [DeliveryID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                AccountDBContext adb = new AccountDBContext();
                Account exporter = adb.getAccount(rs.getString("Exporter"));

                Delivery delivery = new Delivery(id, rs.getDate(2), rs.getTime(3),
                        exporter, rs.getString(5), rs.getString(6));
                return delivery;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<DeliveryDetail> getDeliveryDetails(int deliveryID) {
        ArrayList<DeliveryDetail> deliveryDetails = new ArrayList<>();
        try {
            String sql = "SELECT [DeliveryID]\n"
                    + "      ,[ProductID]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[Comment]\n"
                    + "  FROM [DeliveryDetail]\n"
                    + "  WHERE [DeliveryID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, deliveryID);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                ProductDBContext pdb = new ProductDBContext();
                Product product = pdb.getProduct(rs.getString("ProductID"));
                DeliveryDetail dd = new DeliveryDetail(deliveryID, product, rs.getDouble(3), rs.getString(4));
                deliveryDetails.add(dd);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DeliveryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return deliveryDetails;
    }
}
