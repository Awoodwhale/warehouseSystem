package top.woodwhale.service.supplier;

import top.woodwhale.pojo.Supplier;

import java.util.List;

public interface ISupplierService {
    /**
     * 添加供货商
     *
     * @param supplier 供货商
     * @return 结果
     */
    int addSupplier(Supplier supplier);

    /**
     * 获取供货商列表
     *
     * @return List<Supplier>
     */
    List<Supplier> listSuppliers();

    /**
     * 删除或者恢复供货商
     *
     * @param id 供货商id
     * @return 结果
     */
    int deleteOrRecoverSupplier(String id);

    /**
     * 修改供货商信息
     * @param id id
     * @param supplier 供货商信息
     * @return
     */
    int editSupplierById(String id, Supplier supplier);

    /**
     * 通过id查找供货商
     * @param id 供货商id
     * @return Supplier
     */
    Supplier getSupplierById(String id);
}
