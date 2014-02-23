/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pnc.dbf.sec;

import com.pnc.dbf.system.Historique;
import com.pnc.dbf.user.User;
import java.io.Serializable;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import org.primefaces.model.menu.DefaultMenuModel;
import org.primefaces.model.menu.MenuModel;

/**
 *
 * @author IMA7
 */
@ManagedBean
@SessionScoped
public class Autorisation implements Serializable{

    private MenuModel model = new DefaultMenuModel();
    private String path;
    static public String[] paths = {"views/home"};

    public Autorisation() {
    }

    public String decision(String path, User user) throws Exception{
        boolean found = false;
        for (int i = 0; i < paths.length; i++) {
            if (found = paths[i].equalsIgnoreCase(path)) {
                break;
            }
        }        
        Historique h = new Historique();
        h.setFonctionnalite(path);
        h.setOperation(path);
        h.save();
        
        return (found && user.getIdProfile() != null) ? path : null;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String[] getPaths() {
        return paths;
    }

    public void setPaths(String[] paths) {
        this.paths = paths;
    }

    public String autoriser() {
        FacesContext context = FacesContext.getCurrentInstance();
        System.out.println("nous voici" + context.getExternalContext().getRequestPathInfo());
        System.out.println("model est :" + getModel());
        return null;
    }

    public MenuModel getModel() {
        return model;
    }

    public void setModel(MenuModel model) {
        this.model = model;
    }
}
