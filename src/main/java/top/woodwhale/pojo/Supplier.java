package top.woodwhale.pojo;

import java.util.Date;

/**
 * 供应商pojo
 */
public class Supplier {
    String id;
    String name;
    String address;
    String email;
    Boolean state;
    Date createTime;
    Date updateTime;

    public Supplier() {
    }

    public Supplier(String id, String name, String address, String email, Boolean state, Date createTime, Date updateTime) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.email = email;
        this.state = state;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getState() {
        return state;
    }

    public void setState(Boolean state) {
        this.state = state;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
