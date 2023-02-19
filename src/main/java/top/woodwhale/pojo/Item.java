package top.woodwhale.pojo;

import java.util.Date;

/**
 * 商品的pojo
 */
public class Item {
    String id;
    String name;
    Double price;
    Boolean state;
    Date createTime;
    Date updateTime;

    public Item() {
    }

    public Item(String id, String name, Double price, Boolean state, Date createTime, Date updateTime) {
        this.id = id;
        this.name = name;
        this.price = price;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
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
