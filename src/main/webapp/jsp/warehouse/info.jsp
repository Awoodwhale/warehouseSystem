<%@ page import="top.woodwhale.service.warehouse.IWarehouseService" %>
<%@ page import="top.woodwhale.service.warehouse.WarehouseServiceImpl" %>
<%@ page import="top.woodwhale.pojo.Warehouse" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.Date" %>
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
    <title>仓库信息</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<%
    IWarehouseService warehouseService = WarehouseServiceImpl.getWarehouseService();
    List<Warehouse> warehouses = warehouseService.listWarehouses();
%>


<body onload="showMessage('${msg}','${head}','${flag}')">
<div class="warehouse-info-box">

    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">仓库信息</div>
        </div>

        <div class="layui-card-body">

            <div style="margin-bottom: 10px;">
                <button type="button" class="layui-btn layui-btn-warm" onclick="refreshList()">刷新列表</button>
                <button type="button" class="layui-btn" onclick="addOrEditWarehouse()">添加仓库</button>
            </div>

            <table class="layui-table" lay-size="lg">
                <colgroup>
                    <col width="200" align="center">
                    <col width="200" align="center">
                    <col align="center">
                    <col align="center">
                    <col width="150" align="center">
                    <col align="center">
                    <col align="center">
                    <col width="300" align="center">
                </colgroup>
                <thead>
                <tr>
                    <th>仓库公司ID</th>
                    <th>仓库公司名称</th>
                    <th>仓库公司地址</th>
                    <th>仓库公司邮箱</th>
                    <th>仓库状态</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <%
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    for (Warehouse warehouse : warehouses) {
                        String id = warehouse.getId();
                        String address = warehouse.getAddress();
                        String email = warehouse.getEmail();
                        String name = warehouse.getName();
                        Boolean state = warehouse.getState();
                        Date createTime = warehouse.getCreateTime();
                        Date updateTime = warehouse.getUpdateTime();
                %>
                <tr>
                    <td><%=id%>
                    </td>
                    <td><span style="cursor: pointer"
                              onclick='clickWarehouse(<%=new Gson().toJson(warehouse)%>)'><%=name%></span>
                    </td>
                    <td><%=address%>
                    </td>
                    <td><%=email%>
                    </td>

                    <%
                        if (state) {
                    %>
                    <td>
                        <span class="layui-badge layui-bg-green">营业中</span>
                    </td>
                    <%
                    } else {
                    %>
                    <td>
                        <span class="layui-badge">已删除</span>
                    </td>
                    <%
                        }
                    %>

                    <td><%=simpleDateFormat.format(createTime)%>
                    </td>
                    <td><%=simpleDateFormat.format(updateTime)%>
                    </td>
                    </td>

                    <td>
                        <%
                            if (state) {
                        %>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-blue"
                                onclick='addOrEditWarehouse("<%=id%>",<%=new Gson().toJson(warehouse)%>)'><i
                                class="layui-icon layui-icon-edit"></i>编 辑
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-red"
                                onclick="deleteOrRecoverWarehouse('<%=id%>')"><i
                                class="layui-icon layui-icon-delete"></i>删 除
                        </button>
                        <%
                        } else {

                        %>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-blue layui-btn-disabled">
                            <i class="layui-icon layui-icon-edit"></i>编 辑
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-orange"
                                onclick="deleteOrRecoverWarehouse('<%=id%>')"><i
                                class="layui-icon layui-icon-refresh-1"></i>恢 复
                        </button>
                        <%
                            }
                        %>

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

<%--仓库表单--%>
<form class="layui-form" id="warehouse-form" style="display: none" method="post">
    <div class="layui-form-item">
        <label class="layui-form-label">仓库名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" required lay-verify="required" placeholder="请输入仓库公司名称" autocomplete="off"
                   class="layui-input" id="warehouse-name" style="width:80%">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">仓库地址</label>
        <div class="layui-input-block">
            <input type="text" name="address" required lay-verify="required" placeholder="请输入仓库公司地址" autocomplete="off"
                   class="layui-input" id="warehouse-address" style="width:80%">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">仓库邮箱</label>
        <div class="layui-input-block">
            <input type="text" name="email" required lay-verify="required" placeholder="请输入仓库公司邮箱" autocomplete="off"
                   class="layui-input" id="warehouse-email" style="width:80%">
        </div>
    </div>
</form>

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
            count: <%=warehouses.size()%>,
            layout: ['prev', 'page', 'next', 'count', 'refresh', 'skip'],
            limit: 10,
            jump: (obj, isFirst) => {
                // TODO: 跳转
            }
        });
    });

    // 添加或更新仓库
    const addOrEditWarehouse = (id = undefined, warehouseObj = undefined) => {
        let op = id === undefined ? '添加' : '编辑'
        layui.use(['jquery', 'layer'], () => {
            let $ = layui.$
            const warehouseForm = $('#warehouse-form')
            let layer = layui.layer

            if (warehouseObj !== undefined) {
                $('#warehouse-name').val(warehouseObj.name)
                $('#warehouse-address').val(warehouseObj.address)
                $('#warehouse-email').val(warehouseObj.email)
            }
            let layerId = layer.open({
                area: ['30%'],
                type: 1,
                title: op + "仓库",
                content: warehouseForm,
                btn: ["提交", "重置"],
                yes: (index, layero) => {
                    let warehouseName = $('#warehouse-name').val();
                    let warehouseAddr = $('#warehouse-address').val();
                    let warehouseEmail = $('#warehouse-email').val();
                    if (warehouseName !== '' && warehouseEmail !== '' && warehouseAddr !== '') {
                        layer.confirm("您确认" + op + "该仓库吗?", {icon: 3, title: '提示'}, (index) => {
                            // 根据不同操作提交不同类型表单
                            warehouseForm.attr("action", "${pageContext.request.contextPath}/warehouse/" +
                                (id === undefined ? "addWarehouse.do" : "editWarehouse.do?id=" + id))
                            // 提交表单
                            warehouseForm.submit()
                            layer.close(index);
                        });
                    } else {
                        layer.alert('请输入该仓库的完整信息', {
                            icon: 5,
                            title: "警告"
                        })
                    }
                },
                btn2: (index, layero) => {
                    warehouseForm[0].reset();
                    return false
                },
                cancel: () => {
                    layer.close(layerId)
                }
            })
        });
    }

    // 删除或还原仓库
    const deleteOrRecoverWarehouse = (id) => {
        layer.confirm('您确认对该仓库执行操作吗?', {icon: 3, title: '提示'}, (index) => {
            window.location.href = "${pageContext.request.contextPath}/warehouse/deleteOrRecoverWarehouse.do?id=" + id
            layer.close(index);
        });
    }

</script>