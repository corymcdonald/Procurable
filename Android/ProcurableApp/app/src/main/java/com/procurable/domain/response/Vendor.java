package com.procurable.domain.response;

import java.io.Serializable;

/**
 * Created by Matt on 4/24/2016.
 */
public class Vendor implements Serializable{

    private Integer ID;
    private String Name;
    private String Description;
    private String Website;
    //private Object Contact;

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getWebsite() {
        return Website;
    }

    public void setWebsite(String Website) {
        this.Website = Website;
    }

    //public Object getContact() {
    //    return Contact;
    //}

    //public void setContact(Object Contact) {
    //    this.Contact = Contact;
   // }

}