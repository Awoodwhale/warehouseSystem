package top.woodwhale.service.bill;

import top.woodwhale.pojo.Bill;

import java.util.List;

public interface IBillService {
    /**
     * 添加 进货 台账
     *
     * @param bill 台账信息
     * @return 结果
     */
    int addPurchaseBill(Bill bill);


    /**
     * 添加 出货 台账
     *
     * @param bill 台账
     * @return 结果
     */
    int addOutflowBill(Bill bill);

    /**
     * 添加 两仓调度 台账
     *
     * @param bill 台账
     * @return 结果
     */
    int addDispatchBill(Bill bill);

    /**
     * 获取所有台账信息
     *
     * @return lsit
     */
    List<Bill> listBills();
}
