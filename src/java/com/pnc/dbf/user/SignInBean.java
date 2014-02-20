package com.pnc.dbf.user;

import com.pnc.dbf.config.Config;
import com.pnc.dbf.config.DBConnection;
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@ManagedBean
@SessionScoped

public class SignInBean implements Serializable {

    private String userName;
    private String password;
    private String firstname, familyname;
    private String profile;
    private int idUser, idProfile, attempt = 0;

    public SignInBean() {
    }

    public String logInUser() {
        FacesContext context = FacesContext.getCurrentInstance();
        String query = "select * from utilisateur where identifiant = ? and mot_de_passe = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(getUserName());
        parameter.add(Crypto.encryption(getPassword()));
        try {
            if (!isValideUserName()) {
                context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                        Config.message.getString("SignInBean.usernameIncorrectTitle"),
                        Config.message.getString("SignInBean.usernameIncorrectMessage")));
            } else {
                idUser = getIdUserFromDB();
                if (getStatus() == 0) {
                    context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL,
                            Config.message.getString("SignInBean.accountLockedTitle"),
                            Config.message.getString("SignInBean.accountLockedMessage")));
                } else {
                    ResultSet res = DBConnection.getResultDB(query, parameter);
                    if (res.next()) {
                        idProfile = res.getInt("id_profil");
                        profile = getProfileDB();
                        attempt = 0;
                        updateLastVisiteDate();
                        firstname = res.getString(3);
                        familyname = res.getString(4);
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                                Config.message.getString("SignInBean.welcomeMessage"),
                                Config.message.getString("SignInBean.helloMessage") + " " + firstname + " " + familyname));
                        if (isNewUser()) {
                            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                                    Config.message.getString("SignInBean.changePasswordTitle"),
                                    Config.message.getString("SignInBean.changePasswordMessage")));
                        }
                        return "views/home";
                    } else {
                        attempt++;
                        if ((3 - attempt) <= 0) {
                            setStatus(0);
                            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL,
                                    Config.message.getString("SignInBean.accountLockedTitle"),
                                    Config.message.getString("SignInBean.accountLockedMessage")));
                        } else {
                            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                                    Config.message.getString("SignInBean.passwordIncorrectTitle"),
                                    Config.message.getString("SignInBean.passwordIncorrectMessage1") + " " + (3 - attempt) + " "
                                    + Config.message.getString("SignInBean.passwordIncorrectMessage2")));
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SignInBean.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    private int updateLastVisiteDate() throws SQLException {
        String query = "update utilisateur set date_derniere_visite = ? where id_utilisateur = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", new DateFormatSymbols()).format(new Date()));
        parameter.add(idUser);
        return DBConnection.setUpdateDB(query, parameter);
    }

    private boolean isValideUserName() throws SQLException {
        String query = "select * from utilisateur where identifiant = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(userName);
        ResultSet res = DBConnection.getResultDB(query, parameter);
        return res.next();
    }

    private boolean isNewUser() throws SQLException {
        String query = "select * from utilisateur where id_utilisateur = ? and nouveau = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(idUser);
        parameter.add(1);
        ResultSet res = DBConnection.getResultDB(query, parameter);
        return res.next();
    }

    private int getIdUserFromDB() throws SQLException {
        String query = "select id_utilisateur from utilisateur where identifiant = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(getUserName());
        ResultSet res = DBConnection.getResultDB(query, parameter);
        while (res.next()) {
            return Integer.parseInt(res.getString(1));
        }
        return 0;
    }

    private int getStatus() throws SQLException {
        String query = "select statut from utilisateur where id_utilisateur = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(idUser);
        ResultSet res = DBConnection.getResultDB(query, parameter);
        while (res.next()) {
            return Integer.parseInt(res.getString(1));
        }
        return 1;
    }

    private int setStatus(int status) throws SQLException {
        String query = "update utilisateur set statut = ? where id_utilisateur = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(status);
        parameter.add(idUser);
        return DBConnection.setUpdateDB(query, parameter);
    }

    private String getProfileDB() throws SQLException {
        String query = "select nom_profil from profil where id_profil = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(idProfile);
        ResultSet res = DBConnection.getResultDB(query, parameter);
        while (res.next()) {
            return res.getString(1);
        }
        return null;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public int getIdProfile() {
        return idProfile;
    }

    public void setIdProfile(int idProfile) {
        this.idProfile = idProfile;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getFamilyname() {
        return familyname;
    }

    public void setFamilyname(String familyname) {
        this.familyname = familyname;
    }

    public void keepSessionAlive() {
        FacesContext fc = FacesContext.getCurrentInstance();
        HttpServletRequest request = (HttpServletRequest) fc.getExternalContext().getRequest();
        request.getSession();
    }

    public void logOut() {
        FacesContext fc = FacesContext.getCurrentInstance();
        HttpSession session = (HttpSession) fc.getExternalContext().getSession(false);
        session.invalidate();
    }
}
