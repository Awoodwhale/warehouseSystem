package top.woodwhale.dao.warehouse;

import top.woodwhale.dao.BaseDao;
import top.woodwhale.pojo.Warehouse;
import top.woodwhale.pojo.WarehouseItem;
import top.woodwhale.utils.IdUtils;
import top.woodwhale.utils.Log;
import top.woodwhale.utils.TextUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDaoImpl implements IWarehouseDao {
    /**
     * 新建或者更新仓库
     *
     * @param warehouse 仓库
     * @return 结果
     */
    @Override
    public int save(Warehouse warehouse) {
        // 如果传入没有id，那么就是新增,如果找不到这个id存在，那么还是新增
        if (TextUtils.isEmpty(warehouse.getId()) || findOneById(warehouse.getId()) == null) {
            return addWarehouse(warehouse);
        } else {
            // 如果有id，那么就是更改这个id
            return updateWarehouse(warehouse);
        }
    }

    /**
     * 通过id删除仓库，其实是假删除，仅仅修改仓库状态
     *
     * @param id 仓库id
     * @return 结果
     */
    @Override
    public int deleteOrRecoverOneById(String id) {
        try {
            Warehouse warehouseInMysql = findOneById(id);
            if (warehouseInMysql == null) {
                Log.d(this, "该仓库id不存在");
                return 0;
            }
            String sql = "update tb_warehouse_info set state = " + (warehouseInMysql.getState() ? "0" : "1") + " where id = ?";
            Object[] params = {id};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "修改仓库状态成功" : "修改仓库状态失败");
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
     * 添加仓库
     *
     * @param warehouse 仓库
     * @return 结果
     */
    private int addWarehouse(Warehouse warehouse) {
        try {
            String sql = "insert into tb_warehouse_info (id, warehouse_name, warehouse_address, warehouse_email) values(?,?,?,?)";
            Object[] params = {IdUtils.getId(), warehouse.getName(), warehouse.getAddress(), warehouse.getEmail()};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "添加新仓库成功" : "添加新仓库失败");
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
     * 更新仓库信息
     *
     * @param warehouse 仓库
     * @return 结果
     */
    private int updateWarehouse(Warehouse warehouse) {
        try {
            String sql = "update tb_warehouse_info set " +
                    "warehouse_name = ?, warehouse_address = ?, warehouse_email = ?, update_time = now() " +
                    "where id = ?";
            Object[] params = {warehouse.getName(), warehouse.getAddress(), warehouse.getEmail(), warehouse.getId()};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "仓库信息更新成功" : "仓库信息更新失败");
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
     * 通过仓库id查找仓库
     *
     * @param id 仓库id
     * @return 仓库类
     */
    @Override
    public Warehouse findOneById(String id) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "仓库id不可为空");
            return null;
        }
        String sql = "select * from tb_warehouse_info where id = ?";
        Object[] params = {id};
        Warehouse warehouse = null;
        try {
            ResultSet rs = BaseDao.execute(sql, params);
            if (rs != null && rs.next()) {
                warehouse = new Warehouse(rs.getString("id"),
                        rs.getString("warehouse_name"),
                        rs.getString("warehouse_address"),
                        rs.getString("warehouse_email"),
                        rs.getBoolean("state"),
                        rs.getTimestamp("create_time"),
                        rs.getTimestamp("update_time"));
            }
            return warehouse;
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
     * 查找所有仓库
     *
     * @return list
     */
    @Override
    public List<Warehouse> findAll() {
        String sql = "select * from tb_warehouse_info order by state desc , update_time desc";
        ResultSet rs = BaseDao.execute(sql, null);
        List<Warehouse> res = new ArrayList<>();
        try {
            if (rs != null) {
                while (rs.next()) {
                    res.add(new Warehouse(rs.getString("id"),
                            rs.getString("warehouse_name"),
                            rs.getString("warehouse_address"),
                            rs.getString("warehouse_email"),
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

    /**
     * 通过id查询材料库存集合
     *
     * @param id 仓库id
     * @return list
     */
    @Override
    public List<WarehouseItem> findOneItemById(String id) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "仓库id不可为空");
            return null;
        }
        String sql = "select * from tb_warehouse_item where id = ?";
        Object[] params = {id};
        List<WarehouseItem> res = new ArrayList<>();
        try {
            ResultSet rs = BaseDao.execute(sql, params);
            while (rs != null && rs.next()) {
                res.add(new WarehouseItem(rs.getString("id"),
                        rs.getString("item_id"),
                        rs.getString("item_count"),
                        rs.getTimestamp("create_time"),
                        rs.getTimestamp("update_time")));
            }
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            boolean flag = BaseDao.closeResource();
            if (!flag) {
                Log.d(this, "关闭数据库资源失败");
            }
        }
        return res;
    }

    /**
     * 获取某个仓库中的某个材料的信息
     *
     * @param warehouseId 仓库id
     * @param itemId      材料id
     * @return WarehouseItem
     */
    @Override
    public WarehouseItem findOneWarehouseItemByIds(String warehouseId, String itemId) {
        try {
            String sql = "select * from tb_warehouse_item where id = ? and item_id = ?";
            Object[] params = {warehouseId, itemId};
            ResultSet rs = BaseDao.execute(sql, params);
            WarehouseItem warehouseItem = null;
            if (rs != null && rs.next()) {
                warehouseItem = new WarehouseItem(rs.getString("id"),
                        rs.getString("item_id"),
                        rs.getString("item_count"),
                        rs.getTimestamp("create_time"),
                        rs.getTimestamp("update_time"));
            }
            return warehouseItem;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 找到所有的仓库库存
     *
     * @return list
     */
    @Override
    public List<WarehouseItem> findAllItem() {
        String sql = "select * from tb_warehouse_item order by id desc, update_time desc";
        ResultSet rs = BaseDao.execute(sql, null);
        List<WarehouseItem> res = new ArrayList<>();
        try {
            if (rs != null) {
                while (rs.next()) {
                    res.add(new WarehouseItem(rs.getString("id"),
                            rs.getString("item_id"),
                            rs.getString("item_count"),
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

    /**
     * 通过仓库id和材料id删除库存记录（完全删除）
     *
     * @param warehouseId 仓库id
     * @param itemId      材料id
     * @return 结果
     */
    @Override
    public int deleteOneItemById(String warehouseId, String itemId) {
        try {
            String sql = "delete from tb_warehouse_item where id = ? and item_id = ?";
            Object[] params = {warehouseId, itemId};
            return BaseDao.executeUpdate(sql, params);
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
}
