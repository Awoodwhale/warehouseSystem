package top.woodwhale.dao.supplier;

import top.woodwhale.dao.BaseDao;
import top.woodwhale.pojo.Supplier;
import top.woodwhale.utils.IdUtils;
import top.woodwhale.utils.Log;
import top.woodwhale.utils.TextUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SupplierDaoImpl implements ISupplierDao {
    /**
     * 新建或者更新供货商信息
     *
     * @param supplier 供货商
     * @return 结果
     */
    @Override
    public int save(Supplier supplier) {
        // 如果传入没有id，那么就是新增,如果找不到这个id存在，那么还是新增
        if (TextUtils.isEmpty(supplier.getId()) || findOneById(supplier.getId()) == null) {
            return addSupplier(supplier);
        } else {
            // 如果有id，那么就是更改这个id
            return updateSupplier(supplier);
        }
    }

    /**
     * 删除或者恢复供货商状态
     *
     * @param id 供货商id
     * @return 结果
     */
    @Override
    public int deleteOrRecoverOneById(String id) {
        try {
            Supplier supplierInMysql = findOneById(id);
            if (supplierInMysql == null) {
                Log.d(this, "该供货商id不存在");
                return 0;
            }
            String sql = "update tb_supplier set state = " + (supplierInMysql.getState() ? "0" : "1") + " where id = ?";
            Object[] params = {id};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "修改供货商 " + id + " 状态成功" : "修改供货商 " + id + " 状态失败");
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
     * 添加供货商
     *
     * @param supplier 供货商
     * @return 结果
     */
    private int addSupplier(Supplier supplier) {
        try {
            String id = IdUtils.getId();
            String sql = "insert into tb_supplier (id, supplier_name, supplier_address, supplier_email) values(?,?,?,?)";
            Object[] params = {id, supplier.getName(), supplier.getAddress(), supplier.getEmail()};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "添加新供货商 " + id + " 成功" : "添加新供货商 " + id + " 失败");
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
     * 更新供货商
     *
     * @param supplier 供货商
     * @return 结果
     */
    private int updateSupplier(Supplier supplier) {
        try {
            String sql = "update tb_supplier set " +
                    "supplier_name = ?, supplier_address = ?, supplier_email = ?, update_time = now() " +
                    "where id = ?";
            Object[] params = {supplier.getName(), supplier.getAddress(), supplier.getEmail(), supplier.getId()};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "供货商 " + supplier.getId() + " 信息更新成功" :
                    "供货商 " + supplier.getId() + " 信息更新失败");
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
     * 通过供货商id查找供货商
     *
     * @param id 供货商id
     * @return 供货商
     */
    @Override
    public Supplier findOneById(String id) {
        String sql = "select * from tb_supplier where id = ?";
        Object[] params = {id};
        Supplier supplier = null;
        try {
            ResultSet rs = BaseDao.execute(sql, params);
            if (rs != null && rs.next()) {
                supplier = new Supplier(rs.getString("id"),
                        rs.getString("supplier_name"),
                        rs.getString("supplier_address"),
                        rs.getString("supplier_email"),
                        rs.getBoolean("state"),
                        rs.getTimestamp("create_time"),
                        rs.getTimestamp("update_time"));
            }
            return supplier;
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
     * 查找所有的供货商
     *
     * @return list
     */
    @Override
    public List<Supplier> findAll() {
        String sql = "select * from tb_supplier order by state desc, update_time desc";
        ResultSet rs = BaseDao.execute(sql, null);
        List<Supplier> res = new ArrayList<>();
        try {
            if (rs != null) {
                while (rs.next()) {
                    res.add(new Supplier(rs.getString("id"),
                            rs.getString("supplier_name"),
                            rs.getString("supplier_address"),
                            rs.getString("supplier_email"),
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
