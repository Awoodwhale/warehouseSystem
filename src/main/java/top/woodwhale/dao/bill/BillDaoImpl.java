package top.woodwhale.dao.bill;

import top.woodwhale.dao.BaseDao;
import top.woodwhale.pojo.Bill;
import top.woodwhale.utils.IdUtils;
import top.woodwhale.utils.Log;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillDaoImpl implements IBillDao {
    /**
     * 在台账这个层面，只能新建台账，不能修改台账数据，所有的历史数据都是不可修改的
     *
     * @param bill 台账
     * @return 结果
     */
    @Override
    public int save(Bill bill) {
        try {
            String id = IdUtils.getId();
            String sql = "insert into tb_bill " +
                    "(id, warehouse_id, operation, item_id, item_deal_count, is_dispatch, direction_id, create_time) " +
                    "values(?,?,?,?,?,?,?,?)";
            Object[] params = {id, bill.getWarehouseId(), bill.getOperation(), bill.getItemId(),
                    bill.getItemDealCount(), bill.getIsDispatch(), bill.getDirectionId(), bill.getCreateTime()};
            int res = BaseDao.executeUpdate(sql, params);
            Log.d(this, res != 0 ? "添加台账记录" + id + "成功" : "添加台账记录" + id + "失败");
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            Log.d(this, "添加台账记录失败");
        } finally {
            boolean flag = BaseDao.closeResource();
            if (!flag) {
                Log.d(this, "关闭数据库资源失败");
            }
        }
        return 0;
    }

    /**
     * 查看最新的所有台账
     *
     * @return list
     */
    @Override
    public List<Bill> findAll() {
        String sql = "select * from tb_bill order by create_time desc";
        ResultSet rs = BaseDao.execute(sql, null);
        List<Bill> res = new ArrayList<>();
        try {
            if (rs != null) {
                while (rs.next()) {
                    res.add(new Bill(rs.getString("id"),
                            rs.getString("warehouse_id"),
                            rs.getString("operation"),
                            rs.getString("item_id"),
                            rs.getInt("item_deal_count"),
                            rs.getString("is_dispatch"),
                            rs.getString("direction_id"),
                            rs.getTimestamp("create_time"),
                            rs.getTimestamp("update_time")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Log.d(this, "查看台账记录失败");
        } finally {
            boolean flag = BaseDao.closeResource();
            if (!flag) {
                Log.d(this, "关闭数据库资源失败");
            }
        }
        return res;
    }
}
