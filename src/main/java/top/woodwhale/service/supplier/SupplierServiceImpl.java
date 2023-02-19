package top.woodwhale.service.supplier;

import top.woodwhale.dao.supplier.ISupplierDao;
import top.woodwhale.dao.supplier.SupplierDaoImpl;
import top.woodwhale.pojo.Supplier;
import top.woodwhale.utils.Log;
import top.woodwhale.utils.TextUtils;

import java.util.List;

public class SupplierServiceImpl implements ISupplierService {
    ISupplierDao supplierDao = new SupplierDaoImpl();

    private static ISupplierService supplierService = null;

    private SupplierServiceImpl() {

    }

    // 饿汉式 单例模式
    public static ISupplierService getSupplierService() {
        if (supplierService == null) {
            supplierService = new SupplierServiceImpl();
        }
        return supplierService;
    }

    /**
     * 添加供货商
     *
     * @param supplier 供货商
     * @return 结果
     */
    @Override
    public int addSupplier(Supplier supplier) {
        if (checkSupplier(supplier)) return 0;
        return supplierDao.save(supplier);
    }

    /**
     * 获取供货商列表
     *
     * @return List<Supplier>
     */
    @Override
    public List<Supplier> listSuppliers() {
        return supplierDao.findAll();
    }

    /**
     * 删除或者恢复供货商
     *
     * @param id 供货商id
     * @return 结果
     */
    @Override
    public int deleteOrRecoverSupplier(String id) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "供货商id不可为空");
            return 0;
        }
        return supplierDao.deleteOrRecoverOneById(id);
    }

    /**
     * 修改供货商信息
     *
     * @param id       id
     * @param supplier 供货商信息
     * @return 结果
     */
    @Override
    public int editSupplierById(String id, Supplier supplier) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "供货商id不可为空");
            return 0;
        }
        if (checkSupplier(supplier)) return 0;
        supplier.setId(id);
        return supplierDao.save(supplier);
    }

    /**
     * 通过供货商id获取供货商对象
     *
     * @param id 供货商id
     * @return Supplier
     */
    @Override
    public Supplier getSupplierById(String id) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "供货商id不可为空");
            return null;
        }
        return supplierDao.findOneById(id);
    }

    private boolean checkSupplier(Supplier supplier) {
        if (TextUtils.isEmpty(supplier.getName())) {
            Log.d(this, "供货商名称不可为空");
            return true;
        }
        if (TextUtils.isEmpty(supplier.getAddress())) {
            Log.d(this, "供货商地址不可为空");
            return true;
        }
        if (TextUtils.isEmpty(supplier.getEmail())) {
            Log.d(this, "供货商邮箱不可为空");
            return true;
        }
        return false;
    }
}
