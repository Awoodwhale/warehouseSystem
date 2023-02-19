<%@ page import="top.woodwhale.pojo.Warehouse" %>
<%@ page import="top.woodwhale.service.warehouse.IWarehouseService" %>
<%@ page import="top.woodwhale.service.warehouse.WarehouseServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="top.woodwhale.service.supplier.ISupplierService" %>
<%@ page import="top.woodwhale.service.supplier.SupplierServiceImpl" %>
<%@ page import="top.woodwhale.service.item.IItemService" %>
<%@ page import="top.woodwhale.service.item.ItemServiceImpl" %>
<%@ page import="top.woodwhale.pojo.Item" %>
<%@ page import="top.woodwhale.pojo.Supplier" %>
<%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/18
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>两仓调度</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<%
    IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
    List<Warehouse> warehouses = warehouseService.listWarehouses();
    IItemService itemService = ItemServiceImpl.getItemService();
    List<Item> items = itemService.listItems();
%>

<body onload="showMessage('${msg}','${head}','${flag}')">

<div class="dispatch-box">
    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">仓库出货</div>
        </div>

        <div class="layui-card-body">
            <blockquote class="layui-elem-quote layui-text">
                这里是两个仓库货物调拨的操作，若要处理仓库进货，请到
                <span class="layui-badge layui-bg-green" style="cursor: pointer"
                      onclick="documentIdClick('purchase-button')">这里</span>
                ，若要处理仓库出货，请到
                <span class="layui-badge layui-bg-green" style="cursor: pointer"
                      onclick="documentIdClick('outflow-button')">这里</span>
            </blockquote>

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>两仓调拨表单</legend>
            </fieldset>

            <%--仓库进货的表单--%>
            <form class="layui-form layui-form-pane" id="dispatch-form" method="post">

                <div class="layui-form-item">
                    <label class="layui-form-label">出库仓库</label>
                    <div class="layui-input-block">
                        <select name="outWarehouse" lay-search lay-verify="" id="dispatch-out-warehouse"
                                lay-filter="out-warehouse">
                            <option value="" selected>请选择需要调出材料的仓库</option>
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
                    <label class="layui-form-label">入库仓库</label>
                    <div class="layui-input-block">
                        <select name="inWarehouse" lay-search lay-verify="" id="dispatch-in-warehouse"
                                lay-filter="in-warehouse">
                            <option value="" selected>请选择需要接收材料的仓库</option>
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
                        <select name="item" lay-search lay-verify="" id="dispatch-item">
                            <option value="">请选择调拨的材料种类</option>
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
                    <label class="layui-form-label">调度数量</label>
                    <div class="layui-input-block">
                        <input type="number" name="itemCount" autocomplete="off" placeholder="请输入两仓调度的材料数量"
                               class="layui-input" id="dispatch-itemCount">
                    </div>
                </div>


                <div class="layui-form-item" style="display: flex">
                    <div class="layui-inline" style="margin-top: auto;margin-bottom: auto">
                        <label class="layui-form-label">调度时间</label>
                        <div class="layui-input-inline">
                            <input name="time" readonly type="text" class="layui-input" id="dispatch-datatime" autocomplete="off"
                                   placeholder="yyyy-MM-dd HH:mm:ss">
                        </div>
                    </div>
                    <blockquote class="layui-elem-quote layui-text"
                                style="margin-bottom: 0 !important;flex: 1;height: 10px">
                        <span style="font-style: italic;width: 100%;line-height: 10px;">该调度时间会写入台账中</span>
                    </blockquote>
                </div>

            </form>

            <div style="margin-bottom: 10px;margin-top: 10px">
                <button type="button" class="layui-btn" onclick="doDispatch()" style="margin-right: 20px;">提交表单</button>
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
    //日期时间选择器
    layui.laydate.render({
        elem: '#dispatch-datatime'
        , type: 'datetime'
    });

    // jquery
    let $ = layui.$
    // 表单
    const dispatchForm = $('#dispatch-form')
    // 出货仓库select
    const outWarehouseSelect = $('#dispatch-out-warehouse')
    // 入库仓库select
    const inWarehouseSelect = $('#dispatch-in-warehouse')

    // 被选中的仓库id
    let selectId = -1
    // 出库仓库监听，确保不会选择出库和入库相同
    layui.form.on('select(out-warehouse)', (data) => {
        // 出库一旦重新选择，那么入库仓库也要做出改变，判断是否是选了一样的仓库
        if (outWarehouseSelect.val() === inWarehouseSelect.val()) {
            inWarehouseSelect.val('')
        }
        // 如果当前的选中id改变了，那么就给他解除ban
        if (selectId !== -1 && outWarehouseSelect.val() !== selectId) {
            $("#dispatch-in-warehouse option[value='" + selectId + "']").removeAttr("disabled")
        }
        // ban了当前被选中的仓库
        selectId = outWarehouseSelect.val()
        $("#dispatch-in-warehouse option[value='" + selectId + "']").attr("disabled", "disabled")
        layui.form.render("select")
    })

    // 处理调度
    const doDispatch = () => {
        let outWarehouseId = $('#dispatch-out-warehouse').val()
        let inWarehouseId = $('#dispatch-in-warehouse').val()
        let itemCount = $('#dispatch-itemCount').val()
        let itemId = $('#dispatch-item').val()
        let time = $('#dispatch-datatime').val()

        if (outWarehouseId !== '' && inWarehouseId !== '' && time !== '' && itemCount !== '' && itemId !== '' && isDouble(itemCount)) {
            layer.confirm("您确认提交该仓库调度表单吗?", {icon: 3, title: '提示'}, (index) => {
                dispatchForm.attr("action", "${pageContext.request.contextPath}/operation/dispatch.do")
                // 提交表单
                dispatchForm.submit()
            });
        } else {
            layer.alert('请输入完整且正确的仓库调度表单信息', {
                icon: 5,
                title: "警告"
            })
        }
    }

    // 重置表单
    const resetForm = () => {
        dispatchForm[0].reset()
    }
</script>
