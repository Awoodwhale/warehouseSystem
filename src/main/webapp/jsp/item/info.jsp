<%@ page import="top.woodwhale.service.item.ItemServiceImpl" %>
<%@ page import="top.woodwhale.service.item.IItemService" %>
<%@ page import="top.woodwhale.pojo.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 木鲸
  Date: 2022/5/17
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>材料信息</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
</head>

<%
    IItemService itemService = ItemServiceImpl.getItemService();
    List<Item> items = itemService.listItems();
%>

<body onload="showMessage('${msg}','${head}','${flag}')">

<div class="item-box">

    <div class="layui-card">
        <div class="layui-card-header" style="height: 60px !important;border-bottom: 2px solid #f2f2f2">
            <div style="line-height:60px;font-size: 30px;font-weight: 600; text-align: center">材料信息</div>
        </div>

        <div class="layui-card-body">

            <div style="margin-bottom: 10px;">
                <button type="button" class="layui-btn layui-btn-warm" onclick="refreshList()">刷新列表</button>
                <button type="button" class="layui-btn" onclick="addOrEditItem()">添加材料</button>
            </div>

            <table class="layui-table" lay-size="lg">
                <colgroup>
                    <col width="200" align="center">
                    <col align="center">
                    <col align="center">
                    <col align="center">
                    <col align="center">
                    <col width="300" align="center">
                </colgroup>
                <thead>
                <tr>
                    <th>材料ID</th>
                    <th>材料名称</th>
                    <th>材料单价</th>
                    <th>材料状态</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Item item : items) {
                        String id = item.getId();
                        Double price = item.getPrice();
                        Boolean state = item.getState();
                        String name = item.getName();
                        Date createTime = item.getCreateTime();
                        Date updateTime = item.getUpdateTime();
                %>
                <tr>
                    <td><%=id%>
                    </td>
                    <td><span style="cursor: pointer"
                              onclick='clickItem(<%=new Gson().toJson(item)%>)'><%=name%></span>
                    </td>
                    <td><%=price%>
                    </td>
                    <%
                        if (state) {
                    %>
                    <td>
                        <span class="layui-badge layui-bg-green">供货中</span>
                    </td>
                    <%
                    } else {
                    %>
                    <td>
                        <span class="layui-badge">已下架</span>
                    </td>
                    <%
                        }
                        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    %>
                    <td><%=simpleDateFormat.format(createTime)%>
                    </td>
                    <td><%=simpleDateFormat.format(updateTime)%>
                    </td>
                    <td>
                        <%
                            if (state) {
                        %>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-blue"
                                onclick='addOrEditItem("<%=id%>",<%=new Gson().toJson(item)%>)'><i
                                class="layui-icon layui-icon-edit"></i>编 辑
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-red"
                                onclick="deleteOrRecoverItem('<%=id%>')"><i
                                class="layui-icon layui-icon-delete"></i>删 除
                        </button>
                        <%
                        } else {

                        %>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-blue layui-btn-disabled">
                            <i class="layui-icon layui-icon-edit"></i>编 辑
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-border-orange"
                                onclick="deleteOrRecoverItem('<%=id%>')"><i
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

<%--材料表单--%>
<form class="layui-form" id="item-form" style="display: none" method="post">
    <div class="layui-form-item">
        <label class="layui-form-label">材料名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" required lay-verify="required" placeholder="请输入材料名称" autocomplete="off"
                   class="layui-input" id="item-name" style="width:80%">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">材料价格</label>
        <div class="layui-input-block">
            <input type="text" name="price" required lay-verify="required" placeholder="请输入材料价格" autocomplete="off"
                   class="layui-input" id="item-price" style="width:80%">
        </div>
    </div>
</form>

</body>
</html>

<style>
    .item-box .layui-table tr {
        text-align: center !important;
    }

    .item-box .layui-table th {
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
            count: <%=items.size()%>,
            layout: ['prev', 'page', 'next', 'count', 'refresh', 'skip'],
            limit: 10,
            jump: (obj, isFirst) => {
                // TODO: 跳转
            }
        });
    });

    const addOrEditItem = (id = undefined, itemObj = undefined) => {
        let op = id === undefined ? '添加' : '编辑'
        layui.use(['jquery', 'layer'], () => {
            let $ = layui.$
            const itemForm = $('#item-form')
            let layer = layui.layer
            if (itemObj !== undefined) {
                $('#item-name').val(itemObj.name)
                $('#item-price').val(itemObj.price)
            }
            let layerId = layer.open({
                area: ['30%'],
                type: 1,
                title: op + "材料",
                content: itemForm,
                btn: ["提交", "重置"],
                yes: (index, layero) => {
                    let itemName = $('#item-name').val()
                    let itemPrice = $('#item-price').val()
                    if (itemName !== '' && itemPrice !== '' && isDouble(itemPrice)) {
                        layer.confirm("您确认" + op + "该材料吗?", {icon: 3, title: '提示'}, (index) => {
                            // 根据不同操作提交不同类型表单
                            itemForm.attr("action", "${pageContext.request.contextPath}/item/" +
                                (id === undefined ? "addItem.do" : "editItem.do?id=" + id))
                            // 提交表单
                            itemForm.submit()
                            layer.close(index);
                        });
                    } else {
                        layer.alert(isDouble(itemPrice) ? '请输入该材料的完整信息' : '请输入正确的材料价格,两位浮点数或整数', {
                            icon: 5,
                            title: "警告"
                        })
                    }
                },
                btn2: (index, layero) => {
                    itemForm[0].reset()
                    return false
                },
                cancel: () => {
                    layer.close(layerId)
                }
            })
        })
    }

    // 删除、恢复材料
    const deleteOrRecoverItem = (id) => {
        layer.confirm('您确认对该材料执行操作吗?', {icon: 3, title: '提示'}, (index) => {
            window.location.href = "${pageContext.request.contextPath}/item/deleteOrRecoverItem.do?id=" + id
            layer.close(index);
        });
    }
</script>
