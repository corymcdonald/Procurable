package com.procurable.domain.request;

/**
 * Created by Matt on 2/22/2016.
 */
public class LoginRequest {

    public LoginRequest(String email, String password) {
        Email = email;
        Password = password;
    }

    String Email;
    String Password;

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
}
