<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../mobileHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript">
function enter() {
	var v = $("#usercode").val();
	if (v == null || v == "" || v == undefined) {
		$("#dlg1-msg").html('<span style="color: red">请输入身份编码！！！</span>');
		$('#dlg1').dialog('open').dialog('center');
	} else {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url : '${base}enter?code=' + v,
			success : function(result) {
				if (result.code == 200) {
					window.location.replace("${base}learn/mob");
				} else if (result.code == 202) {
					$("#dlg1-msg").html('<span style="color: red">' + result.message + '</span>');
					$('#dlg1').dialog('open').dialog('center');
				} else {
					$("#dlg1-msg").html('<span style="color: red">' + result.message + '</span>');
					$('#dlg1').dialog('open').dialog('center');
				}
			}
		});
	}
}

function addUserCode(){
	var v = $("#usercode").val();
	if (v == null || v == "" || v == undefined) {
		$("#dlg1-msg").html('<span style="color: red">请输入身份编码！！！</span>');
		$('#dlg1').dialog('open').dialog('center');
		return ;
	} 
	$.ajax({
		type : 'POST',
		dataType : "json",
		url : '${base}add?code=' + v,
		success : function(result) {
			if (result.code == 200) {
				enter();
			} else {
				$("#dlg1-msg").html('<span style="color: red">' + result.message + '</span>');
				$('#dlg1').dialog('open').dialog('center');
			}
		}
	});
	
}
function autoLogin() {
	var v = getCookie("usercode");
	if (v == null || v == "" || v == undefined) {
		$("#dlg1-msg").html('<span style="color: red">请输入身份编码！！！</span>');
		$('#dlg1').dialog('open').dialog('center');
	} else {
		$.ajax({
			type : 'POST',
			dataType : "json",
			url :'${base}enter?code=' + v,
			success : function(result) {
				if (result.code == 200) {
					window.location.replace("${base}learn/mob");
				} else if (result.code == 202) {
					$("#dlg1-msg").html('<span style="color: red">' + result.message + '</span>');
					$('#dlg1').dialog('open').dialog('center');
				} else {
					$("#dlg1-msg").html('<span style="color: red">' + result.message + '</span>');
					$('#dlg1').dialog('open').dialog('center');
				}
			}
		});
	}
}
function getCookie(name) {
	var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
	if (arr = document.cookie.match(reg)) {
		return unescape(arr[2]);
	} else {
		return null;
	}
}
</script>
<style>
</style>
</head>
<body onload="autoLogin()">
	<div class="easyui-navpanel">
		<header>
			<div class="m-toolbar">
				<span class="m-title">请使用身份编码登陆到Free Life网址</span>
			</div>
		</header>
		<div style="margin:20px auto;width:100px;height:100px;border-radius:100px;overflow:hidden">
			<img src="${base}static/mobile/images/NV_MYSEIF.png" style="margin:0;width:100%;height:100%;">
		</div>
		<div style="padding:0 20px">
			<div style="margin-bottom:10px">
				<input class="easyui-passwordbox" data-options="prompt:'输入网址的身份编码',iconCls:'icon-man'" id="usercode" style="width:100%;height:38px">
			</div>
			<div style="text-align:center;margin-top:30px">
				<a onclick="enter()" class="easyui-linkbutton" style="width:100%;height:40px"><span style="font-size:16px">确定登陆</span></a>
			</div>
			<div style="text-align:center;margin-top:30px">
				<a onclick="addUserCode()" class="easyui-linkbutton" plain="true" outline="true" style="width:160px;height:35px"><span style="font-size:16px">点击注册并登陆</span></a> 
			</div>
		</div>
	</div>
	<div id="dlg1" class="easyui-dialog" style="padding:20px 6px;width:80%;" data-options="inline:true,modal:true,closed:true,title:'Information'">
			<div id="dlg1-msg"></div>
			<div class="dialog-button">
				<a href="javascript:void(0)" class="easyui-linkbutton" style="width:100%;height:35px" onclick="$('#dlg1').dialog('close')">OK</a>
			</div>
		</div>
</body>
</html>