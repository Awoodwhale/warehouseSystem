package top.woodwhale.servlet.supplier;

import top.woodwhale.service.supplier.ISupplierService;
import top.woodwhale.service.supplier.SupplierServiceImpl;
import top.woodwhale.utils.TextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteOrRecoverSupplierServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (!TextUtils.isEmpty(id)) {
            // 删除或者恢复供货商
            ISupplierService supplierService = SupplierServiceImpl.getSupplierService();
            int res = supplierService.deleteOrRecoverSupplier(id);
            req.setAttribute("msg",res > 0 ? "修改供货商状态成功" : "修改供货商状态失败");
            req.setAttribute("head", "供货商状态");
            req.setAttribute("flag", res > 0 ? "1" : "0");
        }
        // 转发回登陆页面，写携带msg信息
        req.getRequestDispatcher("/jsp/supplier/info.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
