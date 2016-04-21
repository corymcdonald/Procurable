package com.procurable.domain.response;

/**
 * Created by Matt on 2/22/2016.
 */
public class GenericResponse {
    Boolean Succeeded;
    String[] Errors;

    public Boolean getSucceeded() {
        return Succeeded;
    }

    public void setSucceeded(Boolean succeeded) {
        Succeeded = succeeded;
    }

    public String[] getErrors() {
        return Errors;
    }

    public void setErrors(String[] errors) {
        Errors = errors;
    }
}
