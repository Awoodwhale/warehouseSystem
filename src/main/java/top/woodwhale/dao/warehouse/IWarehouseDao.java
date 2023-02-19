package top.woodwhale.dao.warehouse;

import top.woodwhale.pojo.Warehouse;
import top.woodwhale.pojo.WarehouseItem;

import java.util.List;

public interface IWarehouseDao {
    /**
     * 新建、更新仓库
     *
     * @param warehouse 仓库
     * @return 结果
     */
    int save(Warehouse warehouse);

    /**
     * 删除或者恢复一个仓库
     *
     * @param id 仓库id
     * @return 结果
     */
    int deleteOrRecoverOneById(String id);

    /**
     * 通过仓库id查找一个仓库
     *
     * @param id 仓库id
     * @return 仓库
     */
    Warehouse findOneById(String id);

    /**
     * 查找所有仓库
     *
     * @return list
     */
    List<Warehouse> findAll();

    /**
     * 通过id查找一个仓库库存
     *
     * @param id 仓库id
     * @return list
     */
    List<WarehouseItem> findOneItemById(String id);

    /**
     * 通过仓库id和材料id查询库存数量
     *
     * @param warehouseId 仓库id
     * @param itemId      材料id
     * @return warehouseItem
     */
    WarehouseItem findOneWarehouseItemByIds(String warehouseId, String itemId);

    /**
     * 查找所有的库存
     *
     * @return list
     */
    List<WarehouseItem> findAllItem();

    /**
     * 通过仓库id和材料id删除仓库库存记录
     *
     * @param warehouseId 仓库id
     * @param itemId      材料id
     * @return 结果
     */
    int deleteOneItemById(String warehouseId, String itemId);
}
