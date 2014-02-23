package com.pnc.dbf.user;

import com.pnc.dbf.sec.Authentification;
import java.io.Serializable;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

@ManagedBean
@SessionScoped
public class User implements Serializable {

    private Integer id;
    private String firstName;
    private String familyName;
    private String otherName;
    private String matricule;
    private String phone;
    private String email;
    private String grade;
    private String userName;
    private String password;
    private Integer idProfile;
    private String[] paths;
    private HashMap modules;

    public User() {
    }

    public User(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

    public User(String userName, String password, int profile) {
        this.userName = userName;
        this.password = password;
        this.idProfile = profile;
    }

    public User(String firstName, String familyName, String otherName, String userName, String password) {
        this.firstName = firstName;
        this.familyName = familyName;
        this.otherName = otherName;
        this.userName = userName;
        this.password = password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getOtherName() {
        return otherName;
    }

    public void setOtherName(String otherName) {
        this.otherName = otherName;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
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

    public Integer getIdProfile() {
        return idProfile;
    } 

    

//    private Integer getProfile() throws Exception {
//        return new Authentification().getUserProfile(this);
//    }

    public void setIdProfile(Integer idProfile) {
        this.idProfile = idProfile;
    }

    public String login() throws Exception {
        ResultSet res = new Authentification().getUserPersistent(this);
        if(res.next()){
            this.setIdProfile(res.getInt("id_profil"));
            this.setId(res.getInt("id_utilisateur"));
        }
        return new Authentification().enter(this);
    }

    public String[] getPaths() {
        return paths;
    }

    public void setPaths(String[] paths) {
        this.paths = paths;
    }

    public HashMap getModules() {
        return modules;
    }

    public void setModules(HashMap modules) {
        this.modules = modules;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
