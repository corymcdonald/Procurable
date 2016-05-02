package com.procurable.domain.response;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Matt on 3/27/2016.
 */
public class Role implements Serializable {
    private String UserId;

    public Map<String, Object> getAdditionalProperties() {
        return additionalProperties;
    }

    public void setAdditionalProperties(Map<String, Object> additionalProperties) {
        this.additionalProperties = additionalProperties;
    }

    public String getRoleId() {
        return RoleId;
    }

    public void setRoleId(String roleId) {
        RoleId = roleId;
    }

    public String getUserId() {
        return UserId;
    }

    public void setUserId(String userId) {
        UserId = userId;
    }

    private String RoleId;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();
}
