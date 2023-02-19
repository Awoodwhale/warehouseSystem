package top.woodwhale.dao.item;

import top.woodwhale.pojo.Item;

import java.util.List;

public interface IItemDao {
    /**
     * 保存材料到MySQL中
     * @param item 材料pojo
     * @return 结果
     */
    int save(Item item);

    /**
     * 根据id删除或者恢复一个材料
     * @param id 材料id
     * @return 结果
     */
    int deleteOrRecoverOneById(String id);

    /**
     * 通过材料id查询材料
     * @param id 材料id
     * @return Item类
     */
    Item findOneById(String id);

    /**
     * 查找MySQL中所有的材料信息
     * @return  List<Item>
     */
    List<Item> findAll();
}
