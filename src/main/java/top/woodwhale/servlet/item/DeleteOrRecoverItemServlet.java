package top.woodwhale.servlet.item;

import top.woodwhale.service.item.IItemService;
import top.woodwhale.service.item.ItemServiceImpl;
import top.woodwhale.utils.TextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteOrRecoverItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (!TextUtils.isEmpty(id)) {
            IItemService itemService = ItemServiceImpl.getItemService();
            int res = itemService.deleteOrRecoverItemById(id);
            req.setAttribute("msg",res > 0 ? "修改材料状态成功" : "修改材料状态失败");
            req.setAttribute("head", "材料状态");
            req.setAttribute("flag", res > 0 ? "1" : "0");
        }
        // 转发回登陆页面，写携带msg信息
        req.getRequestDispatcher("/jsp/item/info.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
