/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.account;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.account.Account;
import model.account.Feature;

/**
 *
 * @author quynm
 */
public class FeatureDBContext extends DBContext {

    public ArrayList<Feature> getFeatures() {
        ArrayList<Feature> features = new ArrayList<>();
        try {
            String sql = "SELECT [featureID],[url],[featureName]\n"
                    + "  FROM [Feature]";
            PreparedStatement stm = connection.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feature feature = new Feature(rs.getInt("FeatureID"), rs.getString("url"), rs.getString("FeatureName"));
                features.add(feature);
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return features;
    }

    public Feature getFeature(int featureID) {
        try {
            String sql = "SELECT [url],[featureName] "
                    + "  FROM [Feature] "
                    + "  WHERE [featureID] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setInt(1, featureID);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Feature feature = new Feature(featureID, rs.getString("url"), rs.getString("featureName"));
                return feature;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
