/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.inventory;

import dal.DBContext;
import dal.account.AccountDBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.account.Account;
import model.inventory.Product;
import model.inventory.Receipt;
import model.inventory.ReceiptDetail;
import model.inventory.Supplier;

/**
 *
 * @author quynm
 */
public class ReceiptDBContext extends DBContext {

    public int insertReceipt(Receipt receipt, ArrayList<ReceiptDetail> rds) {
        try {
            connection.setAutoCommit(false);
            //create a receipt
            String sql_R = "INSERT INTO [Receipt]\n"
                    + "           ([ReceiptDate]\n"
                    + "           ,[ReceiptTime]\n"
                    + "           ,[Importer]\n"
                    + "           ,[SupplierID]\n"
                    + "           ,[Shipper]\n"
                    + "           ,[Comment])\n"
                    + "     VALUES(?,?,?,?,?,?)";
            PreparedStatement stm_R = connection.prepareStatement(sql_R);
            stm_R.setDate(1, receipt.getDate());
            stm_R.setTime(2, receipt.getTime());
            stm_R.setString(3, receipt.getImporter().getUsername());
            stm_R.setInt(4, receipt.getSupplier().getId());
            stm_R.setString(5, receipt.getShipper());
            stm_R.setString(6, receipt.getComment());
            stm_R.executeUpdate();

            //getReceiptID has already added
            String sql_get_rid = "SELECT @@IDENTITY as rid";
            PreparedStatement stm_get_rid = connection.prepareStatement(sql_get_rid);
            ResultSet rs = stm_get_rid.executeQuery();
            if (rs.next()) {
                receipt.setId(rs.getInt("rid"));
            }

            for (ReceiptDetail rd : rds) {
                //insert to receipt detail
                String sql_RD = "INSERT INTO [ReceiptDetail]\n"
                        + "           ([ReceiptID]\n"
                        + "           ,[ProductID]\n"
                        + "           ,[unitPrice]\n"
                        + "           ,[Quantity]\n"
                        + "           ,[inStock]\n"
                        + "           ,[ExpDate]\n"
                        + "           ,[MfgDate]\n"
                        + "           ,[Comment])\n"
                        + "     VALUES (?,?,?,?,?,?,?,?)";
                PreparedStatement stm_RD = connection.prepareStatement(sql_RD);
                stm_RD.setInt(1, receipt.getId());
                stm_RD.setString(2, rd.getProduct().getId());
                stm_RD.setDouble(3, rd.getUnitPrice());
                stm_RD.setDouble(4, rd.getQuantity());
                stm_RD.setDouble(5, rd.getQuantity());
                stm_RD.setDate(6, rd.getExp());
                stm_RD.setDate(7, rd.getMgf());
                stm_RD.setString(8, rd.getComment());
                stm_RD.executeUpdate();

                //update quantity to product
                String sql_up = "UPDATE [Products]\n"
                        + "   SET [Quantity] = ?\n"
                        + " WHERE [ProductID] = ?";
                PreparedStatement stm_up = connection.prepareStatement(sql_up);
                //rd.getProduct.quantity is the quantity of product in warehouse
                //rd.getQuantity is the quantity to receipt read from user
                stm_up.setDouble(1, rd.getProduct().getQuantity());
                stm_up.setString(2, rd.getProduct().getId());
                stm_up.executeUpdate();
            }
            connection.commit();
            return receipt.getId();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return 0; //failed
    }

    public Receipt getReceipt(int id) {
        try {
            String sql = "SELECT [ReceiptID]\n"
                    + "      ,[ReceiptDate]\n"
                    + "      ,[ReceiptTime]\n"
                    + "      ,[Importer]\n"
                    + "      ,[SupplierID]\n"
                    + "      ,[Shipper]\n"
                    + "      ,[Comment]\n"
                    + "  FROM [Receipt] "
                    + "  WHERE [ReceiptID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                AccountDBContext adb = new AccountDBContext();
                Account account = adb.getAccount(rs.getString("importer"));
                SupplierDBContext sdb = new SupplierDBContext();
                Supplier supplier = sdb.getSupplier(rs.getInt("supplierID"));
                Receipt r = new Receipt(rs.getInt(1), rs.getDate(2), rs.getTime(3),
                        account, supplier, rs.getString(6), rs.getString(7));
                return r;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public ArrayList<ReceiptDetail> getReceiptDetails(int receiptID) {
        ArrayList<ReceiptDetail> rds = new ArrayList<>();
        try {
            String sql = "SELECT [ReceiptID]\n"
                    + "      ,[ProductID]\n"
                    + "      ,[unitPrice]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[inStock]\n"
                    + "      ,[ExpDate]\n"
                    + "      ,[MfgDate]\n"
                    + "      ,[Comment]\n"
                    + "  FROM [ReceiptDetail]\n"
                    + "  WHERE [ReceiptID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, receiptID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ProductDBContext pdb = new ProductDBContext();
                Product product = pdb.getProduct(rs.getString("ProductID"));
                ReceiptDetail rd = new ReceiptDetail(receiptID, product, rs.getDouble(3),
                        rs.getDouble(4), rs.getDouble(5), rs.getDate(6), rs.getDate(7), rs.getString(8));
                rds.add(rd);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rds;
    }

    public ArrayList<Receipt> getAllReceipts() {
        ArrayList<Receipt> receipts = new ArrayList<>();
        try {
            String sql = "SELECT [ReceiptID]\n"
                    + "      ,[ReceiptDate]\n"
                    + "      ,[ReceiptTime]\n"
                    + "      ,[Importer]\n"
                    + "      ,[SupplierID]\n"
                    + "      ,[Shipper]\n"
                    + "      ,[Comment]\n"
                    + "  FROM [Receipt]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AccountDBContext adb = new AccountDBContext();
                Account importer = adb.getAccount(rs.getString("Importer"));

                SupplierDBContext sdb = new SupplierDBContext();
                Supplier supplier = sdb.getSupplier(rs.getInt("SupplierID"));

                Receipt receipt = new Receipt(rs.getInt(1), rs.getDate(2), rs.getTime(3),
                        importer, supplier, rs.getString(6), rs.getString(7));
                receipts.add(receipt);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return receipts;
    }

    public ArrayList<Receipt> getAllReceipts(Date from, Date to, int supID) {
        ArrayList<Receipt> receipts = new ArrayList<>();
        try {
            String sql = "SELECT [ReceiptID]\n"
                    + "      ,[ReceiptDate]\n"
                    + "      ,[ReceiptTime]\n"
                    + "      ,[Importer]\n"
                    + "      ,[SupplierID]\n"
                    + "      ,[Shipper]\n"
                    + "      ,[Comment]\n"
                    + "  FROM [Receipt]"
                    + "  WHERE 1 = 1 ";
            HashMap<Integer, String[]> params = new HashMap<>();
            int countParam = 0;
            if (from != null) {
                sql += " AND [ReceiptDate] >= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = from + "";
                params.put(countParam, param);
            }
            if (to != null) {
                sql += " AND [ReceiptDate] <= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = to + "";
                params.put(countParam, param);
            }
            if (supID != 0) {
                sql += " AND [SupplierID] = ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Integer.class.getName();
                param[1] = supID + "";
                params.put(countParam, param);
            }
            PreparedStatement stm = connection.prepareStatement(sql);
            //Assign value for param
            for (Map.Entry<Integer, String[]> entry : params.entrySet()) {
                Integer key = entry.getKey();
                String[] value = entry.getValue();

                if (value[0].equals(Integer.class.getName())) {
                    stm.setInt(key, Integer.parseInt(value[1]));
                }
                if (value[0].equals(Date.class.getName())) {
                    stm.setDate(key, Date.valueOf(value[1]));
                }
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AccountDBContext adb = new AccountDBContext();
                Account importer = adb.getAccount(rs.getString("Importer"));

                SupplierDBContext sdb = new SupplierDBContext();
                Supplier supplier = sdb.getSupplier(rs.getInt("SupplierID"));

                Receipt receipt = new Receipt(rs.getInt(1), rs.getDate(2), rs.getTime(3),
                        importer, supplier, rs.getString(6), rs.getString(7));
                receipts.add(receipt);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return receipts;
    }

    public double getReceiptValue(int id) {
        double value = 0;
        try {
            String sql = "SELECT [unitPrice]\n"
                    + "      ,[Quantity]\n"
                    + "  FROM [ReceiptDetail]\n"
                    + "  WHERE [ReceiptID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                value += rs.getDouble(1) * rs.getDouble(2);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return value;
    }

    public void deleteReceipt(int rid, ArrayList<ReceiptDetail> receiptDetails) {
        try {
            connection.setAutoCommit(false);

            for (ReceiptDetail rd : receiptDetails) {
                //update Quantity in Product table
                String sql_up = "UPDATE [Products]\n"
                        + "   SET [Quantity] = ((SELECT [Quantity]\n"
                        + "			FROM [Products]\n"
                        + "			WHERE [ProductID] = ?) - ?) \n"
                        + " WHERE [ProductID] = ? ";
                PreparedStatement stm_up = connection.prepareStatement(sql_up);
                stm_up.setString(1, rd.getProduct().getId());
                stm_up.setDouble(2, rd.getProduct().getQuantity());
                stm_up.setString(3, rd.getProduct().getId());
                stm_up.executeUpdate();
            }
            //delete in receipt Detail
            String sql_rd = "DELETE FROM [ReceiptDetail]\n"
                    + "      WHERE [ReceiptID] = ? ";
            PreparedStatement stm_rd = connection.prepareStatement(sql_rd);
            stm_rd.setInt(1, rid);
            stm_rd.executeUpdate();
            
            //delete in Receipt
            String sql_r = "DELETE FROM [Receipt]\n"
                    + "      WHERE [ReceiptID] = ? ";
            PreparedStatement stm_r = connection.prepareStatement(sql_r);
            stm_r.setInt(1, rid);
            stm_r.executeUpdate();
            
            //CH??A C???P NH???T INSTOCK

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(ReceiptDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
