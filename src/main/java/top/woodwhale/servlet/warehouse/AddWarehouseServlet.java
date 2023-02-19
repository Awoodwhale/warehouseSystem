package top.woodwhale.servlet.warehouse;

import top.woodwhale.pojo.Warehouse;
import top.woodwhale.service.warehouse.IWarehouseService;
import top.woodwhale.service.warehouse.WarehouseServiceImpl;
import top.woodwhale.utils.IdUtils;
import top.woodwhale.utils.TextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 添加仓库的servlet
 */
public class AddWarehouseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        if (!TextUtils.isEmpty(name) && !TextUtils.isEmpty(address) && !TextUtils.isEmpty(email)) {
            Warehouse warehouse = new Warehouse();
            warehouse.setName(name);
            warehouse.setAddress(address);
            warehouse.setEmail(email);
            warehouse.setId(IdUtils.getId());
            IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
            int res = warehouseService.addWarehouse(warehouse);
            req.setAttribute("msg",res > 0 ? "添加仓库成功" : "添加仓库失败");
            req.setAttribute("head", "添加仓库");
            req.setAttribute("flag", res > 0 ? "1" : "0");
        }
        // 转发回登陆页面，写携带msg信息
        req.getRequestDispatcher("/jsp/warehouse/info.jsp").forward(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
