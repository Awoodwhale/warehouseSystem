package top.woodwhale.service.bill;

import top.woodwhale.dao.bill.IBillDao;
import top.woodwhale.dao.bill.BillDaoImpl;
import top.woodwhale.dao.item.ItemDaoImpl;
import top.woodwhale.dao.supplier.SupplierDaoImpl;
import top.woodwhale.dao.warehouse.WarehouseDaoImpl;
import top.woodwhale.pojo.*;
import top.woodwhale.utils.IdUtils;
import top.woodwhale.utils.Log;
import top.woodwhale.utils.TextUtils;

import java.util.List;

public class BillServiceImpl implements IBillService {
    IBillDao billDao = new BillDaoImpl();

    private static IBillService billService = null;

    private BillServiceImpl() {

    }

    // 饿汉式 单例模式
    public static IBillService getBillService() {
        if (billService == null) {
            billService = new BillServiceImpl();
        }
        return billService;
    }

    /**
     * 检查账单信息是否正确输入
     *
     * @param bill 账单
     * @return 结果
     */
    private boolean checkBill(Bill bill) {
        if (TextUtils.isEmpty(bill.getWarehouseId())) {
            Log.d(this, "台账中仓库id不可为空");
            return false;
        }
        if (TextUtils.isEmpty(bill.getOperation())) {
            Log.d(this, "台账操作模式不可为空");
            return false;
        }
        if (TextUtils.isEmpty(bill.getItemId())) {
            Log.d(this, "台账中交易材料id不可为空");
            return false;
        }
        if (bill.getItemDealCount() == null) {
            Log.d(this, "台账中交易材料数量不可为空");
            return false;
        }
        if (TextUtils.isEmpty(bill.getIsDispatch())) {
            Log.d(this, "台账需要指明是否为仓库调拨");
            return false;
        }
        if (TextUtils.isEmpty(bill.getDirectionId())) {
            Log.d(this, "台账需要指明材料来源或去向");
            return false;
        }
        return true;
    }

    /**
     * 添加 进货 台账，是仓库从别的供货商进货的台账
     *
     * @param bill 台账信息
     * @return 结果
     */
    @Override
    public int addPurchaseBill(Bill bill) {
        bill.setId(IdUtils.getId());
        bill.setOperation("0");     // 从别的供货商借来的，所以是0
        bill.setIsDispatch("0");    // 不是仓库调度
        if (checkBill(bill)) {
            // 检查输入参数是否合法
            WarehouseDaoImpl warehouseDao = new WarehouseDaoImpl();
            Warehouse warehouseInMysql = warehouseDao.findOneById(bill.getWarehouseId());
            if (!warehouseInMysql.getState()) {
                Log.d(this, "进货的仓库已被删除");
                return 0;
            }
            ItemDaoImpl itemDao = new ItemDaoImpl();
            Item itemInMysql = itemDao.findOneById(bill.getItemId());
            if (!itemInMysql.getState()) {
                Log.d(this, "进货的材料已被删除");
                return 0;
            }
            SupplierDaoImpl supplierDao = new SupplierDaoImpl();
            Supplier supplierInMysql = supplierDao.findOneById(bill.getDirectionId());
            if (!supplierInMysql.getState()) {
                Log.d(this, "进货的供货商已被删除");
                return 0;
            }
            return billDao.save(bill);
        }
        return 0;
    }

    /**
     * 获取台账列表
     *
     * @return list
     */
    @Override
    public List<Bill> listBills() {
        return billDao.findAll();
    }

    /**
     * 添加出货台账
     *
     * @param bill 台账
     * @return 结果
     */
    @Override
    public int addOutflowBill(Bill bill) {
        bill.setId(IdUtils.getId());
        bill.setOperation("1");     // 出售货物给别的供货商，所以是1
        bill.setIsDispatch("0");    // 不是仓库调度
        if (checkBill(bill)) {
            // 检查输入参数是否合法
            WarehouseDaoImpl warehouseDao = new WarehouseDaoImpl();
            Warehouse warehouseInMysql = warehouseDao.findOneById(bill.getWarehouseId());
            if (!warehouseInMysql.getState()) {
                Log.d(this, "出货的仓库已被删除");
                return 0;
            }
            ItemDaoImpl itemDao = new ItemDaoImpl();
            Item itemInMysql = itemDao.findOneById(bill.getItemId());
            if (!itemInMysql.getState()) {
                Log.d(this, "出货的材料已被删除");
                return 0;
            }
            SupplierDaoImpl supplierDao = new SupplierDaoImpl();
            Supplier supplierInMysql = supplierDao.findOneById(bill.getDirectionId());
            if (!supplierInMysql.getState()) {
                Log.d(this, "出货的供货商已被删除");
                return 0;
            }
            // 判断出库材料是否足够
            WarehouseItem warehouseItemInMysql = warehouseDao.findOneWarehouseItemByIds(bill.getWarehouseId(), bill.getItemId());
            if (warehouseItemInMysql == null || Integer.parseInt(warehouseItemInMysql.getItemCount()) < bill.getItemDealCount()) {
                Log.d(this, "仓库内材料不足，无法出库如此多的材料");
                return 0;
            }
            // 如果出库材料出库完成为0，那么删除这一条仓库库存记录
            if (Integer.parseInt(warehouseItemInMysql.getItemCount()) == bill.getItemDealCount()) {
                int res = warehouseDao.deleteOneItemById(warehouseInMysql.getId(), itemInMysql.getId());
                if (res <= 0) {
                    Log.d(this, "出库删除仓库库存记录错误");
                    return res;
                } else {
                    Log.d(this, "出库后，仓库材料为0，清除该仓库库存记录");
                }
            }
            return billDao.save(bill);
        }
        return 0;
    }

    /**
     * 两仓调度实现
     *
     * @param bill 台账
     * @return 结果
     */
    @Override
    public int addDispatchBill(Bill bill) {
        bill.setId(IdUtils.getId());
        bill.setOperation("1");     // 出货仓库调出货物，属于贷
        bill.setIsDispatch("1");    // 属于两仓调度
        if (checkBill(bill)) {
            // 检查输入参数是否合法
            WarehouseDaoImpl warehouseDao = new WarehouseDaoImpl();
            Warehouse outWarehouseInMysql = warehouseDao.findOneById(bill.getWarehouseId());
            if (!outWarehouseInMysql.getState()) {
                Log.d(this, "出货的仓库已被删除");
                return 0;
            }
            Warehouse inWarehouseInMysql = warehouseDao.findOneById(bill.getDirectionId());
            if (!inWarehouseInMysql.getState()) {
                Log.d(this, "入库的仓库已被删除");
                return 0;
            }
            ItemDaoImpl itemDao = new ItemDaoImpl();
            Item itemInMysql = itemDao.findOneById(bill.getItemId());
            if (!itemInMysql.getState()) {
                Log.d(this, "调度的材料已被删除");
                return 0;
            }
            // 判断出库材料是否足够
            WarehouseItem warehouseItemInMysql = warehouseDao.findOneWarehouseItemByIds(bill.getWarehouseId(), bill.getItemId());
            if (warehouseItemInMysql == null || Integer.parseInt(warehouseItemInMysql.getItemCount()) < bill.getItemDealCount()) {
                Log.d(this, "仓库内材料不足，无法出库如此多的材料");
                return 0;
            }
            return billDao.save(bill);
        }
        return 0;
    }
}
