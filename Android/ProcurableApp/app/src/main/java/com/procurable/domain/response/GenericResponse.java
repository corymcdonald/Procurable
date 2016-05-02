package com.procurable.domain.response;

/**
 * Created by Matt on 2/22/2016.
 */
public class GenericResponse {
    Boolean Succeeded;
    String Error;

    public Boolean getSucceeded() {
        return Succeeded;
    }

    public void setSucceeded(Boolean succeeded) {
        Succeeded = succeeded;
    }

    public String getError() {
        return Error;
    }

    public void setError(String error) {
        Error = error;
    }
}
