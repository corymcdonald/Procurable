package com.procurable.domain.response;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Matt on 3/27/2016.
 */
public class Person {
    private List<Object> Claims = new ArrayList<Object>();
    private List<Object> Logins = new ArrayList<Object>();

    public List<Role> getRoles() {
        return Roles;
    }

    public void setRoles(List<Role> roles) {
        Roles = roles;
    }

    private List<Role> Roles = new ArrayList<Role>();
    private String FirstName;
    private String LastName;
    private String Email;
    private Boolean EmailConfirmed;
    private String PasswordHash;
    private String SecurityStamp;
    private Object PhoneNumber;
    private Boolean PhoneNumberConfirmed;
    private Boolean TwoFactorEnabled;
    private Object LockoutEndDateUtc;
    private Boolean LockoutEnabled;
    private Integer AccessFailedCount;
    private String Id;
    private String UserName;

    public Integer getAccessFailedCount() {
        return AccessFailedCount;
    }

    public void setAccessFailedCount(Integer accessFailedCount) {
        AccessFailedCount = accessFailedCount;
    }

    public Map<String, Object> getAdditionalProperties() {
        return additionalProperties;
    }

    public void setAdditionalProperties(Map<String, Object> additionalProperties) {
        this.additionalProperties = additionalProperties;
    }

    public List<Object> getClaims() {
        return Claims;
    }

    public void setClaims(List<Object> claims) {
        Claims = claims;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public Boolean getEmailConfirmed() {
        return EmailConfirmed;
    }

    public void setEmailConfirmed(Boolean emailConfirmed) {
        EmailConfirmed = emailConfirmed;
    }

    public String getFirstName() {
        return FirstName;
    }

    public void setFirstName(String firstName) {
        FirstName = firstName;
    }

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String lastName) {
        LastName = lastName;
    }

    public Boolean getLockoutEnabled() {
        return LockoutEnabled;
    }

    public void setLockoutEnabled(Boolean lockoutEnabled) {
        LockoutEnabled = lockoutEnabled;
    }

    public Object getLockoutEndDateUtc() {
        return LockoutEndDateUtc;
    }

    public void setLockoutEndDateUtc(Object lockoutEndDateUtc) {
        LockoutEndDateUtc = lockoutEndDateUtc;
    }

    public List<Object> getLogins() {
        return Logins;
    }

    public void setLogins(List<Object> logins) {
        Logins = logins;
    }

    public String getPasswordHash() {
        return PasswordHash;
    }

    public void setPasswordHash(String passwordHash) {
        PasswordHash = passwordHash;
    }

    public Object getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(Object phoneNumber) {
        PhoneNumber = phoneNumber;
    }

    public Boolean getPhoneNumberConfirmed() {
        return PhoneNumberConfirmed;
    }

    public void setPhoneNumberConfirmed(Boolean phoneNumberConfirmed) {
        PhoneNumberConfirmed = phoneNumberConfirmed;
    }

    public String getSecurityStamp() {
        return SecurityStamp;
    }

    public void setSecurityStamp(String securityStamp) {
        SecurityStamp = securityStamp;
    }

    public Boolean getTwoFactorEnabled() {
        return TwoFactorEnabled;
    }

    public void setTwoFactorEnabled(Boolean twoFactorEnabled) {
        TwoFactorEnabled = twoFactorEnabled;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String userName) {
        UserName = userName;
    }

    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

}
