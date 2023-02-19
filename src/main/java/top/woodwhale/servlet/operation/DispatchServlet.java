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

public class DispatchServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String outWarehouseId = req.getParameter("outWarehouse");
        String inWarehouseId = req.getParameter("inWarehouse");
        String itemId = req.getParameter("item");
        String itemCount = req.getParameter("itemCount");
        String time = req.getParameter("time");
        if (!TextUtils.isEmpty(outWarehouseId) &&
                !TextUtils.isEmpty(inWarehouseId) &&
                !TextUtils.isEmpty(itemId) &&
                !TextUtils.isEmpty(itemCount) &&
                !TextUtils.isEmpty(time)) {
            try {
                Date createTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
                int itemDealCount = Integer.parseInt(itemCount);
                Bill bill = new Bill();
                bill.setCreateTime(createTime);
                bill.setItemDealCount(itemDealCount);
                bill.setWarehouseId(outWarehouseId);
                bill.setDirectionId(inWarehouseId);
                bill.setItemId(itemId);
                IBillService billService = BillServiceImpl.getBillService();
                int res = billService.addDispatchBill(bill);
                req.setAttribute("msg", res > 0 ? "调度成功，请前往台账历史查看详情！" : "调度失败，该材料在出库仓库中库存不足！");
                req.setAttribute("head","调度提示");
                req.setAttribute("flag",res > 0 ? "1" : "0");
            } catch (Exception e) {
                e.printStackTrace();
                Log.d(this,"添加仓库调度记录失败");
            }
        }
        // 转发回登陆页面，写携带msg信息
        req.getRequestDispatcher("/jsp/operation/dispatch.jsp").forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
