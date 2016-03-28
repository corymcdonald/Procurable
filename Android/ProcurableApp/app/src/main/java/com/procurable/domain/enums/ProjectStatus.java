package com.procurable.domain.enums;

/**
 * Created by Matt on 3/7/2016.
 */
public enum ProjectStatus {
    Low(0), Medium(1), High(2);

    private Integer projectPriority;

    private ProjectStatus(Integer i) {
        projectPriority = i;
    }

    public Integer getStatusCode() {
        return projectPriority;
    }
}