package com.pnc.dbf.config;

import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

public class DBConnection implements Serializable {
    /*Parametres fichier Config */

    private static final String FICHIER_PROPERTIES = "/com/pnc/dbf/config/Config.properties";
    private static final String PROPERTY_URL = "url";
    private static final String PROPERTY_DRIVER = "driver";
    private static final String PROPERTY_NOM_UTILISATEUR = "username";
    private static final String PROPERTY_MOT_DE_PASSE = "password";
    /*-Fin-*/

    Connection con;

    public DBConnection() {
        Properties properties = new Properties();
        InputStream fichierProperties = this.getClass().getResourceAsStream(FICHIER_PROPERTIES);
        if (fichierProperties == null) {
            throw new DAOConfigurationException("Le fichier de configuration " + FICHIER_PROPERTIES + " est introuvable!");
        }
        try {
            properties.load(fichierProperties);
        } catch (IOException ex) {
            throw new DAOConfigurationException("Impossible de charger le fichier de congiguration " + FICHIER_PROPERTIES, ex);
        }
        try {
            Class.forName(properties.getProperty(PROPERTY_DRIVER));
        } catch (ClassNotFoundException ex) {
            throw new DAOConfigurationException("Le driver est introuvable dans le classpath.", ex);
        }
        try {
            con = DriverManager.getConnection(properties.getProperty(PROPERTY_URL),
                    properties.getProperty(PROPERTY_NOM_UTILISATEUR),
                    properties.getProperty(PROPERTY_MOT_DE_PASSE));
        } catch (SQLException ex) {
            throw new DAOConfigurationException("Impossible d'etablir la connexion !", ex);
        }
    }

    public Connection getConnection() {
        if (con == null) {
            DBConnection dbConnection = new DBConnection();
        }
        return con;
    }

    public ResultSet getResult(String query) throws SQLException {
        PreparedStatement ps = con.prepareStatement(query);
        return ps.executeQuery();
    }

    public ResultSet getResult(String query, ArrayList parameter) throws SQLException {
        PreparedStatement ps = con.prepareStatement(query);
        for (int i = 0; i < parameter.size(); i++) {
            ps.setString(i + 1, parameter.get(i).toString());
        }
        return ps.executeQuery();
    }

    public int setUpdateDB(String query, ArrayList parameter) throws SQLException {
        PreparedStatement ps = con.prepareStatement(query);
        for (int i = 0; i < parameter.size(); i++) {
            ps.setString(i + 1, parameter.get(i).toString());
        }
        return ps.executeUpdate();
    }
}
