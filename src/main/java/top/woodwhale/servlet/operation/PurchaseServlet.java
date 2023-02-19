package top.woodwhale.servlet.operation;

import top.woodwhale.pojo.Bill;
import top.woodwhale.service.bill.BillServiceImpl;
import top.woodwhale.service.bill.IBillService;
import top.woodwhale.utils.Log;
import top.woodwhale.utils.TextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PurchaseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String warehouseId = req.getParameter("warehouse");
        String itemId = req.getParameter("item");
        String supplierId = req.getParameter("supplier");
        String itemCount = req.getParameter("itemCount");
        String time = req.getParameter("time");
        if (!TextUtils.isEmpty(warehouseId) &&
                !TextUtils.isEmpty(itemId) &&
                !TextUtils.isEmpty(supplierId) &&
                !TextUtils.isEmpty(itemCount) &&
                !TextUtils.isEmpty(time)) {
            try {
                Date createTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
                int itemDealCount = Integer.parseInt(itemCount);
                Bill bill = new Bill();
                bill.setCreateTime(createTime);
                bill.setWarehouseId(warehouseId);
                bill.setItemId(itemId);
                bill.setItemDealCount(itemDealCount);
                bill.setDirectionId(supplierId);    // 货物来源
                IBillService billService = BillServiceImpl.getBillService();
                int res = billService.addPurchaseBill(bill);
                req.setAttribute("msg", res > 0 ? "进货成功，请前往台账历史查看详情！" : "进货失败，请重试！");
                req.setAttribute("head","进货提示");
                req.setAttribute("flag",res > 0 ? "1" : "0");
            } catch (Exception e) {
                e.printStackTrace();
                Log.d(this, "添加仓库进货记录失败");
            }
        }
        // 转发回登陆页面，写携带msg信息
        req.getRequestDispatcher("/jsp/operation/purchase.jsp").forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
