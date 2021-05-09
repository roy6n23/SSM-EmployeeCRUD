<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2021/5/7
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<%--
    web路径
    不以/开始的相对路径，找资源，是以当前资源的路径为基准的，经常容易出问题
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)：需要加上项目名
            http://localhost:3306/crud
--%>
<%--引入jquery--%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
<%--引入Bootstrap的css样式--%>
<link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
<html>
<head>
    <title>员工列表</title>

</head>
<body>


<%--员工添加的模态框--%>
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@roy.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId">
                                <option></option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<%--员工修改的模态框--%>
<!-- Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@roy.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId">
                                <option></option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>



<%--搭建页面--%>

<div class="container">

    <%--    标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>员工管理系统</h1>
        </div>
    </div>

    <%--    按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <button type="button" class="btn btn-success" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>

    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <%--表头--%>
                <thead>

                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>

                </thead>

                <tbody>

                </tbody>


            </table>
        </div>
    </div>


    <%--    显示分页信息--%>
    <div class="row">
        <%-- 分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>

<%--        ============================================== js部分=========================================--%>
<%--        ============================================== js部分=========================================--%>
<%--        ============================================== js部分=========================================--%>
<%--        ============================================== js部分=========================================--%>
<%--        ============================================== js部分=========================================--%>

    <script type="text/javascript">

        //总记录数
        var totalRecordCount;
        //当前页面
        var currentPage;

        //页面加载完成以后，直接去发送一个ajax请求，要到分页数据
        $(function () {
            //去首页
            to_page(1);

        })

        //跳转页面
        function to_page(pn) {
            $.ajax({
                    url:"${APP_PATH}/emps",
                    data:"pn="+pn,
                    type:"GET",
                    success:function (result) {
                        // console.log(result);
                        //1. 解析并且显示员工数据
                        build_emps_table(result);
                        //2. 解析并显示分页信息
                        build_page_info(result);
                        //3. 解析显示分页条数据
                        build_page_nav(result);

                    }
                }

            );


        }

        //构建表格内容
        function build_emps_table(result) {
            //清空table表格
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps,function (index, item) {
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>")
                // alert(item.empName);
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=="M" ?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var empDeptNameTd = $("<td></td>").append(item.department.deptName);
                /**
                 * 依照之前的样式进行构建
                 * <button type="button" class="btn btn-primary btn-sm">
                         <span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span>
                         编辑
                    </button>

                     <button type="button" class="btn btn-danger btn-sm">
                         <span class="glyphicon glyphicon-trash" aria-hidden="true" ></span>
                         删除
                     </button>
                 */
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                                .append("编辑");
                //为编辑按钮添加一个自定义的属性，来表示当前员工id
                editBtn.attr("edit-id", empSearched[i].empId);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                                .append("删除");
                //为删除按钮添加一个自定义的属性，来表示当前员工id
                delBtn.attr("del-id", item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完成之后还是完成原来的元素，所以可以链式操作
                $("<tr></tr>")
                    .append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(empDeptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            })
        }

        //解析分页信息（和分页条不一样）
        function build_page_info(result) {
            //清空分页信息
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+ result.extend.pageInfo.pageNum +
                                            "页，总共"+result.extend.pageInfo.pages +
                                            "页，总共"+ result.extend.pageInfo.total +  "条记录")
            totalRecordCount = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        //解析分页条的信息（导航条）
        function build_page_nav(result) {
            //清空分页条，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
            $("#page_nav_area").empty();
            //$("#page_nav_area")
            var ul = $("<ul></ul>").addClass("pagination");

            //构建首页和上一页
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            var prevPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            //如果没有上一页，就设置首页和上一页的按钮不可用
            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prevPageLi.addClass("disabled");
            }else{
                //如果有上一页，才绑定单击事件
                //为首页标签添加单击事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                //为上一页标签添加单击事件
                prevPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum - 1);
                });
            }

            //构建末页和下一页
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
            //如果没有下一页，就设置下一页和尾页按钮不可用
            if(result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                //如果有下一页，才绑定单击事件
                //为下一页标签添加单击事件
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum + 1);
                });
                //为尾页标签添加单击事件
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }

            //添加首页和前一页到ul标签中
            ul.append(firstPageLi).append(prevPageLi);

            //页码号12345遍历给ul中添加页码提示
            $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));

                //绑定单击事件，点击页码进行跳转
                numLi.click(function () {
                    to_page(item);
                })

                //当前页数高亮显示
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }

                ul.append(numLi);
            })
            //添加后一页和末页的提示
            ul.append(nextPageLi).append(lastPageLi);

            //把ul添加到nav标签中
            var navEle = $("<nav></nav>").append(ul).appendTo("#page_nav_area");
        }

        //清空表单样式及内容
        function reset_form(ele){
            //清空表单内容，取出dom对象，调用reset()方法
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            //清空提示信息
            $(ele).find(".help-block").text("");
        }

        //点击新增按钮弹出模态框
        $("#emp_add_modal_btn").click(function () {
            //清除表单数据（表单重置，包括表单数据以及表单样式），防止出现点击保存之后再次点击新增，跳出的模态框还是保存上次添加的记录，避免重复添加。
            //取出dom对象，调用reset()方法
            // $("#empAddModal form")[0].reset();
            reset_form("#empAddModal form");
            //发送ajax请求，在弹出模态框之前查询部门信息，显示在下拉列表中
            getDepts("#empAddModal select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });





        //查出所有部门信息并显示在下拉列表中
        function getDepts(ele) {
            //清空下拉菜单信息，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
            $(ele).empty();

            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                async:false,
                success:function (res) {
                    // 点击添加后，最终返回的json字符串是这样的
                    // {"code":100,"msg":"处理成功!",
                    //     "extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                    //遍历部门信息，在下拉列表中显示部门信息
                    $.each(res.extend.depts, function () {
                        //在遍历之前
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        //将option标签添加到empAddModal下的select标签中
                        //传入ele参数，调用时只需把对应id作为参数即可
                        optionEle.appendTo(ele);
                        //将option标签添加到empUpdateModal下的select标签中，用于编辑的模态框
                        // optionEle.appendTo("#empUpdateModal select");
                    });
                }
            });
        }


//================================================校验信息=======================================
//================================================校验信息=======================================
//================================================校验信息=======================================
//================================================校验信息=======================================
//================================================校验信息=======================================


        //前端校验表单数据的方法
        function validate_add_form(){

            // 拿到要校验的数据，使用正则表达式
            var empName = $("#empName_add_input").val();
            //允许数字字母以及_-，6-16位或者中文2-5位
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

            //1、校验用户名
            if(!regName.test(empName)){
                //失败
                // alert("用户名必须是6-16位数字，字母或者_-，也可以是2-5位中文组成");
                //添加错误样式到输入框
                // $("#empName_add_input").parent().addClass("has-error");
                //给empName_add_input所在标签的下一个span标签加上文本
                // $("#empName_add_input").next("span").text("用户名必须是6-16位数字，字母或者_-，也可以是2-5位中文组成");
                show_validate_msg("#empName_add_input", "error", "用户名必须是6-16位数字，字母或者_-，也可以是2-5位中文组成");
                return false;
            }else{
                //成功
                // $("#empName_add_input").parent().addClass("has-success");
                // $("#empName_add_input").next("span").text("");
                // console.log("1");
                show_validate_msg("#empName_add_input", "success", "");
            }

            //2、校验邮箱
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                // alert("邮箱格式不正确!");
                // $("#email_add_input").parent().addClass("has-error");
                // $("#email_add_input").next("span").text("邮箱格式不正确!");
                show_validate_msg("#email_add_input", "error", "邮箱格式不正确!");
                return false;
            }else{
                // $("#email_add_input").parent().addClass("has-success");
                // $("#email_add_input").next("span").text("");
                show_validate_msg("#email_add_input", "success", "");
            }

            return true;
        }

        //这里将校验结果的提示信息全部抽取出来
        function show_validate_msg(ele, status, msg) {
            // 当一开始输入不正确的用户名之后，会变红。
            // 但是之后输入了正确的用户名却不会变绿，
            // 因为has-error和has-success状态叠加了。
            // 所以每次校验的时候都要清除当前元素的校验状态。
            $(ele).parent().removeClass("has-success has-error");
            //提示信息默认为空
            $(ele).next("span").text("");
            if("success" == status){
                //如果校验成功
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                //如果校验失败
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }


        //校验用户名是否可用
        $("#empName_add_input").change(function () {
            //  发送ajax请求校验用户名是否可用
            //  输入框中的值
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"empName=" + empName,
                type:"POST",
                success:function (res) {
                    if(res.code == 100){
                        //成功
                        show_validate_msg("#empName_add_input", "success", "用户名可用");
                        //    如果用户名可用，将success标志保存到ajax-value属性中
                        $("#emp_save_btn").attr("ajax-value", "success");
                    }else{
                        //失败
                        show_validate_msg("#empName_add_input", "error", res.extend.va_msg);
                        //    如果用户名不可用，将error标志保存到ajax-value属性中
                        $("#emp_save_btn").attr("ajax-value", "error");
                    }
                }
            })
        })

        //保存员工
        $("#emp_save_btn").click(function () {
            //1、模态框中填写的表单数据提交给服务器进行保存
            //2、先对要提交给服务器的数据进行校验，并且判断之前的ajax用户名校验是否成功
            //    只要有一个校验失败，就无法保存
            if($(this).attr("ajax-value") == "error"){
                return false;
            }
            if(!validate_add_form() || !emailStatus){
                return false;
            }
            //3、校验之后，再发送ajax请求保存员工
            //     alert($("#empAddModal form").serialize());
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (res) {
                    // alert(res.msg);
                    //判断状态码，如果是100（成功），才关闭模态框并进行跳转
                    if(res.code == 100){
                        // 员工保存成功之后，
                        //  1、关闭模态框
                        $('#empAddModal').modal('hide');
                        //  2、跳转到最后一页，显示刚才保存的数据
                        //   由于有了分页插件，当跳转的页面大于总页面数的时候，就会跳转到最后一页
                        to_page(totalRecordCount);
                    }else {
                        //显示失败信息
                        // console.log(res);
                        //有哪个字段的错误信息就显示哪个字段的
                        //如果邮箱有误
                        if (res.extend.errorField.email != undefined){
                            //    显示邮箱错误信息
                            show_validate_msg("#email_add_input", "error", res.extend.errorField.email);
                        }
                        //如果用户名有误
                        if(res.extend.errorField.empName != undefined){
                            //显示用户名错误信息
                            show_validate_msg("#empName_add_input", "error", res.extend.errorField.empName);
                        }
                    }
                }
            });
        });

