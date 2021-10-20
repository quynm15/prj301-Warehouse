/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Feature;

/**
 *
 * @author quynm
 */
public class AccountDBContext extends DBContext {

    public Account getAccount(String username, String password) {
        try {
            String sql = "SELECT a.[Username],[Password],[FullName],[Dob],[Address],"
                    + "          [Phone],[Email],[isActive],f.[featureID],[url],[featureName] \n"
                    + "  FROM [Accounts] a LEFT JOIN [Account_Feature] af ON a.Username = af.Username\n"
                    + "			LEFT JOIN [Feature] f ON af.FeatureID = f.featureID\n"
                    + "  WHERE a.[Username] = ? AND [Password] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, username);
            stm.setString(2, password);

            ResultSet rs = stm.executeQuery();
            Account account = null;
            while (rs.next()) {
                if (account == null) {
                    account = new Account(username, password, rs.getString("FullName"),
                            rs.getDate("Dob"), rs.getString("Address"), rs.getString("Phone"),
                            rs.getString("Email"), rs.getBoolean("isActive"));
                }
                if (rs.getInt("featureID") != 0) { //0 represent null
                    account.getFeatures().add(new Feature(rs.getInt("featureID"), rs.getString("url"), rs.getString("featureName")));
                }
            }
            return account;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Account getAccount(String username) {
        try {
            String sql = "SELECT a.[Username],[Password],[FullName],[Dob],[Address],"
                    + "          [Phone],[Email],[isActive],f.[featureID],[url],[featureName] \n"
                    + "  FROM [Accounts] a LEFT JOIN [Account_Feature] af ON a.Username = af.Username\n"
                    + "			LEFT JOIN [Feature] f ON af.FeatureID = f.featureID\n"
                    + "  WHERE a.[Username] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, username);

            ResultSet rs = stm.executeQuery();
            Account account = null;
            while (rs.next()) {
                if (account == null) {
                    account = new Account(username, rs.getString("Password"), rs.getString("FullName"),
                            rs.getDate("Dob"), rs.getString("Address"), rs.getString("Phone"),
                            rs.getString("Email"), rs.getBoolean("isActive"));
                }
                if (rs.getInt("featureID") != 0) { //0 represent null
                    account.getFeatures().add(new Feature(rs.getInt("featureID"), rs.getString("url"), rs.getString("featureName")));
                }
            }
            return account;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Account> getAccounts() {
        ArrayList<Account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT a.[Username],[Password],[FullName],[Dob],[Address],"
                    + "          [Phone],[Email],[isActive],f.[featureID],[url],[featureName] \n"
                    + "  FROM [Accounts] a LEFT JOIN [Account_Feature] af ON a.Username = af.Username\n"
                    + "			LEFT JOIN [Feature] f ON af.FeatureID = f.featureID "
                    + "  ORDER BY a.[Username] ";
            PreparedStatement stm = connection.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();
            Account account = new Account();
            account.setUsername(null);
            while (rs.next()) {
                if (!rs.getString("Username").equals(account.getUsername())) {
                    account = new Account(rs.getString("Username"), rs.getString("Password"), rs.getString("FullName"),
                            rs.getDate("Dob"), rs.getString("Address"), rs.getString("Phone"),
                            rs.getString("Email"), rs.getBoolean("isActive"));
                    accounts.add(account);
                }
                if (rs.getInt("featureID") != 0) { //0 represent null
                    account.getFeatures().add(new Feature(rs.getInt("featureID"), rs.getString("url"), rs.getString("featureName")));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }

    public void insertAccount(Account account) {
        try {
            connection.setAutoCommit(false);
            String sql = "INSERT INTO [Accounts]\n"
                    + "           ([Username], [Password], [FullName], [Dob] "
                    + "           ,[Address], [Phone], [Email], [isActive]) "
                    + "     VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, account.getUsername());
            stm.setString(2, "123456");
            stm.setString(3, account.getFullName());
            stm.setDate(4, account.getDob());
            stm.setString(5, account.getAddress());
            stm.setString(6, account.getPhone());
            stm.setString(7, account.getEmail());
            stm.setBoolean(8, account.isIsActive());
            stm.executeUpdate();

            //insert to AccountFeature
            for (Feature feature : account.getFeatures()) {
                String sql_insert_feature = "INSERT INTO [Account_Feature] ([Username],[FeatureID])\n"
                        + "     VALUES (?,?) ";
                PreparedStatement stm_insert = connection.prepareStatement(sql_insert_feature);
                stm_insert.setString(1, account.getUsername());
                stm_insert.setInt(2, feature.getId());
                stm_insert.executeUpdate();
            }

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void updateAccount(Account account) {
        try {
            connection.setAutoCommit(false);
            String sql = "UPDATE [Accounts]\n"
                    + "   SET [FullName] = ?\n"
                    + "      ,[Dob] = ?\n"
                    + "      ,[Address] = ?\n"
                    + "      ,[Phone] = ?\n"
                    + "      ,[Email] = ?\n"
                    + "      ,[isActive] = ?\n"
                    + " WHERE [Username] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, account.getFullName());
            stm.setDate(2, account.getDob());
            stm.setString(3, account.getAddress());
            stm.setString(4, account.getPhone());
            stm.setString(5, account.getEmail());
            stm.setBoolean(6, account.isIsActive());
            stm.setString(7, account.getUsername());
            stm.executeUpdate();

            //delete AccountFeature
            String sql_delete_feature = "DELETE FROM [Account_Feature] "
                    + "  WHERE [Username] = ? ";
            PreparedStatement stm_delete = connection.prepareStatement(sql_delete_feature);
            stm_delete.setString(1, account.getUsername());
            stm_delete.executeUpdate();

            //insert to AccountFeature
            for (Feature feature : account.getFeatures()) {
                String sql_insert_feature = "INSERT INTO [Account_Feature] ([Username],[FeatureID])\n"
                        + "     VALUES (?,?) ";
                PreparedStatement stm_insert = connection.prepareStatement(sql_insert_feature);
                stm_insert.setString(1, account.getUsername());
                stm_insert.setInt(2, feature.getId());
                stm_insert.executeUpdate();
            }

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void updatePassword(String username, String password) {
        try {
            String sql = "UPDATE [Accounts]\n"
                    + "   SET [Password] = ?\n"
                    + " WHERE [Username] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, password);
            stm.setString(2, username);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteAccount(String username) {
        try {
            //delete AccountFeature
            String sql_delete_AF = "DELETE FROM [Account_Feature] "
                    + "  WHERE [Username] = ? ";
            PreparedStatement stm_delete_af = connection.prepareStatement(sql_delete_AF);
            stm_delete_af.setString(1, username);
            stm_delete_af.executeUpdate();

            //delete Account
            String sql_delete_account = "DELETE FROM [Accounts] "
                    + "  WHERE [Username] = ? ";
            PreparedStatement stm_delete_a = connection.prepareStatement(sql_delete_account);
            stm_delete_a.setString(1, username);
            stm_delete_a.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
