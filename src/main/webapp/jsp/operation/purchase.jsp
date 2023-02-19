<%@ page import="top.woodwhale.service.warehouse.WarehouseServiceImpl" %>
<%@ page import="top.woodwhale.service.warehouse.IWarehouseService" %>
<%@ page import="top.woodwhale.pojo.Warehouse" %>
<%@ page import="java.util.List" %>
<%@ page import="top.woodwhale.service.supplier.SupplierServiceImpl" %>
<%@ page import="top.woodwhale.service.supplier.ISupplierService" %>
<%@ page import="top.woodwhale.pojo.Supplier" %>
<%@ page import="top.woodwhale.service.item.ItemServiceImpl" %>
<%@ page import="top.woodwhale.service.item.IItemService" %>
<%@ page import="top.woodwhale.pojo.Item" %><%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/18
  Time: 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓库进货</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<body onload="showMessage('${msg}','${head}','${flag}')">

<%
    IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
    List<Warehouse> warehouses = warehouseService.listWarehouses();
    ISupplierService supplierService = SupplierServiceImpl.getSupplierService();
    List<Supplier> suppliers = supplierService.listSuppliers();
    IItemService itemService = ItemServiceImpl.getItemService();
    List<Item> items = itemService.listItems();
%>

<div class="purchase-box">

    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">仓库进货</div>
        </div>

        <div class="layui-card-body">

            <blockquote class="layui-elem-quote layui-text">
                这里是仓库从供货商手中进货的操作，若要处理两仓调度，请到
                <span class="layui-badge layui-bg-green" style="cursor: pointer"
                      onclick="documentIdClick('dispatch-button')">这里</span>
            </blockquote>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>仓库进货表单</legend>
            </fieldset>

            <%--仓库进货的表单--%>
            <form class="layui-form layui-form-pane" id="purchase-form" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">仓库选择</label>
                    <div class="layui-input-block">
                        <select name="warehouse" lay-search lay-verify="" id="purchase-warehouse">
                            <option value="">请选择需要进货的仓库</option>
                            <%
                                for (Warehouse warehouse : warehouses) {
                                    // 被删除的不显示
                                    if (!warehouse.getState()) {
                                        continue;
                                    }
                                    String id = warehouse.getId();
                                    String name = warehouse.getName();
                            %>
                            <option value="<%=id%>"><%=name%>
                            </option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">材料选择</label>
                    <div class="layui-input-block">
                        <select name="item" lay-search lay-verify="" id="purchase-item">
                            <option value="">请选择材料种类</option>
                            <%
                                for (Item item : items) {
                                    // 被删除的不显示
                                    if (!item.getState()) {
                                        continue;
                                    }
                                    String id = item.getId();
                                    String name = item.getName();
                            %>
                            <option value="<%=id%>"><%=name%>
                            </option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>


                <div class="layui-form-item">
                    <label class="layui-form-label">供货商选择</label>
                    <div class="layui-input-block">
                        <select name="supplier" lay-search lay-verify="" id="purchase-supplier">
                            <option value="">请选择提供材料的供货商</option>
                            <%
                                for (Supplier supplier : suppliers) {
                                    // 被删除的不显示
                                    if (!supplier.getState()) {
                                        continue;
                                    }
                                    String id = supplier.getId();
                                    String name = supplier.getName();
                            %>
                            <option value="<%=id%>"><%=name%>
                            </option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">进货数量</label>
                    <div class="layui-input-block">
                        <input type="number" name="itemCount" autocomplete="off" placeholder="请输入进货的材料数量"
                               class="layui-input" id="purchase-itemCount">
                    </div>
                </div>


                <div class="layui-form-item" style="display: flex">
                    <div class="layui-inline" style="margin-top: auto;margin-bottom: auto">
                        <label class="layui-form-label">进货时间</label>
                        <div class="layui-input-inline">
                            <input name="time" readonly type="text" class="layui-input" id="purchase-datatime" autocomplete="off"
                                   placeholder="yyyy-MM-dd HH:mm:ss">
                        </div>
                    </div>
                    <blockquote class="layui-elem-quote layui-text"
                                style="margin-bottom: 0 !important;flex: 1;height: 10px">
                        <span style="font-style: italic;width: 100%;line-height: 10px;">该进货时间会写入台账中</span>
                    </blockquote>
                </div>

            </form>


            <div style="margin-bottom: 10px;margin-top: 10px">
                <button type="button" class="layui-btn" onclick="doPurchase()" style="margin-right: 20px;">提交表单</button>
                <button type="button" class="layui-btn layui-btn-warm" onclick="resetForm()">重置表单</button>
            </div>

        </div>
    </div>
</div>


</body>
</html>

<script src="${pageContext.request.contextPath}/res/js/main.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>

    // jquery
    let $ = layui.$
    // 表单
    const purchaseForm = $('#purchase-form')

    //日期时间选择器
    layui.laydate.render({
        elem: '#purchase-datatime'
        , type: 'datetime'
    });

    // 重置表单
    const resetForm = () => {
        purchaseForm[0].reset()
    }

    // 进货表单提交
    const doPurchase = () => {
        let warehouse = $('#purchase-warehouse').val()
        let item = $('#purchase-item').val()
        let time = $('#purchase-datatime').val()
        let itemCount = $('#purchase-itemCount').val()
        let supplier = $('#purchase-supplier').val()
        if (warehouse !== '' && item !== '' && time !== '' && itemCount !== '' && supplier !== '' && isDouble(itemCount)) {
            layer.confirm("您确认提交该仓库进货表单吗?", {icon: 3, title: '提示'}, (index) => {
                purchaseForm.attr("action", "${pageContext.request.contextPath}/operation/purchase.do")
                // 提交表单
                purchaseForm.submit()
            });
        } else {
            layer.alert('请输入完整且正确的进货表单信息', {
                icon: 5,
                title: "警告"
            })
        }
    }

</script>