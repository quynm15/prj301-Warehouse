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
                    + "          [Phone],[Email],[isActive],f.[featureID],[url] \n"
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
                    account.getFeatures().add(new Feature(rs.getInt("featureID"), rs.getString("url")));
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
                    + "          [Phone],[Email],[isActive],f.[featureID],[url] \n"
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
                    account.getFeatures().add(new Feature(rs.getInt("featureID"), rs.getString("url")));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }
}
