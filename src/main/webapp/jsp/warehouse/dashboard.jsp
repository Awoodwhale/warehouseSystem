<%@ page import="top.woodwhale.service.warehouse.IWarehouseService" %>
<%@ page import="top.woodwhale.service.warehouse.WarehouseServiceImpl" %>
<%@ page import="top.woodwhale.pojo.Warehouse" %>
<%@ page import="java.util.List" %>
<%@ page import="top.woodwhale.service.item.IItemService" %>
<%@ page import="top.woodwhale.service.item.ItemServiceImpl" %>
<%@ page import="top.woodwhale.pojo.Item" %>
<%@ page import="top.woodwhale.service.supplier.ISupplierService" %>
<%@ page import="top.woodwhale.service.supplier.SupplierServiceImpl" %>
<%@ page import="top.woodwhale.pojo.Supplier" %>
<%@ page import="top.woodwhale.service.bill.IBillService" %>
<%@ page import="top.woodwhale.service.bill.BillServiceImpl" %>
<%@ page import="top.woodwhale.pojo.Bill" %><%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/15
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仪表盘</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/css/bootstrap3.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>
<body>

<%
    // 仓库服务层
    IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
    List<Warehouse> warehouses = warehouseService.listWarehouses();
    // 材料服务层
    IItemService itemService = ItemServiceImpl.getItemService();
    List<Item> items = itemService.listItems();
    // 供货商服务层
    ISupplierService supplierService = SupplierServiceImpl.getSupplierService();
    List<Supplier> suppliers = supplierService.listSuppliers();
    // 台账服务层
    IBillService billService = BillServiceImpl.getBillService();
    List<Bill> bills = billService.listBills();
%>

<div class="dashboard-box">
    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">仪表盘</div>
        </div>

        <div class="layui-card-body">
            <div class="layui-row space80">

                <div class="layui-col-md6">
                    <div class="modal-dialog" style="width:100%;margin: 20px auto auto;text-align: center">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title text-center">仓库信息</h3>
                            </div>
                            <div class="modal-body" style="padding: 40px !important;">
                                <div class="text-center" style="font-size: 20px;">
                                    仓库数量 : <span style="font-weight: 555;"><%=warehouses.size()%></span> 个
                                </div>
                            </div>
                            <div class="modal-footer" style="text-align: center !important;">
                                <button type="button" class="layui-btn"
                                        onclick="documentIdClick('warehouse-info-button')">仓库信息
                                </button>
                                <button type="button" class="layui-btn"
                                        onclick="documentIdClick('warehouse-item-info-button')">仓库库存
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-col-md6">
                    <div class="modal-dialog" style="width:100%;margin: 20px auto auto;text-align: center">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title text-center">台账信息</h3>
                            </div>
                            <div class="modal-body" style="padding: 40px !important;">
                                <div class="text-center" style="font-size: 20px;">
                                    历史台账 : <span style="font-weight: 555;"><%=bills.size()%></span> 条
                                </div>
                            </div>
                            <div class="modal-footer" style="text-align: center !important;">
                                <button type="button" class="layui-btn"
                                        onclick="documentIdClick('history-button')">查看详情
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="layui-row space80">

                <div class="layui-col-md6">
                    <div class="modal-dialog" style="width:100%;margin: 20px auto auto;text-align: center">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title text-center">材料信息</h3>
                            </div>
                            <div class="modal-body" style="padding: 40px !important;">
                                <div class="text-center" style="font-size: 20px;">
                                    材料种类: <span style="font-weight: 555;"><%=items.size()%></span> 种
                                </div>
                            </div>
                            <div class="modal-footer" style="text-align: center !important;">
                                <button type="button" class="layui-btn"
                                        onclick="documentIdClick('item-info-button')">查看详情
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-col-md6">
                    <div class="modal-dialog" style="width:100%;margin: 20px auto auto;text-align: center">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title text-center">供货商信息</h3>
                            </div>
                            <div class="modal-body" style="padding: 40px !important;">
                                <div class="text-center" style="font-size: 20px;">
                                    供货商数量 : <span style="font-weight: 555;"><%=suppliers.size()%></span> 条
                                </div>
                            </div>
                            <div class="modal-footer" style="text-align: center !important;">
                                <button type="button" class="layui-btn"
                                        onclick="documentIdClick('supplier-info-button')">查看详情
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
    <div>

    </div>

</div>

</body>
</html>

<style>
    .dashboard-box .modal-content {
        box-shadow: 0 1px 5px rgb(0 0 0 / 50%);
        border: none;
    }

    .space80 {
        display: flex;
        margin-top: 20px;
        margin-bottom: 20px;
    }

    .space80 .layui-col-md6 {
        margin: auto;
        max-width: 1000px;
        min-width: 300px;
        width: 500px;
    }
</style>

<script src="${pageContext.request.contextPath}/res/js/main.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
