/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.inventory;

import dal.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.inventory.Category;
import model.inventory.Product;
import model.inventory.ProductExpirationReport;
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

    public ArrayList<Product> getProductsInOut(int cateID, int supID, Date from, Date to, int pageIndex, int pageSize) {
        ArrayList<Product> products = new ArrayList<>();
        try {
            HashMap<Integer, String[]> params = new HashMap<>();
            int countParam = 0;
            //sub query get total receipt
            String getTotalReceipt = "SELECT SUM(Quantity) \n"
                    + "		FROM [ReceiptDetail] rd JOIN [Receipt] r ON rd.ReceiptID = r.ReceiptID\n"
                    + "		WHERE [ProductID] = p.[ProductID] ";
            if (from != null) {
                getTotalReceipt += "AND [ReceiptDate] >= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = from + "";
                params.put(countParam, param);
            }
            if (to != null) {
                getTotalReceipt += "AND [ReceiptDate] <= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = to + "";
                params.put(countParam, param);
            }
            //sub query get total receipt amount
            String getTotalReceiptAmount = "SELECT SUM(Quantity * unitPrice) \n"
                    + "		FROM [ReceiptDetail] rd JOIN [Receipt] r ON rd.ReceiptID = r.ReceiptID\n"
                    + "		WHERE [ProductID] = p.[ProductID] ";
            if (from != null) {
                getTotalReceiptAmount += "AND [ReceiptDate] >= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = from + "";
                params.put(countParam, param);
            }
            if (to != null) {
                getTotalReceiptAmount += "AND [ReceiptDate] <= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = to + "";
                params.put(countParam, param);
            }

            //sub query get total delivery
            String getTotalDelivery = "SELECT SUM(dd.Quantity)\n"
                    + "FROM [DeliveryDetail] dd INNER JOIN [Delivery] d ON dd.DeliveryID = d.DeliveryID\n"
                    + "WHERE dd.[ProductID] = p.[ProductID] ";
            if (from != null) {
                getTotalDelivery += "AND [DeliveryDate] >= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = from + "";
                params.put(countParam, param);
            }
            if (to != null) {
                getTotalDelivery += "AND [DeliveryDate] <= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = to + "";
                params.put(countParam, param);
            }

            //subquery table to pagging
            String table_rowNum = "SELECT ROW_NUMBER() OVER (ORDER BY [ProductID] ASC) as rownum, * \n"
                    + "         FROM [Products] WHERE 1=1 ";
            if (cateID != 0) {
                table_rowNum += " AND [CategoryID] = ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Integer.class.getName();
                param[1] = cateID + "";
                params.put(countParam, param);
            }
            if (supID != 0) {
                table_rowNum += " AND [SupplierID] = ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Integer.class.getName();
                param[1] = supID + "";
                params.put(countParam, param);
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
                    + "      ,( " + getTotalReceipt + ") as TotalReceipt "
                    + "      ,( " + getTotalReceiptAmount + ") as TotalReceiptAmount "
                    + "      ,( " + getTotalDelivery + ") as TotalDelivery "
                    + "  FROM "
                    + "  ( " + table_rowNum + " ) as p "
                    + "  WHERE rownum >= (? - 1)*? + 1 AND rownum <= ? * ? ";

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
                pro.setTotalReceived(rs.getDouble("TotalReceipt"));
                pro.setTotalReceivedAmount(rs.getDouble("TotalReceiptAmount"));
                pro.setTotalDelivered(rs.getDouble("TotalDelivery"));
                pro.setTotalDeliveredAmount(pro.getTotalDelivered() * pro.getUnitPrice());
                products.add(pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public double getTotalAllReceivedAmount(int cateID, int supID, Date from, Date to) {
        try {
            HashMap<Integer, String[]> params = new HashMap<>();
            int countParam = 0;
            //sub query get total receipt amount
            String sql = "SELECT SUM(rd.Quantity * rd.unitPrice) as TotalReceiptAmount \n"
                    + "		FROM [ReceiptDetail] rd JOIN [Receipt] r ON rd.ReceiptID = r.ReceiptID"
                    + "                                 JOIN [Products] p ON rd.[ProductID] = p.[ProductID]\n"
                    + "		WHERE 1=1 ";
            if (from != null) {
                sql += "AND [ReceiptDate] >= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = from + "";
                params.put(countParam, param);
            }
            if (to != null) {
                sql += "AND [ReceiptDate] <= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = to + "";
                params.put(countParam, param);
            }
            if (cateID != 0) {
                sql += "AND p.[CategoryID] = ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Integer.class.getName();
                param[1] = cateID + "";
                params.put(countParam, param);
            }
            if (supID != 0) {
                sql += "AND p.[SupplierID] = ? ";
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
            if (rs.next()) {
                return rs.getDouble("TotalReceiptAmount");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public double getTotalAllDeliveredAmount(int cateID, int supID, Date from, Date to) {
        try {
            HashMap<Integer, String[]> params = new HashMap<>();
            int countParam = 0;
            //sub query get total receipt amount
            String sql = "SELECT SUM(dd.Quantity * p.unitPrice) as TotalDeliveryAmount \n"
                    + "		FROM [DeliveryDetail] dd JOIN [Delivery] d ON dd.DeliveryID = d.DeliveryID"
                    + "                                 JOIN [Products] p ON dd.[ProductID] = p.[ProductID]\n"
                    + "		WHERE 1=1 ";
            if (from != null) {
                sql += "AND [ReceiptDate] >= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = from + "";
                params.put(countParam, param);
            }
            if (to != null) {
                sql += "AND [ReceiptDate] <= ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Date.class.getName();
                param[1] = to + "";
                params.put(countParam, param);
            }
            if (cateID != 0) {
                sql += "AND p.[CategoryID] = ? ";
                countParam++;
                String[] param = new String[2];
                param[0] = Integer.class.getName();
                param[1] = cateID + "";
                params.put(countParam, param);
            }
            if (supID != 0) {
                sql += "AND p.[SupplierID] = ? ";
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
            if (rs.next()) {
                return rs.getDouble("TotalDeliveryAmount");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<ProductExpirationReport> getExpirationReports(int pageIndex, int pageSize) {
        ArrayList<ProductExpirationReport> products = new ArrayList<>();
        try {
            String sql = "SELECT [ProductID]\n"
                    + "         ,[ProductName]\n"
                    + "         ,[unit]\n"
                    + "         ,[unitPrice]\n"
                    + "         ,[inStock]\n"
                    + "         ,[ExpDate]\n"
                    + "         ,[ReceiptDate]\n"
                    + "         ,[Datediff]\n"
                    + "  FROM (SELECT ROW_NUMBER() OVER(ORDER BY p.[ProductID]) as rownum\n"
                    + "			  ,p.[ProductID]\n"
                    + "			  ,[ProductName]\n"
                    + "                   ,[unit]\n"
                    + "			  ,rd.[unitPrice]\n"
                    + "			  ,[inStock]\n"
                    + "			  ,[ExpDate]\n"
                    + "			  ,[ReceiptDate]\n"
                    + "			  ,(SELECT DATEDIFF(DAY,GETDATE(),[ExpDate])) as [Datediff]\n"
                    + "		FROM [ReceiptDetail] rd INNER JOIN [Products] p\n"
                    + "			ON rd.ProductID = p.ProductID\n"
                    + "					INNER JOIN [Receipt] r\n"
                    + "			ON rd.ReceiptID = r.ReceiptID\n"
                    + "		WHERE DATEDIFF(DAY,GETDATE(),[ExpDate]) <= 10\n"
                    + "                 AND [inStock] > 0) as pex\n"
                    + "  WHERE rownum >= (?-1)*?+1 AND rownum <= ?*?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pageIndex);
            stm.setInt(2, pageSize);
            stm.setInt(3, pageIndex);
            stm.setInt(4, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ProductExpirationReport pro = new ProductExpirationReport();
                pro.setId(rs.getString(1));
                pro.setName(rs.getString(2));
                pro.setUnit(rs.getString(3));
                pro.setUnitPrice(rs.getDouble(4));
                pro.setInStock(rs.getDouble(5));
                pro.setExpDate(rs.getDate(6));
                pro.setReceiptDate(rs.getDate(7));
                pro.setDateDiff(rs.getInt(8));
                products.add(pro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public ArrayList<Product> getOutStockProducts(int pageIndex, int pageSize) {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT ProductID\n"
                    + "		, ProductName\n"
                    + "		, CategoryID\n"
                    + "		, SupplierID\n"
                    + "		, unit\n"
                    + "		, Quantity\n"
                    + "		, unitPrice\n"
                    + "		, isActive\n"
                    + "		, Comment\n"
                    + "   FROM (SELECT ROW_NUMBER() OVER(ORDER BY [ProductID]) as rownum\n"
                    + "			, ProductID\n"
                    + "			, ProductName\n"
                    + "			, CategoryID\n"
                    + "			, SupplierID\n"
                    + "			, unit\n"
                    + "			, Quantity\n"
                    + "			, unitPrice\n"
                    + "			, isActive\n"
                    + "			, Comment\n"
                    + "		FROM Products\n"
                    + "		WHERE Quantity < 10) as p\n"
                    + "  WHERE rownum >= (?-1)*?+1 AND rownum <= ?*?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pageIndex);
            stm.setInt(2, pageSize);
            stm.setInt(3, pageIndex);
            stm.setInt(4, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                CategoryDBContext cdb = new CategoryDBContext();
                Category cat = cdb.getCategory(rs.getInt(3));

                SupplierDBContext sdb = new SupplierDBContext();
                Supplier sup = sdb.getSupplier(rs.getInt(4));

                Product pro = new Product(rs.getString(1), rs.getString(2), cat, sup,
                        rs.getString(5), rs.getDouble(6), rs.getDouble(7), rs.getString(9), rs.getBoolean(8));
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

    public int countExpirationProducts() {
        try {
            String sql = "SELECT COUNT (*) as total\n"
                    + "	  FROM [ReceiptDetail] rd\n"
                    + "	  WHERE DATEDIFF(DAY,GETDATE(),[ExpDate]) <= 10 \n"
                    + "		AND [inStock] > 0";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int countProductsOutStock() {
        try {
            String sql = "SELECT COUNT(*) as total \n"
                    + "  FROM [Products] "
                    + "  WHERE Quantity < 10 ";
            PreparedStatement stm = connection.prepareStatement(sql);

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
