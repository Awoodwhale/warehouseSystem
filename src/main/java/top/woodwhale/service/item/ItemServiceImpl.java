package top.woodwhale.service.item;

import top.woodwhale.dao.item.IItemDao;
import top.woodwhale.dao.item.ItemDaoImpl;
import top.woodwhale.pojo.Item;
import top.woodwhale.utils.Log;
import top.woodwhale.utils.TextUtils;

import java.util.List;

public class ItemServiceImpl implements IItemService {
    IItemDao itemDao = new ItemDaoImpl();

    private static IItemService iItemService = null;

    private ItemServiceImpl() {

    }

    // 饿汉式 单例模式
    public static IItemService getItemService() {
        if (iItemService == null) {
            iItemService = new ItemServiceImpl();
        }
        return iItemService;
    }

    /**
     * 添加item
     *
     * @param item item
     * @return 结果
     */
    @Override
    public int addItem(Item item) {
        // 在服务层处理输入合法问题校验
        if (TextUtils.isEmpty(item.getName())) {
            Log.d(this, "材料名称不可为空");
            return 0;
        }
        if (item.getPrice() == null) {
            Log.d(this, "材料价格不可为空");
            return 0;
        }
        return itemDao.save(item);
    }

    /**
     * 获取item集合
     *
     * @return List<Item>
     */
    @Override
    public List<Item> listItems() {
        return itemDao.findAll();
    }

    /**
     * 通过材料id修改材料
     *
     * @param id   材料id
     * @param item 材料
     * @return 结果
     */
    @Override
    public int editItemById(String id, Item item) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "材料id不可为空");
            return 0;
        }
        if (TextUtils.isEmpty(item.getName())) {
            Log.d(this, "材料名称不可为空");
            return 0;
        }
        if (item.getPrice() == null) {
            Log.d(this, "材料价格不可为空");
            return 0;
        }
        item.setId(id);
        return itemDao.save(item);
    }

    /**
     * 删除或者恢复材料信息
     *
     * @param id 材料id
     * @return 结果
     */
    @Override
    public int deleteOrRecoverItemById(String id) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "材料id不可为空");
            return 0;
        }
        return itemDao.deleteOrRecoverOneById(id);
    }

    /**
     * 通过材料id获取材料
     *
     * @param id 材料id
     * @return item
     */
    @Override
    public Item getItemById(String id) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "材料id不可为空");
            return null;
        }
        return itemDao.findOneById(id);
    }
}
