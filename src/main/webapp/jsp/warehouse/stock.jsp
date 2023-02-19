<%@ page import="top.woodwhale.pojo.Warehouse" %>
<%@ page import="top.woodwhale.service.warehouse.IWarehouseService" %>
<%@ page import="top.woodwhale.service.warehouse.WarehouseServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="top.woodwhale.pojo.WarehouseItem" %>
<%@ page import="top.woodwhale.service.item.ItemServiceImpl" %>
<%@ page import="top.woodwhale.service.item.IItemService" %>
<%@ page import="top.woodwhale.pojo.Item" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/15
  Time: 21:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓库库存</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<%
    IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
    List<WarehouseItem> warehouseItems = warehouseService.listWarehouseItems();
    IItemService itemService = ItemServiceImpl.getItemService();
%>

<body>
<div class="warehouse-info-box">

    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">仓库库存</div>
        </div>

        <div class="layui-card-body">

            <table class="layui-table" lay-size="lg">
                <colgroup>
                    <col width="200" align="center">
                    <col align="center">
                    <col align="center">
                    <col align="center">
                    <col align="center">
                    <col align="center">
                    <col align="center">
                </colgroup>
                <thead>
                <tr>
                    <th>库存账单id</th>
                    <th>仓库公司名称</th>
                    <th>商品名称</th>
                    <th>库存数量</th>
                    <th>总价值</th>
                    <th>库存状态</th>
                    <th>仓库状态</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                </tr>
                </thead>
                <tbody>
                <%
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    for (WarehouseItem warehouseItem : warehouseItems) {
                        String warehouseId = warehouseItem.getId();
                        Warehouse warehouseInMysql = warehouseService.getWarehouseById(warehouseId);
                        Item itemInMysql = itemService.getItemById(warehouseItem.getItemId());
                        String itemCount = warehouseItem.getItemCount();
                        Date createTime = warehouseItem.getCreateTime();
                        Date updateTime = warehouseItem.getUpdateTime();
                        Double totalPrice = Integer.parseInt(itemCount) * itemInMysql.getPrice();
                        String itemName = itemInMysql.getName();
                        String warehouseName = warehouseInMysql.getName();
                        boolean flag = Integer.parseInt(itemCount) > 0;
                        String state = flag ? "非空" : "空仓";
                        String warehouseState = warehouseInMysql.getState() ? "营业中" : "已删除";
                %>
                <tr>
                    <td><%=warehouseId%>
                    </td>
                    <td><span style="cursor: pointer"
                              onclick='clickWarehouse(<%=new Gson().toJson(warehouseInMysql)%>)'><%=warehouseName%></span>
                    </td>
                    <td><span style="cursor: pointer"
                              onclick='clickItem(<%=new Gson().toJson(itemInMysql)%>)'><%=itemName%></span>
                    </td>
                    <td><span class="layui-badge layui-bg-green"><%=itemCount%></span>
                    </td>
                    <td><span class="layui-badge layui-bg-orange"><%=String.format("%.2f", totalPrice)%></span>
                    </td>
                    <td>
                        <%
                            if (flag) {
                        %>
                        <span class="layui-badge layui-bg-blue"><%=state%></span>
                        <%
                        } else {
                        %>
                        <span class="layui-badge"><%=state%></span>
                        <%
                            }
                        %>
                    </td>
                    <td>
                        <%
                            if (warehouseInMysql.getState()) {
                        %>
                        <span class="layui-badge layui-bg-black"><%=warehouseState%></span>
                        <%
                        } else {
                        %>
                        <span class="layui-badge"><%=warehouseState%></span>
                        <%
                            }
                        %>
                    </td>
                    <td><%=simpleDateFormat.format(createTime)%>
                    </td>
                    <td><%=simpleDateFormat.format(updateTime)%>
                    </td>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <div id="page"></div>

        </div>
    </div>

</div>

</body>
</html>

<style>
    .warehouse-info-box .layui-table tr {
        text-align: center !important;
    }

    .warehouse-info-box .layui-table th {
        text-align: center !important;
        font-size: 16px !important;
        font-weight: 555 !important;
    }
</style>

<script src="${pageContext.request.contextPath}/res/js/main.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    layui.use(['laypage'], () => {
        let laypage = layui.laypage
        //执行一个laypage实例
        laypage.render({
            elem: 'page',
            count: <%=warehouseItems.size()%>,
            layout: ['prev', 'page', 'next', 'count', 'refresh', 'skip'],
            limit: 10,
            jump: (obj, isFirst) => {
                // TODO: 跳转
            }
        });
    });
</script>