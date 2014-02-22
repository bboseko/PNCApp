/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pnc.dbf.system;

import java.util.Date;

/**
 *
 * @author IMA7
 */
public class Historique {
    private Integer id;
    private String ip;
    private String nomMachine;
    private String mac;
    private String fonctionnalite;
    private String operation;
    private Date date;
    private Integer idUser;

    public Historique(String ip, String nomMachine, String mac, String fonctionnalite, String operation, Date date, Integer idUser) {
        this.ip = ip;
        this.nomMachine = nomMachine;
        this.mac = mac;
        this.fonctionnalite = fonctionnalite;
        this.operation = operation;
        this.date = date;
        this.idUser = idUser;
    }

    public Historique() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getNomMachine() {
        return nomMachine;
    }

    public void setNomMachine(String nomMachine) {
        this.nomMachine = nomMachine;
    }

    public String getMac() {
        return mac;
    }

    public void setMac(String mac) {
        this.mac = mac;
    }

    public String getFonctionnalite() {
        return fonctionnalite;
    }

    public void setFonctionnalite(String fonctionnalite) {
        this.fonctionnalite = fonctionnalite;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getIdUser() {
        return idUser;
    }

    public void setIdUser(Integer idUser) {
        this.idUser = idUser;
    }
    
    public void save(){
        //ecrire le sql pour inserer l'historique
    }
    
}
