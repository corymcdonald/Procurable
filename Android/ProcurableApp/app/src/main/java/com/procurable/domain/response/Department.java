package com.procurable.domain.response;

import java.util.ArrayList;
import java.util.List;
public class Department {

    private List<Object> Users = new ArrayList<Object>();
    private Integer ID;
    private String Name;
    private String Description;
    private Integer Budget;

    public List<Object> getUsers() {
        return Users;
    }

    public void setUsers(List<Object> Users) {
        this.Users = Users;
    }

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

    public Integer getBudget() {
        return Budget;
    }

    public void setBudget(Integer Budget) {
        this.Budget = Budget;
    }

}