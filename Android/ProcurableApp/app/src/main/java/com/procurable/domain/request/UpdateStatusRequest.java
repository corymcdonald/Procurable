package com.procurable.domain.request;

/**
 * Created by Matt on 2/22/2016.
 */
public class UpdateStatusRequest {

    public UpdateStatusRequest(Integer status) {
        this.status = status;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    Integer status;
}
