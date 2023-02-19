package top.woodwhale.service.item;

import top.woodwhale.pojo.Item;

import java.util.List;

public interface IItemService {
    /**
     * 添加材料
     *
     * @param item 材料
     * @return 结果
     */
    int addItem(Item item);

    /**
     * 获取材料列表
     *
     * @return list
     */
    List<Item> listItems();

    /**
     * 通过id修改材料信息
     *
     * @param id   材料id
     * @param item 材料
     * @return 结果
     */
    int editItemById(String id, Item item);

    /**
     * 通过id删除或者恢复材料
     *
     * @param id 材料id
     * @return 结果
     */
    int deleteOrRecoverItemById(String id);

    /**
     * 通过id获取材料
     *
     * @param id 材料id
     * @return item
     */
    Item getItemById(String id);
}
