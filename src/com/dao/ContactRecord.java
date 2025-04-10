package com.dao;

import java.sql.Timestamp;

public class ContactRecord {
    private int recordId;           // 联系记录编号
    private int contactPersonId;    // 联系对象id（关联到ContactPerson表的contact_id）
    private String departmentContact; // 本部门联系人姓名（通过TUser表的aname来关联）
    private Timestamp contactTime;   // 联系时间（自动读取当前时间）
    private String contactContent;   // 联系内容
    private String remarks;          // 备注
    private String contactPersonName;

    public String getContactPersonName() {
        return contactPersonName;
    }

    public void setContactPersonName(String contactPersonName) {
        this.contactPersonName = contactPersonName;
    }

    public int getRecordId() {
        return recordId;
    }

    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }

    public int getContactPersonId() {
        return contactPersonId;
    }

    public void setContactPersonId(int contactPersonId) {
        this.contactPersonId = contactPersonId;
    }

    public String getDepartmentContact() {
        return departmentContact;
    }

    public void setDepartmentContact(String departmentContact) {
        this.departmentContact = departmentContact;
    }

    public Timestamp getContactTime() {
        return contactTime;
    }

    public void setContactTime(Timestamp contactTime) {
        this.contactTime = contactTime;
    }

    public String getContactContent() {
        return contactContent;
    }

    public void setContactContent(String contactContent) {
        this.contactContent = contactContent;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
