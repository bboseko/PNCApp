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

/**
 *
 * @author IMA7
 */
public class Authentification implements Serializable{

    public Authentification() {
    }

    
    public Integer getUserProfile(User user) throws Exception{
        System.out.println("le user recu est :"+ user.getUserName()+" "+user.getPassword());
        String requette = "SELECT * FROM utilisateur WHERE utilisateur.identifiant=? AND utilisateur.mot_de_passe=?";
        ArrayList parameter = new ArrayList();
        parameter.add(user.getUserName());
        parameter.add(Crypto.encryption(user.getPassword()));
        ResultSet res = DBConnection.getResultDB(requette, parameter);
        if(res.next()){
            System.out.println("profile obtenu est "+ res.getInt("id_profil"));
            return res.getInt("id_profil");            
        }else{
            return null;
        }
    }
    
    public ArrayList<Fonctionnalite> getUserModules(Integer idProfile) throws Exception{
        ArrayList<Fonctionnalite> modules = new ArrayList<Fonctionnalite>();
        String requette = "SELECT fonctionnalite.`nom_fonctionnalite`, fonctionnalite.`id_fonctionnalite`, fonctionnalite.`shortname_fonctionnalite`, "
                + "fonctionnalite.`commande_fonctionnalite`, fonctionnalite.`page_fonctionnalite`, fonctionnalite.`icone_fonctionnalite` FROM fonctionnalite, acceder, profil "
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
            modules.add(fonct);           
        }
        return modules;        
    }
    
    public String enter(User user){
        return new Autorisation().decision("views/home", user);
        
    }
}
