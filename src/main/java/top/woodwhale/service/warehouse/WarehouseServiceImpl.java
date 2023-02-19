package top.woodwhale.service.warehouse;

import top.woodwhale.dao.warehouse.IWarehouseDao;
import top.woodwhale.dao.warehouse.WarehouseDaoImpl;
import top.woodwhale.pojo.Warehouse;
import top.woodwhale.pojo.WarehouseItem;
import top.woodwhale.utils.IdUtils;
import top.woodwhale.utils.Log;
import top.woodwhale.utils.TextUtils;

import java.util.List;

public class WarehouseServiceImpl implements IWarehouseService {
    /**
     * 仓库dao层
     */
    IWarehouseDao IWarehouseDao = new WarehouseDaoImpl();
    private static IWarehouseService warehouseService = null;
    private WarehouseServiceImpl() {
    }

    // 饿汉式 单例模式
    public static IWarehouseService getWarehouseService() {
        if (warehouseService == null) {
            warehouseService = new WarehouseServiceImpl();
        }
        return warehouseService;
    }

    private boolean checkWarehouseInfo(Warehouse warehouse) {
        if (TextUtils.isEmpty(warehouse.getName())) {
            Log.d(this, "仓库名称不可为空");
            return false;
        }
        if (TextUtils.isEmpty(warehouse.getAddress())) {
            Log.d(this, "仓库地址不可为空");
            return false;
        }
        if (TextUtils.isEmpty(warehouse.getEmail())) {
            Log.d(this, "仓库邮箱不可为空");
            return false;
        }
        return true;
    }

    @Override
    public int addWarehouse(Warehouse warehouse) {
        if (checkWarehouseInfo(warehouse)) {
            warehouse.setId(IdUtils.getId());
            return IWarehouseDao.save(warehouse);
        }
        return 0;
    }

    @Override
    public Warehouse getWarehouseById(String id) {
        if (!TextUtils.isEmpty(id)) {
            return IWarehouseDao.findOneById(id);
        } else {
            Log.d(this, "仓库id不可为空");
            return null;
        }
    }

    @Override
    public List<Warehouse> listWarehouses() {
        return IWarehouseDao.findAll();
    }

    @Override
    public int deleteOrRecoverWarehouseById(String id) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "仓库id不可为空");
            return 0;
        }
        return IWarehouseDao.deleteOrRecoverOneById(id);
    }

    @Override
    public int editWarehouseById(String id, Warehouse warehouse) {
        if (TextUtils.isEmpty(id)) {
            Log.d(this, "仓库id不可为空");
            return 0;
        }
        if (checkWarehouseInfo(warehouse)) {
            warehouse.setId(id);
            return IWarehouseDao.save(warehouse);
        }
        return 0;
    }

    @Override
    public List<WarehouseItem> listWarehouseItems() {
        return IWarehouseDao.findAllItem();
    }
}
