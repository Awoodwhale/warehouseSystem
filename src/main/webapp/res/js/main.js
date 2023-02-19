// iframe跳转页面
const jump2Page = (url) => {
    let iframe = (document.getElementById("mainContent") === undefined ||
        document.getElementById("mainContent") === null) ?
        parent.document.getElementById("mainContent") : document.getElementById("mainContent")
    iframe.src = url
}
// 左侧操作栏模拟点击事件
const documentIdClick = (id) => {
    let doc = (document.getElementById(id) === undefined || document.getElementById(id) === null) ?
        parent.document.getElementById(id) : document.getElementById(id)
    doc.click()
}
//  刷新列表
const refreshList = () => {
    location.reload()
}
// 判断是否是小数
const isDouble = (str) => {
    const reg = '^\\d{1,10}([.]\\d{1,2})?$'
    const regExp = new RegExp(reg)
    return regExp.test(str)
}

// 判断字符串是否为空
const isEmpty = (obj) => {
    return obj === undefined || obj === '' || obj === null
}

// 弹出消息
const showMessage = (msg, head = '提示', flag = '1') => {
    if (!isEmpty(msg)) {
        layer.alert(msg, {
            icon: flag === '1' ? 1 : 5,
            time: 3000,
            skin: 'layui-layer-molv', //样式类名
            success: (layero, index) => {
                layer.title(head, index);
            },
        });
    }
}

// 点击仓库查看详情
const clickWarehouse = (warehouseObj) => {
    let id = warehouseObj.id
    let name = warehouseObj.name
    let address = warehouseObj.address
    let email = warehouseObj.email
    layer.open({
        type: 1,
        content:
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">仓库ID：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + id + '</div>' +
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">仓库名称：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + name + '</div>' +
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">仓库地址：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + address + '</div>' +
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">仓库邮箱：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + email + '</div>',
        area: ['350px', '100%'],
        offset: 'rt',
        anim: 2,
        shadeClose: true,
        resize: false
    });
}

// 点击材料查看详情
const clickItem = (itemObj) => {
    let id = itemObj.id
    let price = itemObj.price
    let name = itemObj.name
    layer.open({
        type: 1,
        content:
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">材料ID：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + id + '</div>' +
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">材料名称：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + name + '</div>' +
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">材料单价：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + price + '</div>',
        area: ['350px', '100%'],
        offset: 'rt',
        anim: 2,
        shadeClose: true,
        resize: false
    });
}

// 点击供货商查看详情
const clickSupplier = (supplierObj) => {
    let id = supplierObj.id
    let name = supplierObj.name
    let address = supplierObj.address
    let email = supplierObj.email
    layer.open({
        type: 1,
        content:
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">供货商ID：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + id + '</div>' +
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">供货商名称：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + name + '</div>' +
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">供货商地址：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + address + '</div>' +
            '<div style="padding-top: 15px;margin-left: 15px;font-size: 16px;font-weight: 555;">供货商邮箱：</div>' +
            '<div style="padding-top: 15px;width: 100%; text-align: center;font-size: 15px;">' + email + '</div>',
        area: ['350px', '100%'],
        offset: 'rt',
        anim: 2,
        shadeClose: true,
        resize: false
    });
}