package top.woodwhale.dao.bill;

import top.woodwhale.pojo.Bill;

import java.util.List;

public interface IBillDao {
    /**
     * 保存一个台账
     *
     * @param bill 台账
     * @return 结果
     */
    int save(Bill bill);

    /**
     * 列出所有的台账
     *
     * @return list
     */
    List<Bill> findAll();
}
