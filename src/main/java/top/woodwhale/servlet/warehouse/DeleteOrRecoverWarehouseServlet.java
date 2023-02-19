package top.woodwhale.servlet.warehouse;

import top.woodwhale.service.warehouse.IWarehouseService;
import top.woodwhale.service.warehouse.WarehouseServiceImpl;
import top.woodwhale.utils.TextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteOrRecoverWarehouseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 删除或者恢复仓库
        String id = req.getParameter("id");
        if (!TextUtils.isEmpty(id)) {
            IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
            int res = warehouseService.deleteOrRecoverWarehouseById(id);
            req.setAttribute("msg",res > 0 ? "修改仓库状态成功" : "修改仓库状态失败");
            req.setAttribute("head", "仓库状态");
            req.setAttribute("flag", res > 0 ? "1" : "0");
        }
        // 转发回登陆页面，写携带msg信息
        req.getRequestDispatcher("/jsp/warehouse/info.jsp").forward(req,resp);
    }
}
