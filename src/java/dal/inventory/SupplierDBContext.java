/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.inventory;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.inventory.Supplier;

/**
 *
 * @author quynm
 */
public class SupplierDBContext extends DBContext {

    public ArrayList<Supplier> getSuppliers() {
        ArrayList<Supplier> suppliers = new ArrayList<>();
        try {
            String sql = "SELECT [SupplierID]\n"
                    + "      ,[CompanyName]\n"
                    + "      ,[ContactName]\n"
                    + "      ,[Phone]\n"
                    + "      ,[Email]\n"
                    + "      ,[Address]\n"
                    + "      ,[Province]\n"
                    + "      ,[District]\n"
                    + "      ,[isActive]\n"
                    + "      ,[Comment]\n"
                    + "      ,(SELECT COUNT(*) "
                    + "         FROM [Products] "
                    + "         WHERE [SupplierID] = s.[SupplierID]) as totalProduct\n"
                    + "  FROM [Suppliers] as s";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Supplier sup = new Supplier(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
                        rs.getString(8), rs.getBoolean(9), rs.getString(10));
                sup.setUsed(rs.getInt("totalProduct") > 0);
                suppliers.add(sup);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return suppliers;
    }

    public Supplier getSupplier(int id) {
        try {
            String sql = "SELECT [SupplierID]\n"
                    + "      ,[CompanyName]\n"
                    + "      ,[ContactName]\n"
                    + "      ,[Phone]\n"
                    + "      ,[Email]\n"
                    + "      ,[Address]\n"
                    + "      ,[Province]\n"
                    + "      ,[District]\n"
                    + "      ,[isActive]\n"
                    + "      ,[Comment]\n"
                    + "      ,(SELECT COUNT(*)"
                    + "         FROM [Products] "
                    + "         WHERE [SupplierID] = s.[SupplierID]) as totalProduct\n"
                    + "  FROM [Suppliers] as s "
                    + "  WHERE [SupplierID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Supplier sup = new Supplier(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
                        rs.getString(8), rs.getBoolean(9), rs.getString(10));
                sup.setUsed(rs.getInt("totalProduct") > 0);
                return sup;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void inserSupplier(Supplier sup) {
        try {
            String sql = "INSERT INTO [Suppliers]\n"
                    + "           ([CompanyName]\n"
                    + "           ,[ContactName]\n"
                    + "           ,[Phone]\n"
                    + "           ,[Email]\n"
                    + "           ,[Address]\n"
                    + "           ,[Province]\n"
                    + "           ,[District]\n"
                    + "           ,[isActive]\n"
                    + "           ,[Comment])\n"
                    + "     VALUES (?,?,?,?,?,?,?,?,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sup.getCompanyName());
            stm.setString(2, sup.getContactName());
            stm.setString(3, sup.getPhone());
            stm.setString(4, sup.getEmail());
            stm.setString(5, sup.getAddress());
            stm.setString(6, sup.getProvince());
            stm.setString(7, sup.getDistrict());
            stm.setBoolean(8, sup.isActive());
            stm.setString(9, sup.getComment());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateSupplier(Supplier sup) {
        try {
            String sql = "UPDATE [Suppliers]\n"
                    + "   SET [CompanyName] = ?\n"
                    + "      ,[ContactName] = ?\n"
                    + "      ,[Phone] = ?\n"
                    + "      ,[Email] = ?\n"
                    + "      ,[Address] = ?\n"
                    + "      ,[Province] = ?\n"
                    + "      ,[District] = ?\n"
                    + "      ,[isActive] = ?\n"
                    + "      ,[Comment] = ?\n"
                    + " WHERE [SupplierID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sup.getCompanyName());
            stm.setString(2, sup.getContactName());
            stm.setString(3, sup.getPhone());
            stm.setString(4, sup.getEmail());
            stm.setString(5, sup.getAddress());
            stm.setString(6, sup.getProvince());
            stm.setString(7, sup.getDistrict());
            stm.setBoolean(8, sup.isActive());
            stm.setString(9, sup.getComment());
            stm.setInt(10, sup.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteSupplier(int id) {
        try {
            String sql = "DELETE FROM [Suppliers]\n"
                    + "      WHERE [SupplierID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void inactiveSupplier(int id) {
        try {
            String sql = "UPDATE [Suppliers]\n"
                    + "   SET [isActive] = 0\n"
                    + " WHERE [SupplierID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SupplierDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
