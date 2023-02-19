package top.woodwhale.dao.item;

import top.woodwhale.dao.BaseDao;
import top.woodwhale.pojo.Item;
import top.woodwhale.utils.IdUtils;
import top.woodwhale.utils.Log;
import top.woodwhale.utils.TextUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemDaoImpl implements IItemDao {
    /**
     * 保存新的材料信息、新增材料
     *
     * @param item 材料pojo
     * @return 结果
     */
    @Override
    public int save(Item item) {
        // 如果传入没有id，那么就是新增材料,如果找不到这个id存在，那么还是新增
        if (TextUtils.isEmpty(item.getId()) || findOneById(item.getId()) == null) {
            return addItem(item);
        } else {
            // 如果有id，那么就是更改这个id的材料
            return updateItem(item);
        }
    }

    /**
     * 删除或者恢复一个材料
     *
     * @param id 材料id
     * @return 结果
     */
    @Override
    public int deleteOrRecoverOneById(String id) {
        try {
            Item itemInMysql = findOneById(id);
            if (itemInMysql == null) {
                Log.d(this, "该材料id不存在");
                return 0;
            }
            String sql = "update tb_item set state = " + (itemInMysql.getState() ? "0" : "1") + " where id = ?";
            Object[] params = {id};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "修改材料 " + id + " 状态成功" : "修改材料 " + id + " 状态失败");
            return res;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            boolean flag = BaseDao.closeResource();
            if (!flag) {
                Log.d(this, "关闭数据库资源失败");
            }
        }
        return 0;
    }

    /**
     * 更新材料信息
     *
     * @param item 材料
     * @return 结果
     */
    private int updateItem(Item item) {
        try {
            String sql = "update tb_item set item_name = ?, item_price = ?, update_time = now() where id = ?";
            Object[] params = {item.getName(), item.getPrice(), item.getId()};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "材料 " + item.getId() + " 信息更新成功" : "材料 " + item.getId() + " 信息更新失败");
            return res;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            boolean flag = BaseDao.closeResource();
            if (!flag) {
                Log.d(this, "关闭数据库资源失败");
            }
        }
        return 0;
    }

    /**
     * 新增材料
     *
     * @param item 材料
     * @return 结果
     */
    private int addItem(Item item) {
        try {
            String id = IdUtils.getId();
            String sql = "insert into tb_item (id, item_name, item_price) values(?,?,?)";
            Object[] params = {id, item.getName(), item.getPrice()};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "添加新材料 " + id + " 成功" : "添加新材料 " + id + " 失败");
            return res;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            boolean flag = BaseDao.closeResource();
            if (!flag) {
                Log.d(this, "关闭数据库资源失败");
            }
        }
        return 0;
    }

    /**
     * 通过id查询材料
     *
     * @param id 材料id
     * @return Item
     */
    @Override
    public Item findOneById(String id) {
        String sql = "select * from tb_item where id = ?";
        Object[] params = {id};
        Item item = null;
        try {
            ResultSet rs = BaseDao.execute(sql, params);
            if (rs != null && rs.next()) {
                item = new Item(rs.getString("id"),
                        rs.getString("item_name"),
                        rs.getDouble("item_price"),
                        rs.getBoolean("state"),
                        rs.getTimestamp("create_time"),
                        rs.getTimestamp("update_time"));
            }
            return item;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            boolean flag = BaseDao.closeResource();
            if (!flag) {
                Log.d(this, "关闭数据库资源失败");
            }
        }
        return null;
    }

    /**
     * 查询所有的材料
     *
     * @return List<Item>
     */
    @Override
    public List<Item> findAll() {
        String sql = "select * from tb_item order by state desc, update_time desc";
        ResultSet rs = BaseDao.execute(sql, null);
        List<Item> res = new ArrayList<>();
        try {
            if (rs != null) {
                while (rs.next()) {
                    res.add(new Item(rs.getString("id"),
                            rs.getString("item_name"),
                            rs.getDouble("item_price"),
                            rs.getBoolean("state"),
                            rs.getTimestamp("create_time"),
                            rs.getTimestamp("update_time")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            boolean flag = BaseDao.closeResource();
            if (!flag) {
                Log.d(this, "关闭数据库资源失败");
            }
        }
        return res;
    }
}
