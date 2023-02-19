<%@ page import="top.woodwhale.pojo.Warehouse" %>
<%@ page import="top.woodwhale.pojo.Item" %>
<%@ page import="top.woodwhale.service.warehouse.IWarehouseService" %>
<%@ page import="top.woodwhale.service.warehouse.WarehouseServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="top.woodwhale.service.supplier.ISupplierService" %>
<%@ page import="top.woodwhale.service.supplier.SupplierServiceImpl" %>
<%@ page import="top.woodwhale.service.item.IItemService" %>
<%@ page import="top.woodwhale.service.item.ItemServiceImpl" %>
<%@ page import="top.woodwhale.pojo.Supplier" %><%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/18
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓库出货</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<%
    IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
    List<Warehouse> warehouses = warehouseService.listWarehouses();
    ISupplierService supplierService = SupplierServiceImpl.getSupplierService();
    List<Supplier> suppliers = supplierService.listSuppliers();
    IItemService itemService = ItemServiceImpl.getItemService();
    List<Item> items = itemService.listItems();
%>

<body onload="showMessage('${msg}','${head}','${flag}')">

<div class="outflow-box">
    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">仓库出货</div>
        </div>

        <div class="layui-card-body">
            <blockquote class="layui-elem-quote layui-text">
                这里是仓库卖给供货商进行出货的操作，若要处理两仓调度，请到
                <span class="layui-badge layui-bg-green" style="cursor: pointer"
                      onclick="documentIdClick('dispatch-button')">这里</span>
            </blockquote>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>仓库出货表单</legend>
            </fieldset>

            <%--仓库进货的表单--%>
            <form class="layui-form layui-form-pane" id="outflow-form" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">仓库选择</label>
                    <div class="layui-input-block">
                        <select name="warehouse" lay-search lay-verify="" id="outflow-warehouse">
                            <option value="">请选择需要出货的仓库</option>
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
                        <select name="item" lay-search lay-verify="" id="outflow-item">
                            <option value="">请选择出货材料</option>
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
                        <select name="supplier" lay-search lay-verify="" id="outflow-supplier">
                            <option value="">请选择材料给向的供货商</option>
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
                    <label class="layui-form-label">出货数量</label>
                    <div class="layui-input-block">
                        <input type="number" name="itemCount" autocomplete="off" placeholder="请输入出货的材料数量"
                               class="layui-input" id="outflow-itemCount">
                    </div>
                </div>


                <div class="layui-form-item" style="display: flex">
                    <div class="layui-inline" style="margin-top: auto;margin-bottom: auto">
                        <label class="layui-form-label">出货时间</label>
                        <div class="layui-input-inline">
                            <input name="time" readonly type="text" class="layui-input" id="outflow-datatime" autocomplete="off"
                                   placeholder="yyyy-MM-dd HH:mm:ss">
                        </div>
                    </div>
                    <blockquote class="layui-elem-quote layui-text"
                                style="margin-bottom: 0 !important;flex: 1;height: 10px">
                        <span style="font-style: italic;width: 100%;line-height: 10px;">该出货时间会写入台账中</span>
                    </blockquote>
                </div>

            </form>


            <div style="margin-bottom: 10px;margin-top: 10px">
                <button type="button" class="layui-btn" onclick="doOutflow()" style="margin-right: 20px;">提交表单</button>
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
    const outflowForm = $('#outflow-form')

    //日期时间选择器
    layui.laydate.render({
        elem: '#outflow-datatime'
        , type: 'datetime'
    });

    // 重置表单
    const resetForm = () => {
        outflowForm[0].reset()
    }

    const doOutflow = () => {
        let warehouse = $('#outflow-warehouse').val()
        let item = $('#outflow-item').val()
        let time = $('#outflow-datatime').val()
        let itemCount = $('#outflow-itemCount').val()
        let supplier = $('#outflow-supplier').val()
        if (warehouse !== '' && item !== '' && time !== '' && itemCount !== '' && supplier !== '' && isDouble(itemCount)) {
            layer.confirm("您确认提交该仓库出货表单吗?", {icon: 3, title: '提示'}, (index) => {
                outflowForm.attr("action", "${pageContext.request.contextPath}/operation/outflow.do")
                // 提交表单
                outflowForm.submit()
            });
        } else {
            layer.alert('请输入完整且正确的出货表单信息', {
                icon: 5,
                title: "警告"
            })
        }
    }
</script>
