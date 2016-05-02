package com.procurable.domain.request;

import com.procurable.domain.response.Department;

/**
 * Created by Matt on 2/22/2016.
 */
public class RegisterRequest {
    String Email;
    String Password;
    String ConfirmPassword;
    Integer DepartmentID;

    public RegisterRequest(String email, String password, String confirmPassword,Integer departmentID) {
        Email = email;
        Password = password;
        ConfirmPassword = confirmPassword;
        DepartmentID = departmentID;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        this.Email = email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        this.Password = password;
    }

    public String getConfirmPassword() {
        return ConfirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.ConfirmPassword = confirmPassword;
    }

    public Integer getDepartmentID() {
        return DepartmentID;
    }

    public void setDepartmentID(Integer departmentID) {
        DepartmentID = departmentID;
    }
}
