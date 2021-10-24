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

/**
 *
 * @author quynm
 */
public class CategoryDBContext extends DBContext {

    public ArrayList<Category> getCategories() {
        ArrayList<Category> categories = new ArrayList<>();
        try {
            String sql = "SELECT [CategoryID],[CategoryName],[Description],[isActive]\n"
                    + "             ,(SELECT COUNT (*) FROM [Products] WHERE [CategoryID] = c.[CategoryID]) as totalProduct "
                    + "  FROM [Categories] as c ";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category cat = new Category(rs.getInt("CategoryID"), rs.getString("CategoryName"),
                        rs.getString("Description"), rs.getBoolean("isActive"));
                cat.setUsed(rs.getInt("totalProduct")>0);
                categories.add(cat);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categories;
    }

    public Category getCategory(int id) {
        try {
            String sql = "SELECT [CategoryID],[CategoryName],[Description],[isActive]\n"
                    + "             ,(SELECT COUNT (*) FROM [Products] WHERE [CategoryID] = ?) as totalProduct "
                    + "  FROM [Categories] "
                    + "  WHERE CategoryID = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setInt(2, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Category cat = new Category(rs.getInt("CategoryID"), rs.getString("CategoryName"),
                        rs.getString("Description"), rs.getBoolean("isActive"));
                cat.setUsed(rs.getInt("totalProduct")>0);
                return cat;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateCategory(Category cat) {
        try {
            String sql = "UPDATE [Categories]\n"
                    + "   SET [CategoryName] = ?\n"
                    + "      ,[Description] = ?\n"
                    + "      ,[isActive] = ?\n"
                    + " WHERE [CategoryID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, cat.getName());
            stm.setString(2, cat.getDescription());
            stm.setBoolean(3, cat.isActive());
            stm.setInt(4, cat.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertCategory(Category cat) {
        try {
            String sql = "INSERT INTO [Categories] ([CategoryName],[Description],[isActive])\n"
                    + "     VALUES(?,?,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, cat.getName());
            stm.setString(2, cat.getDescription());
            stm.setBoolean(3, cat.isActive());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteCategory(int id) {
        try {
            String sql = "DELETE FROM [Categories]\n"
                    + "      WHERE [CategoryID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public boolean isUsedCategory(int id){
        try {
            String sql = "SELECT * FROM [Products]\n"
                    + "      WHERE [CategoryID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void inactiveCategory(int id) {
        try {
            String sql = "UPDATE [Categories]\n"
                    + "   SET [isActive] = 0\n"
                    + " WHERE [CategoryID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
