package top.woodwhale.dao.supplier;

import top.woodwhale.pojo.Supplier;

import java.util.List;

public interface ISupplierDao {
    /**
     * 更新或者新建供货商
     *
     * @param supplier 供货商
     * @return 结果
     */
    int save(Supplier supplier);

    /**
     * 根据id删除或者恢复一个供货商
     * @param id 供货商id
     * @return 结果
     */
    int deleteOrRecoverOneById(String id);

    /**
     * @param id 供货商id
     * @return 结果
     */
    Supplier findOneById(String id);

    /**
     * @return 返回所有供货商
     */
    List<Supplier> findAll();
}
