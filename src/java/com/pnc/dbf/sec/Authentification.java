/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pnc.dbf.sec;

import com.pnc.dbf.config.DBConnection;
import com.pnc.dbf.system.Fonctionnalite;
import com.pnc.dbf.user.Crypto;
import com.pnc.dbf.user.User;
import java.io.Serializable;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author IMA7
 */
public class Authentification implements Serializable {

    public Authentification() {
    }

    public ResultSet getUserPersistent(User user) throws Exception {
        String requette = "SELECT * FROM utilisateur WHERE utilisateur.identifiant=? AND utilisateur.mot_de_passe=?";
        ArrayList parameter = new ArrayList();
        parameter.add(user.getUserName());
        parameter.add(Crypto.encryption(user.getPassword()));
        ResultSet res = DBConnection.getResultDB(requette, parameter);
        return res;
    }

    public ArrayList<Fonctionnalite> getUserModules(Integer idProfile) throws Exception {
        ArrayList<Fonctionnalite> modules = new ArrayList<Fonctionnalite>();        
        String requette = "SELECT fonctionnalite.`nom_fonctionnalite`, fonctionnalite.`id_fonctionnalite`, fonctionnalite.`shortname_fonctionnalite`, "
                + "fonctionnalite.`commande_fonctionnalite`, fonctionnalite.`page_fonctionnalite`, fonctionnalite.`icone_fonctionnalite`, fonctionnalite.`chemin_fonctionnalite` FROM fonctionnalite, acceder, profil "
                + "WHERE fonctionnalite.`id_fonctionnalite` = acceder.`id_fonctionnalite` AND acceder.`id_profil` = profil.`id_profil` "
                + "AND profil.`id_profil`= ?";
        ArrayList parameter = new ArrayList();
        parameter.add(idProfile);
        ResultSet res = DBConnection.getResultDB(requette, parameter);
        while (res.next()) {
            Fonctionnalite fonct = new Fonctionnalite();
            fonct.setId_fonctionnalite(res.getInt("id_fonctionnalite"));
            fonct.setNom_fonctionnalite(res.getString("nom_fonctionnalite"));
            fonct.setShortname_fonctionnalite(res.getString("shortname_fonctionnalite"));
            fonct.setPage_fonctionnalite(res.getString("page_fonctionnalite"));
            fonct.setIcone_fonctionnalite(res.getString("icone_fonctionnalite"));
            fonct.setChemin_fonctionnalite(res.getString("chemin_fonctionnalite"));
            modules.add(fonct);
        }
        return modules;
    }

    public String enter(User user) throws Exception {
        ArrayList<String> userPaths = getUserPaths(user);
        FacesContext fc = FacesContext.getCurrentInstance();
        HttpServletRequest request = (HttpServletRequest) fc.getExternalContext().getRequest();
        HttpSession session = request.getSession();
        if (!session.isNew()) {
            session.invalidate();
            session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userPaths", userPaths);
        }
        return new Autorisation().decision("views/home", user);

    }

    private ArrayList<String> getUserPaths(User user) throws Exception {
        ArrayList<String> paths = new ArrayList<String>();        
        String requette = "SELECT fonctionnalite.`chemin_fonctionnalite` FROM fonctionnalite, acceder, profil "
                + "WHERE fonctionnalite.`id_fonctionnalite` = acceder.`id_fonctionnalite` AND acceder.`id_profil` = profil.`id_profil` "
                + "AND profil.`id_profil`= ?";
        ArrayList parameter = new ArrayList();
        parameter.add(user.getIdProfile());
        ResultSet res = DBConnection.getResultDB(requette, parameter);
        while (res.next()) {
            paths.add(res.getString("chemin_fonctionnalite"));
        }
        return paths;
    }
}
