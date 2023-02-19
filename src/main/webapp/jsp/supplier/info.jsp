<%@ page import="top.woodwhale.service.supplier.SupplierServiceImpl" %>
<%@ page import="top.woodwhale.service.supplier.ISupplierService" %>
<%@ page import="top.woodwhale.pojo.Supplier" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/16
  Time: 22:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>供货商信息</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<%
    ISupplierService supplierService = SupplierServiceImpl.getSupplierService();
    List<Supplier> suppliers = supplierService.listSuppliers();
%>

<body onload="showMessage('${msg}','${head}','${flag}')">
<div class="supplier-box">

    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">供货商信息</div>
        </div>

        <div class="layui-card-body">

            <div style="margin-bottom: 10px;">
                <button type="button" class="layui-btn layui-btn-warm" onclick="refreshList()">刷新列表</button>
                <button type="button" class="layui-btn" onclick="addOrEditSupplier()">添加供货商</button>
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
                    <th>供货商ID</th>
                    <th>供货商名称</th>
                    <th>供货商地址</th>
                    <th>供货商邮箱</th>
                    <th>供货商状态</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <%
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    for (Supplier supplier : suppliers) {
                        String id = supplier.getId();
                        String email = supplier.getEmail();
                        String name = supplier.getName();
                        Boolean state = supplier.getState();
                        String address = supplier.getAddress();
                        Date createTime = supplier.getCreateTime();
                        Date updateTime = supplier.getUpdateTime();
                %>
                <tr>
                    <td><%=id%>
                    </td>
                    <td><span style="cursor: pointer"
                              onclick='clickSupplier(<%=new Gson().toJson(supplier)%>)'><%=name%></span>
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
                                onclick='addOrEditSupplier("<%=id%>",<%=new Gson().toJson(supplier)%>)'><i
                                class="layui-icon layui-icon-edit"></i>编 辑
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-red"
                                onclick="deleteOrRecoverSupplier('<%=id%>')"><i
                                class="layui-icon layui-icon-delete"></i>删 除
                        </button>
                        <%
                        } else {

                        %>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-blue layui-btn-disabled">
                            <i class="layui-icon layui-icon-edit"></i>编 辑
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-orange"
                                onclick="deleteOrRecoverSupplier('<%=id%>')"><i
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

<%--供应商表单--%>
<form class="layui-form" id="supplier-form" style="display: none" method="post">
    <div class="layui-form-item">
        <label class="layui-form-label">供货商名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" required lay-verify="required" placeholder="请输入供货商名称" autocomplete="off"
                   class="layui-input" id="supplier-name" style="width:80%">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">供货商地址</label>
        <div class="layui-input-block">
            <input type="text" name="address" required lay-verify="required" placeholder="请输入供货商地址" autocomplete="off"
                   class="layui-input" id="supplier-address" style="width:80%">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">供货商邮箱</label>
        <div class="layui-input-block">
            <input type="text" name="email" required lay-verify="required" placeholder="请输入供货商邮箱" autocomplete="off"
                   class="layui-input" id="supplier-email" style="width:80%">
        </div>
    </div>
</form>

</body>
</html>

<style>
    .supplier-box .layui-table tr {
        text-align: center !important;
    }

    .supplier-box .layui-table th {
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
            count: <%=suppliers.size()%>,
            layout: ['prev', 'page', 'next', 'count', 'refresh', 'skip'],
            limit: 10,
            jump: (obj, isFirst) => {
                // TODO: 跳转
            }
        });
    });

    // 添加、编辑供货商
    const addOrEditSupplier = (id = undefined, supplierObj = undefined) => {
        let op = id === undefined ? '添加' : '编辑'
        layui.use(['jquery', 'layer'], () => {
            let $ = layui.$
            const supplierForm = $('#supplier-form')
            let layer = layui.layer

            if (supplierObj !== undefined) {
                $('#supplier-name').val(supplierObj.name)
                $('#supplier-address').val(supplierObj.address)
                $('#supplier-email').val(supplierObj.email)
            }

            let layerId = layer.open({
                area: ['30%'],
                type: 1,
                title: op + "供货商",
                content: supplierForm,
                btn: ["提交", "重置"],
                yes: (index, layero) => {
                    let supplierName = $('#supplier-name').val();
                    let supplierAddr = $('#supplier-address').val();
                    let supplierEmail = $('#supplier-email').val();
                    if (supplierName !== '' && supplierEmail !== '' && supplierAddr !== '') {
                        layer.confirm("您确认" + op + "该供货商吗?", {icon: 3, title: '提示'}, (index) => {
                            // 根据不同操作提交不同类型表单
                            supplierForm.attr("action", "${pageContext.request.contextPath}/supplier/" +
                                (id === undefined ? "addSupplier.do" : "editSupplier.do?id=" + id))
                            // 提交表单
                            supplierForm.submit()
                            layer.close(index);
                        });
                    } else {
                        layer.alert('请输入该供货商的完整信息', {
                            icon: 5,
                            title: "警告"
                        })
                    }
                },
                btn2: (index, layero) => {
                    supplierForm[0].reset();
                    return false
                },
                cancel: () => {
                    layer.close(layerId)
                }
            })
        });
    }

    // 删除、恢复供货商
    const deleteOrRecoverSupplier = (id) => {
        layer.confirm('您确认对该供货商执行操作吗?', {icon: 3, title: '提示'}, (index) => {
            window.location.href = "${pageContext.request.contextPath}/supplier/deleteOrRecoverSupplier.do?id=" + id
            layer.close(index);
        });
    }
</script>