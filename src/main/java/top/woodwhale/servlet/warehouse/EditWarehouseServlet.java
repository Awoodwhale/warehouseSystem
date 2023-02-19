package top.woodwhale.servlet.warehouse;

import top.woodwhale.pojo.Warehouse;
import top.woodwhale.service.warehouse.IWarehouseService;
import top.woodwhale.service.warehouse.WarehouseServiceImpl;
import top.woodwhale.utils.TextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EditWarehouseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        if (!TextUtils.isEmpty(name) && !TextUtils.isEmpty(address) && !TextUtils.isEmpty(email)) {
            Warehouse warehouse = new Warehouse();
            warehouse.setName(name);
            warehouse.setAddress(address);
            warehouse.setEmail(email);
            warehouse.setId(id);
            IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
            int res = warehouseService.editWarehouseById(id, warehouse);
            req.setAttribute("msg",res > 0 ? "更新仓库成功" : "更新仓库失败");
            req.setAttribute("head", "更新仓库");
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
