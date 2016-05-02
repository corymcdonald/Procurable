
package com.procurable.domain.response;

import java.io.Serializable;

public class Vendor  implements Serializable {

    private Integer ID;
    private String Name;
    private String Description;
    private String Website;
    private Object Contact;

    /**
     * 
     * @return
     *     The ID
     */
    public Integer getID() {
        return ID;
    }

    /**
     * 
     * @param ID
     *     The ID
     */
    public void setID(Integer ID) {
        this.ID = ID;
    }

    /**
     * 
     * @return
     *     The Name
     */
    public String getName() {
        return Name;
    }

    /**
     * 
     * @param Name
     *     The Name
     */
    public void setName(String Name) {
        this.Name = Name;
    }

    /**
     * 
     * @return
     *     The Description
     */
    public String getDescription() {
        return Description;
    }

    /**
     * 
     * @param Description
     *     The Description
     */
    public void setDescription(String Description) {
        this.Description = Description;
    }

    /**
     * 
     * @return
     *     The Website
     */
    public String getWebsite() {
        return Website;
    }

    /**
     * 
     * @param Website
     *     The Website
     */
    public void setWebsite(String Website) {
        this.Website = Website;
    }

    /**
     * 
     * @return
     *     The Contact
     */
    public Object getContact() {
        return Contact;
    }

    /**
     * 
     * @param Contact
     *     The Contact
     */
    public void setContact(Object Contact) {
        this.Contact = Contact;
    }

}
