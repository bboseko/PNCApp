/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pnc.dbf.system;

import com.pnc.dbf.config.DBConnection;
import com.pnc.dbf.user.User;
import java.io.Serializable;
import java.sql.PreparedStatement;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author IMA7
 */
@ManagedBean
@SessionScoped
public class Historique implements Serializable {

    private Integer id;
    private String ip;
    private String nomMachine;
    private String mac;
    private String fonctionnalite;
    private String operation;
    private Date date;
    private Integer idUser;
    private FacesContext context = FacesContext.getCurrentInstance();

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
        HttpServletRequest httpServReq = (HttpServletRequest) context.getExternalContext().getRequest();
        HttpSession session = httpServReq.getSession();
        this.setIp(httpServReq.getRemoteAddr());
        this.setMac("");
        this.setNomMachine(httpServReq.getRemoteHost());
        this.setFonctionnalite(context.getExternalContext().getRequestPathInfo());
        this.setOperation(context.getExternalContext().getRealPath(this.getFonctionnalite()));
        User user = (User)session.getAttribute("user");
        this.setIdUser(user.getId());       
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

    public void save() throws Exception {
        //ecrire le sql pour inserer l'historique
        String query = "INSERT INTO historique ("
                + "id_historique, ip_historique, nomMachine_historique,"
                + " mac_historique, fonctionnalite_historique,"
                + " operation_historique, date_historique,"
                + " idUtilisateur_historique) VALUES (null,?,?,?,?,?,?,?)";
        PreparedStatement ps = DBConnection.getConnection().prepareStatement(query);
            System.out.println("on execute"+this.getIdUser());
            ps.setString(1, this.getIp());
            ps.setString(2, this.getNomMachine());
            ps.setString(3, this.getMac());
            ps.setString(4, this.getFonctionnalite());
            ps.setString(5, this.getOperation());
            ps.setString(6, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", new DateFormatSymbols()).format(new Date()));
            ps.setInt(7, this.getIdUser());
            ps.executeUpdate();
    }
}
