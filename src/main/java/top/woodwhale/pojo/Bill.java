package top.woodwhale.pojo;

import java.util.Date;

/**
 * 账单pojo
 */
public class Bill {
    String id;  // 账单id
    String warehouseId; // 仓库id
    String operation;   // 操作种类
    String itemId;      // 材料id
    Integer itemDealCount;  // 交易数量
    String isDispatch;  // 1表示仓库调度，0表示供货商交易
    String directionId; // 如果是进货，那么就是供货商id，如果是出货，那么就是供货商或者仓库id
    Date createTime;    // 创建台账的时间
    Date updateTime;    // 更新台账的时间（人为更新）

    public Bill() {
    }

    public Bill(String id, String warehouseId, String operation, String itemId, Integer itemDealCount, String isDispatch, String directionId, Date createTime, Date updateTime) {
        this.id = id;
        this.warehouseId = warehouseId;
        this.operation = operation;
        this.itemId = itemId;
        this.itemDealCount = itemDealCount;
        this.isDispatch = isDispatch;
        this.directionId = directionId;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public Integer getItemDealCount() {
        return itemDealCount;
    }

    public void setItemDealCount(Integer itemDealCount) {
        this.itemDealCount = itemDealCount;
    }

    public String getIsDispatch() {
        return isDispatch;
    }

    public void setIsDispatch(String isDispatch) {
        this.isDispatch = isDispatch;
    }

    public String getDirectionId() {
        return directionId;
    }

    public void setDirectionId(String directionId) {
        this.directionId = directionId;
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
