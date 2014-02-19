package com.pnc.dbf.user;

import com.pnc.dbf.config.DBConnection;
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.ResourceBundle;
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

    ResourceBundle message = ResourceBundle.getBundle("language.message");
    private String userName;
    private String password;
    private String firstname, familyname;
    private String profile;
    private int idUser, idProfile, attempt = 0;

    public SignInBean() {
    }

    public String logInUser() {
        FacesContext context = FacesContext.getCurrentInstance();
        String query = "select * from t_user where username = ? and password = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(getUserName());
        parameter.add(Crypto.encryption(getPassword()));
        try {
            if (!isValideUserName()) {
                context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                        message.getString("SignInBean.usernameIncorrectTitle"),
                        message.getString("SignInBean.usernameIncorrectMessage")));
            } else {
                idUser = getIdUserFromDB();
                if (getStatus() == 0) {
                    context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL,
                            message.getString("SignInBean.accountLockedTitle"),
                            message.getString("SignInBean.accountLockedMessage")));
                } else {
                    ResultSet res = DBConnection.getResult(query, parameter);
                    if (res.next()) {
                        idProfile = res.getInt("id_profile");
                        profile = getProfileDB();
                        attempt = 0;
                        updateLastVisiteDate();
                        firstname = res.getString(4);
                        familyname = res.getString(5);
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,
                                message.getString("SignInBean.welcomeMessage"),
                                message.getString("SignInBean.helloMessage") + " " + firstname + " " + familyname));
                        if (isNewUser()) {
                            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                                    message.getString("SignInBean.changePasswordTitle"),
                                    message.getString("SignInBean.changePasswordMessage")));
                        }
                        return "views/home";
                    } else {
                        attempt++;
                        if ((3 - attempt) <= 0) {
                            setStatus(0);
                            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_FATAL,
                                    message.getString("SignInBean.accountLockedTitle"),
                                    message.getString("SignInBean.accountLockedMessage")));
                        } else {
                            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                                    message.getString("SignInBean.passwordIncorrectTitle"),
                                    message.getString("SignInBean.passwordIncorrectMessage1") + " " + (3 - attempt) + " "
                                    + message.getString("SignInBean.passwordIncorrectMessage2")));
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
        String query = "update t_user set last_visit_date = ? where id_user = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", new DateFormatSymbols()).format(new Date()));
        parameter.add(idUser);
        return DBConnection.setUpdateDB(query, parameter);
    }

    private boolean isValideUserName() throws SQLException {
        String query = "select * from t_user where username = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(userName);
        ResultSet res = DBConnection.getResult(query, parameter);
        return res.next();
    }

    private boolean isNewUser() throws SQLException {
        String query = "select * from t_user where id_user = ? and new_user = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(idUser);
        parameter.add(1);
        ResultSet res = DBConnection.getResult(query, parameter);
        return res.next();
    }

    private int getIdUserFromDB() throws SQLException {
        String query = "select id_user from t_user where username = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(getUserName());
        ResultSet res = DBConnection.getResult(query, parameter);
        while (res.next()) {
            return Integer.parseInt(res.getString(1));
        }
        return 0;
    }

    private int getStatus() throws SQLException {
        String query = "select status from t_user where id_user = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(idUser);
        ResultSet res = DBConnection.getResult(query, parameter);
        while (res.next()) {
            return Integer.parseInt(res.getString(1));
        }
        return 1;
    }

    private int setStatus(int status) throws SQLException {
        String query = "update t_user set status = ? where id_user = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(status);
        parameter.add(idUser);
        return DBConnection.setUpdateDB(query, parameter);
    }

    private String getProfileDB() throws SQLException {
        String query = "select profile_name from t_profile where id_profile = ?";
        ArrayList parameter = new ArrayList();
        parameter.add(idProfile);
        ResultSet res = DBConnection.getResult(query, parameter);
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