//========================================================================================
//========================================================================================
//========================================================================================
//========================================================================================
//========================================================================================


        //为每个员工的编辑按钮绑定单击事件
        //但是，这里的单击事件是在编辑按钮被创建出来之前就已经开始绑定了，所以这里无法绑定单击事件
        //有两种办法
        //     1）可以在创建按钮的时候就给他绑定单击事件
        //     2）绑定单击.live()，而新版jQuery没有live方法，而是用on进行替代
        $(document).on("click", ".edit_btn", function () {
            alert("edit");
            //1、通过edit-id属性查出员工信息，显示员工信息
            getEmp($(this).attr("edit-id"));
            //2、查出部门信息，并显示部门列表
            getDepts("#empUpdateModal select");
            //弹出模态框，
            //把员工的id传递给模态框的更新按钮，方便点击修改后获取员工id
            $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        })


        //员工姓名回显
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/" + id,
                type:"GET",
                success:function (res) {
                    // console.log(res);
                    //获取员工数据
                    var empData = res.extend.emp;
                    //添加到标签文本中
                    $("#empName_update_static").text(empData.empName);
                    //显示邮箱
                    $("#email_update_input").val(empData.email);
                    //选中性别单选框
                    $("#empUpdateModal input[name = gender]").val([empData.gender]);
                    //选中部门
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        //    点击更新，更新员工信息
        $("#emp_update_btn").click(function () {
            //验证邮箱是否合法
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_update_input", "error", "邮箱格式不正确!");
                return false;
            }else{
                show_validate_msg("#email_update_input", "success", "");
            }
            //发送ajax请求保存更新的员工数据
            $.ajax({
                //加上之前在修改按钮上保存的edit-id的值
                url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),// + "&_method=PUT",
                success:function (res) {
                    // alert(res.msg);
                    //关闭对话框
                    $('#empUpdateModal').modal('hide');
                    //回到本页面
                    to_page(currentPage);
                }
            })
        })


        //单个删除
        $(document).on("click", ".delete_btn", function () {
            //    弹出是否删除确认框，并显示员工姓名
            //    找tr标签下的第三个td标签，对应的就是员工名字
            var empName = $(this).parents("tr").find("td:eq(1)").text();
            //拿到当前员工的id
            var empId = $(this).attr("del-id");
            //弹出确认框，点击确认就删除
            if(confirm("确认删除 [" + empName + "] 吗？")){
                //    确认，发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/emp/" + empId,
                    type:"DELETE",
                    success:function (res) {
                        alert(res.msg);
                        //回到本页
                        to_page(currentPage);
                    }
                })
            }
        });

        //完成全选，全不选功能
        $("#check_all").click(function () {
            $(".check_item").prop("check", $(this).prop("checked"));
        })

        //    当本页面所有复选框都选上时，自动将全选复选框选上
        $(document).on("click", ".check_item", function () {
            //判断当前选择中的元素是否是当前页面所有check_item的个数
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked", flag);
        })

        //    为批量删除绑定单击事件
        $("#emp_delete_batch_btn").click(function () {
            var empNames = "";
            var del_idstr = "";
            //遍历每一个被选中的复选框
            $.each($(".check_item:checked"), function () {
                // 获取要删除的员工姓名
                empNames += $(this).parents("tr").find("td:eq(2)").text() + "\n";
                //获取要删除的员工的id
                del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
            //去除多余的-
            del_idstr = del_idstr.substring(0, del_idstr.length - 1);
            if(confirm("确认删除 \n" + empNames + " 吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/" + del_idstr,
                    type:"DELETE",
                    success:function (res) {
                        alert(res.msg);
                        to_page(currentPage);
                    }
                })
            }
        });

    </script>

</div>

</body>
</html>

