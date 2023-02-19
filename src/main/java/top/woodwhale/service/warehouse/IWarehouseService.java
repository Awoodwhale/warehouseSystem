package top.woodwhale.service.warehouse;

import top.woodwhale.pojo.Warehouse;
import top.woodwhale.pojo.WarehouseItem;

import java.util.List;

public interface IWarehouseService {
    /**
     * 添加仓库
     *
     * @param warehouse 仓库
     * @return 结果
     */
    int addWarehouse(Warehouse warehouse);

    /**
     * 通过id获取仓库信息
     *
     * @param id 仓库id
     * @return 仓库
     */
    Warehouse getWarehouseById(String id);

    /**
     * 获取仓库列表
     *
     * @return 列表
     */
    List<Warehouse> listWarehouses();

    /**
     * 通过id删除仓库
     *
     * @param id 仓库id
     * @return 结果
     */
    int deleteOrRecoverWarehouseById(String id);

    /**
     * 通过id更新仓库
     *
     * @param id        仓库id
     * @param warehouse 仓库属性
     * @return 结果
     */
    int editWarehouseById(String id, Warehouse warehouse);

    /**
     * 获取库存列表
     *
     * @return list
     */
    List<WarehouseItem> listWarehouseItems();
}
