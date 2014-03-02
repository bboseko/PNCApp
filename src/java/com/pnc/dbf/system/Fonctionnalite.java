/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pnc.dbf.system;

/**
 *
 * @author IMA7
 */
import java.io.Serializable;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

@ManagedBean
@SessionScoped
public class Fonctionnalite implements Serializable{
    private Integer id_fonctionnalite;
    private String nom_fonctionnalite;
    private String shortname_fonctionnalite;
    private String commande_fonctionnalite;
    private String page_fonctionnalite;
    private String icone_fonctionnalite;
    private String chemin_fonctionnalite;

    public Fonctionnalite(Integer id_fonctionnalite, String nom_fonctionnalite, String shortname_fonctionnalite, String commande_fonctionnalite, String page_fonctionnalite, String icone_fonctionnalite, String chemin_fonctionnalite) {
        this.id_fonctionnalite = id_fonctionnalite;
        this.nom_fonctionnalite = nom_fonctionnalite;
        this.shortname_fonctionnalite = shortname_fonctionnalite;
        this.commande_fonctionnalite = commande_fonctionnalite;
        this.page_fonctionnalite = page_fonctionnalite;
        this.icone_fonctionnalite = icone_fonctionnalite;
        this.chemin_fonctionnalite = chemin_fonctionnalite;
    }

    public Fonctionnalite() {
    }

    public Integer getId_fonctionnalite() {
        return id_fonctionnalite;
    }

    public void setId_fonctionnalite(Integer id_fonctionnalite) {
        this.id_fonctionnalite = id_fonctionnalite;
    }

    public String getNom_fonctionnalite() {
        return nom_fonctionnalite;
    }

    public void setNom_fonctionnalite(String nom_fonctionnalite) {
        this.nom_fonctionnalite = nom_fonctionnalite;
    }

    public String getShortname_fonctionnalite() {
        return shortname_fonctionnalite;
    }

    public void setShortname_fonctionnalite(String shortname_fonctionnalite) {
        this.shortname_fonctionnalite = shortname_fonctionnalite;
    }

    public String getCommande_fonctionnalite() {
        return commande_fonctionnalite;
    }

    public void setCommande_fonctionnalite(String commande_fonctionnalite) {
        this.commande_fonctionnalite = commande_fonctionnalite;
    }

    public String getPage_fonctionnalite() {
        return page_fonctionnalite;
    }

    public void setPage_fonctionnalite(String page_fonctionnalite) {
        this.page_fonctionnalite = page_fonctionnalite;
    }

    public String getIcone_fonctionnalite() {
        return icone_fonctionnalite;
    }

    public void setIcone_fonctionnalite(String icone_fonctionnalite) {
        this.icone_fonctionnalite = icone_fonctionnalite;
    } 

    public String getChemin_fonctionnalite() {
        return chemin_fonctionnalite;
    }

    public void setChemin_fonctionnalite(String chemin_fonctionnalite) {
        this.chemin_fonctionnalite = chemin_fonctionnalite;
    }
}
