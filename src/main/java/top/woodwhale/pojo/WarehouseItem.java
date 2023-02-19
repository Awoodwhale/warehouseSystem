package top.woodwhale.pojo;

import java.util.Date;

public class WarehouseItem {
    String id;
    String itemId;
    String itemCount;
    Date createTime;
    Date updateTime;

    public WarehouseItem() {

    }

    public WarehouseItem(String id, String itemId, String itemCount, Date createTime, Date updateTime) {
        this.id = id;
        this.itemId = itemId;
        this.itemCount = itemCount;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemCount() {
        return itemCount;
    }

    public void setItemCount(String itemCount) {
        this.itemCount = itemCount;
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
