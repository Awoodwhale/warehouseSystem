<%@ page import="top.woodwhale.service.warehouse.IWarehouseService" %>
<%@ page import="top.woodwhale.service.warehouse.WarehouseServiceImpl" %>
<%@ page import="top.woodwhale.service.item.IItemService" %>
<%@ page import="top.woodwhale.service.item.ItemServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="top.woodwhale.service.bill.BillServiceImpl" %>
<%@ page import="top.woodwhale.service.bill.IBillService" %>
<%@ page import="java.util.Date" %>
<%@ page import="top.woodwhale.pojo.*" %>
<%@ page import="top.woodwhale.service.supplier.SupplierServiceImpl" %>
<%@ page import="top.woodwhale.service.supplier.ISupplierService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.google.gson.Gson" %><%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/18
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>台账历史</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<%
    IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
    ISupplierService supplierService = SupplierServiceImpl.getSupplierService();
    IItemService itemService = ItemServiceImpl.getItemService();
    IBillService billService = BillServiceImpl.getBillService();
%>

<body onload="showMessage('${msg}','${head}','${flag}')">

<div class="history-box">
    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">台账历史</div>
        </div>

        <div class="layui-card-body">
            <blockquote class="layui-elem-quote layui-text">
                <span>
                    这里是台账历史的表格描述形式，若要进行仓库进货，请到
                <span class="layui-badge layui-bg-green" style="cursor: pointer"
                      onclick="documentIdClick('purchase-button')">这里</span>，
                若要进行仓库出货，请到 <span class="layui-badge layui-bg-green" style="cursor: pointer"
                                  onclick="documentIdClick('outflow-button')">这里</span>，
                若要进行仓库调拨，请到 <span class="layui-badge layui-bg-green" style="cursor: pointer"
                                  onclick="documentIdClick('dispatch-button')">这里</span>
                </span>
            </blockquote>

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
                    <th>台账id</th>
                    <th>交易仓库</th>
                    <th>交易类型</th>
                    <th>交易材料</th>
                    <th>交易数量</th>
                    <th>交易金额</th>
                    <th>是否调度</th>
                    <th>去向/来源</th>
                    <th>记录时间</th>
                </tr>
                </thead>
                <tbody>

                <%
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    List<Bill> bills = billService.listBills();
                    for (Bill bill : bills) {
                        // 辅助内容
                        String dealWarehouseId = bill.getWarehouseId();
                        Warehouse dealWarehouse = warehouseService.getWarehouseById(dealWarehouseId);
                        String operation = bill.getOperation();
                        String itemId = bill.getItemId();
                        Item dealItem = itemService.getItemById(itemId);
                        String isDispatch = bill.getIsDispatch();
                        String directionId = bill.getDirectionId();
                        // 真正填入表格的内容
                        String billId = bill.getId();
                        Date createTime = bill.getCreateTime();
                        Integer itemDealCount = bill.getItemDealCount();
                        String dealWarehouseName = dealWarehouse.getName();
                        String dealItemName = dealItem.getName();
                        String dealIsDispatch = "1".equals(isDispatch) ? "调度" : "0".equals(operation) ? "入库" : "出库";
                        // 判断是 出库 还是 入库，同时判断是否是 调度
                        String dealModel = "0".equals(operation) ? "供货商供货" : "1".equals(isDispatch) ? "两仓库调度" : "售向供货商";
                        // 去向、来源的名称
                        String fromOrToName;
                        String isFromOrTo;
                        // 材料来源的供货商
                        Supplier fromSupplier;
                        // 材料去向的供货商
                        Supplier toSupplier;
                        Warehouse toWarehouse;
                        if ("0".equals(operation)) {
                            fromSupplier = supplierService.getSupplierById(directionId);
                            fromOrToName = fromSupplier.getName();
                            isFromOrTo = "来自";
                        } else {
                            isFromOrTo = "去往";
                            if ("0".equals(isDispatch)) {
                                // 如果不是调度，那么就是有一个材料去向的供货商
                                toSupplier = supplierService.getSupplierById(directionId);
                                fromOrToName = toSupplier.getName();
                            } else {
                                // 如果是调度，那么就是一个去向仓库
                                toWarehouse = warehouseService.getWarehouseById(directionId);
                                fromOrToName = toWarehouse.getName();
                            }
                        }

                %>
                <tr>
                    <td><%=billId%>
                    </td>
                    <td><span style="cursor: pointer"
                              onclick='clickWarehouse(<%=new Gson().toJson(dealWarehouse)%>)'><%=dealWarehouseName%></span>
                    </td>
                    <td><%=dealModel%>
                    </td>
                    <td><span style="cursor: pointer"
                              onclick='clickItem(<%=new Gson().toJson(dealItem)%>)'><%=dealItemName%></span>
                    </td>
                    <td><span class="layui-badge layui-bg-orange"><%=itemDealCount%></span></td>
                    <td><span class="layui-badge"><%=String.format("%.2f", itemDealCount*dealItem.getPrice())%></span></td>
                    <td><span class="layui-badge layui-bg-blue"><%=dealIsDispatch%></span></td>
                    <td><span style="font-style: italic"><%=isFromOrTo%></span> <%=fromOrToName%>
                    </td>
                    <td><%=simpleDateFormat.format(createTime)%>
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
    .history-box .layui-table tr {
        text-align: center !important;
    }

    .history-box .layui-table th {
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
            count: <%=bills.size()%>,
            layout: ['prev', 'page', 'next', 'count', 'refresh', 'skip'],
            limit: 10,
            jump: (obj, isFirst) => {
                // TODO: 跳转
            }
        });
    });
</script>
