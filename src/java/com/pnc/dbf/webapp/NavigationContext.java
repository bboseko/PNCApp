package com.pnc.dbf.webapp;

import com.pnc.dbf.config.DBConnection;
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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

    public NavigationContext() throws SQLException {
        FacesContext context = FacesContext.getCurrentInstance();
        ValueBinding binding = context.getApplication().createValueBinding("#{signInBean.idProfile}");

        ArrayList parameter = new ArrayList();
        parameter.add(Integer.parseInt(binding.getValue(context).toString()));
        ResultSet res = DBConnection.getResultDB("select * from fonctionnalite inner join acceder on "
                + "acceder.id_fonctionnalite = fonctionnalite.id_fonctionnalite where id_profil = ?", parameter);
        while (res.next()) {
            DefaultMenuItem item = new DefaultMenuItem(res.getString("shortname_fonctionnalite"));
            item.setTitle(res.getString("nom_fonctionnalite"));
            item.setCommand(res.getString("commande_fonctionnalite"));
            item.setIcon(res.getString("icone_fonctionnalite"));
            item.setOnclick("selectFunctionalityLink(this)");
            item.setStyleClass(getMenuitemStyleClass(res.getString("page_fonctionnalite")));
            item.setStyle("font-size: 13px;padding: 4px;");
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
