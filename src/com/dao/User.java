package com.dao;

public class User {
    private String aname="";
    private String aword="";
    private String realname="";
    private String avalid="";
    private String RoleID="";
    private String RoleName="";

    public String getRoleID() {
        return RoleID;
    }

    public void setRoleID(String roleID) {
        RoleID = roleID;
    }


    public String getRoleName() {
        return RoleName;
    }

    public void setRoleName(String roleName) {
        RoleName = roleName;
    }


    public String getAname() {
        return aname;
    }

    public void setAname(String aname) {
        this.aname = aname;
    }

    public String getAword() {
        return aword;
    }

    public void setAword(String aword) {
        this.aword = aword;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getAvalid() {
        return avalid;
    }

    public void setAvalid(String avalid) {
        this.avalid = avalid;
    }
}
