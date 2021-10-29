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
import model.inventory.Category;
import model.inventory.Product;
import model.inventory.Supplier;

/**
 *
 * @author quynm
 */
public class ProductDBContext extends DBContext {

    public ArrayList<Product> getProducts(int cateID, int supID, int pageIndex, int pageSize) {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String table_rowNum = "SELECT ROW_NUMBER() OVER (ORDER BY [ProductID] ASC) as rownum, * \n"
                    + "         FROM [Products] WHERE 1=1 ";
            ArrayList<Integer> params = new ArrayList<>();
            if (cateID != 0) {
                table_rowNum += " AND [CategoryID] = ? ";
                params.add(cateID);
            }
            if (supID != 0) {
                table_rowNum += " AND [SupplierID] = ? ";
                params.add(supID);
            }

            String sql = "SELECT [ProductID]\n"
                    + "      ,[ProductName]\n"
                    + "      ,[CategoryID]\n"
                    + "      ,[SupplierID]\n"
                    + "      ,[unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[unitPrice]\n"
                    + "      ,[isActive]\n"
                    + "      ,[Comment]\n"
                    + "	  ,(SELECT COUNT (*) FROM [ReceiptDetail] WHERE [ProductID] = p.[ProductID]) as totalReceipt\n"
                    + "  FROM "
                    + "  ( " + table_rowNum + " ) as p "
                    + "  WHERE rownum >= (? - 1)*? + 1 AND rownum <= ? * ? ";

            PreparedStatement stm = connection.prepareStatement(sql);
            for (int i = 0; i < params.size(); i++) {
                stm.setInt(i + 1, params.get(i));
            }
            stm.setInt(params.size() + 1, pageIndex);
            stm.setInt(params.size() + 2, pageSize);
            stm.setInt(params.size() + 3, pageIndex);
            stm.setInt(params.size() + 4, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                CategoryDBContext cdb = new CategoryDBContext();
                Category cat = cdb.getCategory(rs.getInt(3));

                SupplierDBContext sdb = new SupplierDBContext();
                Supplier sup = sdb.getSupplier(rs.getInt(4));

                Product pro = new Product(rs.getString(1), rs.getString(2), cat, sup,
                        rs.getString(5), rs.getDouble(6), rs.getDouble(7), rs.getString(9), rs.getBoolean(8));
                pro.setUsed(rs.getInt("totalReceipt") > 0);
                products.add(pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public Product getProduct(String id) {
        try {
            String sql = "SELECT [ProductID]\n"
                    + "      ,[ProductName]\n"
                    + "      ,[CategoryID]\n"
                    + "      ,[SupplierID]\n"
                    + "      ,[unit]\n"
                    + "      ,[Quantity]\n"
                    + "      ,[unitPrice]\n"
                    + "      ,[isActive]\n"
                    + "      ,[Comment]\n"
                    + "	  ,(SELECT COUNT (*) FROM [ReceiptDetail] WHERE [ProductID] = p.[ProductID]) as totalReceipt\n"
                    + "  FROM [Products] as p "
                    + "  WHERE [ProductID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                CategoryDBContext cdb = new CategoryDBContext();
                Category cat = cdb.getCategory(rs.getInt(3));

                SupplierDBContext sdb = new SupplierDBContext();
                Supplier sup = sdb.getSupplier(rs.getInt(4));

                Product pro = new Product(rs.getString(1), rs.getString(2), cat, sup,
                        rs.getString(5), rs.getDouble(6), rs.getDouble(7), rs.getString(9), rs.getBoolean(8));
                pro.setUsed(rs.getInt("totalReceipt") > 0);
                return pro;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertProduct(Product product) {
        try {
            String sql = "INSERT INTO [Products]\n"
                    + "           ([ProductID]\n"
                    + "           ,[ProductName]\n"
                    + "           ,[CategoryID]\n"
                    + "           ,[SupplierID]\n"
                    + "           ,[unit]\n"
                    + "           ,[Quantity]\n"
                    + "           ,[unitPrice]\n"
                    + "           ,[isActive]\n"
                    + "           ,[Comment])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?,?,?,?,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, product.getId());
            stm.setString(2, product.getName());
            stm.setInt(3, product.getCategory().getId());
            stm.setInt(4, product.getSupplier().getId());
            stm.setString(5, product.getUnit());
            stm.setDouble(6, product.getQuantity());
            stm.setDouble(7, product.getUnitPrice());
            stm.setBoolean(8, product.isActive());
            stm.setString(9, product.getComment());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateProduct(Product product) {
        try {
            String sql = "UPDATE [Products]\n"
                    + "   SET [ProductName] = ?\n"
                    + "      ,[CategoryID] = ?\n"
                    + "      ,[SupplierID] = ?\n"
                    + "      ,[unit] = ?\n"
                    + "      ,[Quantity] = ?\n"
                    + "      ,[unitPrice] = ?\n"
                    + "      ,[isActive] = ?\n"
                    + "      ,[Comment] = ?\n"
                    + " WHERE [ProductID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, product.getName());
            stm.setInt(2, product.getCategory().getId());
            stm.setInt(3, product.getSupplier().getId());
            stm.setString(4, product.getUnit());
            stm.setDouble(5, product.getQuantity());
            stm.setDouble(6, product.getUnitPrice());
            stm.setBoolean(7, product.isActive());
            stm.setString(8, product.getComment());
            stm.setString(9, product.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteProduct(String id) {
        try {
            String sql = "DELETE FROM [Products]"
                    + " WHERE [ProductID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void inactiveProduct(String id) {
        try {
            String sql = "UPDATE [Products]\n"
                    + "   SET [isActive] = 0\n"
                    + " WHERE [ProductID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int countProducts(int cateID, int supID) {
        try {
            String sql = "SELECT COUNT(*) as total \n"
                    + "  FROM [Products] "
                    + "  WHERE 1=1 ";
            ArrayList<Integer> params = new ArrayList<>();
            if (cateID != 0) {
                sql += " AND [CategoryID] = ? ";
                params.add(cateID);
            }
            if (supID != 0) {
                sql += " AND [SupplierID] = ? ";
                params.add(supID);
            }

            PreparedStatement stm = connection.prepareStatement(sql);

            for (int i = 0; i < params.size(); i++) {
                stm.setInt(i + 1, params.get(i));
            }

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
