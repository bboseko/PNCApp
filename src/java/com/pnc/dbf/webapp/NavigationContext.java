package com.pnc.dbf.webapp;

import com.pnc.dbf.config.DBConnection;
import com.pnc.dbf.sec.Authentification;
import com.pnc.dbf.system.Fonctionnalite;
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;
import org.primefaces.model.menu.DefaultMenuItem;
import org.primefaces.model.menu.DefaultMenuModel;
import org.primefaces.model.menu.DefaultSeparator;
import org.primefaces.model.menu.MenuModel;

@ManagedBean
@RequestScoped
public class NavigationContext implements Serializable {

    private static final long serialVersionUID = 20111020L;
    private MenuModel model = new DefaultMenuModel();

    public NavigationContext() throws Exception {
        FacesContext context = FacesContext.getCurrentInstance();
        ValueBinding binding = context.getApplication().createValueBinding("#{user.idProfile}");
        ArrayList<Fonctionnalite> foncts = new Authentification().getUserModules(Integer.parseInt(binding.getValue(context).toString()));
        Iterator<Fonctionnalite> it =  foncts.iterator();
        while (it.hasNext()) {
            Fonctionnalite f = it.next();
            DefaultMenuItem item = new DefaultMenuItem(f.getShortname_fonctionnalite());
            item.setTitle(f.getNom_fonctionnalite());
            item.setCommand(f.getCommande_fonctionnalite());
            item.setIcon(f.getIcone_fonctionnalite());
            item.setOnclick("selectFunctionalityLink(this)");
            item.setStyleClass(getMenuitemStyleClass(f.getPage_fonctionnalite()));
            item.setStyle("font-size: 13px;padding: 4px;");
            item.setHref(f.getChemin_fonctionnalite());
            model.addElement(item);
            model.addElement(new DefaultSeparator());
        }
    }

    public final String getMenuitemStyleClass(final String page) {
        final String viewId = getViewId();
        if (viewId != null && viewId.equals(page)) {
            return "ui-state-active";
        }
        return "";
    }

    public String getViewId() {
        FacesContext fc = FacesContext.getCurrentInstance();
        String viewId = fc.getViewRoot().getViewId();
        String selectedComponent;
        if (viewId != null) {
            selectedComponent = viewId.substring(viewId.lastIndexOf("/") + 1, viewId.lastIndexOf("."));
        } else {
            selectedComponent = null;
        }
        return selectedComponent;
    }

    private void addMessage(FacesMessage.Severity severity, String title, String message) {
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(severity, title, message));
    }

    public MenuModel getModel() {
        return model;
    }

    public void setModel(MenuModel model) {
        this.model = model;
    }
}
