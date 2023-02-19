package top.woodwhale.servlet.item;

import top.woodwhale.pojo.Item;
import top.woodwhale.service.item.IItemService;
import top.woodwhale.service.item.ItemServiceImpl;
import top.woodwhale.utils.TextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        Double price = null;
        try {
            price = Double.parseDouble(req.getParameter("price"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            // 返回页面
            resp.sendRedirect(req.getContextPath() + "/jsp/item/info.jsp");
            return;
        }
        if (!TextUtils.isEmpty(name) && price >= 0) {
            Item item = new Item();
            item.setPrice(price);
            item.setName(name);
            IItemService itemService = ItemServiceImpl.getItemService();
            int res = itemService.addItem(item);
            req.setAttribute("msg",res > 0 ? "添加材料成功" : "添加材料失败");
            req.setAttribute("head", "添加材料");
            req.setAttribute("flag", res > 0 ? "1" : "0");
        }
        // 转发回登陆页面，写携带msg信息
        req.getRequestDispatcher("/jsp/item/info.jsp").forward(req,resp);
    }
}
