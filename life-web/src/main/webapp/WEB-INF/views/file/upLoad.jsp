<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
* {
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>
	<div class="easyui-layout" style="width: 100%; height: 100%;">
		<div data-options="region:'west',split:false,border:true" style="width: 400; height: 100%;">

			<form id="upLoadFileForm" class="easyui-form" style="width: 100%;" method="post" enctype="multipart/form-data">
				<table cellpadding="5" style="width: 350px; margin-left: 5px; margin-top: 20px;">
					<tr>
						<td style="width: 280px;"><input style="width: 260px;" class="easyui-filebox" name="file" data-options="prompt:'选择你要上传的文件...'"></td>
						<td style="width: 120px;"><a style="width: 100px;" id="upload" onclick="submitForm()" class="easyui-linkbutton" data-options="plain:false,iconCls:'icon-save'">确认上传</a></td>
					</tr>
				</table>
			</form>
			<div style="width: 365px; margin-left: 5px; margin-top: 20px;">
				<table id="fileTypeSum" class="easyui-datagrid" title="类型汇总" data-options="singleSelect:true,collapsible:true,url:'${base}file/getSumGroupTypeByUserCode',method:'post',toolbar:'#tb'">
					<thead>
						<tr>
							<th data-options="field:'fileType'">文件类型</th>
							<th data-options="field:'fileSum',align:'right'">总数量</th>
							<th data-options="field:'fileSize',align:'right'">总大小(M)</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div data-options="region:'center',border:true">
			<div class="easyui-layout" style="width: 100%; height: 100%;">
				<div data-options="region:'north'" style="height: 200px;">
					<table id="fileList" data-options="fit:true,border:false">
					</table>
				</div>
				<div data-options="region:'center'" style="padding: 5px;">
					<div id="fileShow" style=""></div>
				</div>
			</div>


		</div>
	</div>
	<script type="text/javascript" src="${base}static/life-js/common.js"></script>
	<script type="text/javascript">
		function submitForm() {
			submit("upLoadFileForm", {
				url : "${base}file/add/uploadFile",
				onSubmit : function() {
					progressLoad();
					var isValid = $(this).form('enableValidation').form('validate');
					if (!isValid) {
						progressClose();
					}
					return isValid;
				},
				success : function(result) {
					progressClose();
					result = $.parseJSON(result);
					if (result.code == 200) {
						$.messager.alert('提示', result.message, 'info');
						$('#fileTypeSum').datagrid('reload');
						$('#fileList').datagrid('reload');
						$('#upLoadFileForm').clear();
					} else {
						$.messager.alert("提示", result.message, "warning");
					}
				}
			});
		}
		var dataGrid;
		$(function() {

			dataGrid = $('#fileList').datagrid({
				title : '文件列表',
				url : '${base}file/getFiles',
				fit : true,
				striped : true,
				singleSelect : true,
				checkOnSelect : true,
				selectOnCheck : true,
				idField : 'id',
				border : false,
				frozenColumns : [ [ {
					title : 'id',
					field : 'id',
					width : 40,
					hidden : true
				} ] ],
				columns : [ [ {
					field : 'id',
					title : '文件编号'
				}, {
					field : 'fileName',
					title : '文件名称'
				}, {
					field : 'fileType',
					title : '文件类型'
				}, {
					field : 'fileSize',
					title : '文件大小(M)',
					align : 'right'
				}, {
					field : 'uploadTime',
					title : '上传时间'
				}, {
					field : ' ',
					title : '操作',
					formatter : function(value, row, index) {
						var aStr = '';
						var type = row.fileType;
						if (type == 'mp3' || type == 'mp4' || type == 'ogg') {
							aStr += '  <a onclick="play(\'' + row.fileUrl + '\')" class="easyui-linkbutton"><b style="text-decoration: underline;">播放</b></a>';
						} else if (type == 'png' || type == 'jpeg' || type == 'jpg') {
							aStr += '  <a onclick="img(\'' + row.fileUrl + '\')" class="easyui-linkbutton"><b style="text-decoration: underline;">预览</b></a>';
						}
						aStr += '  <a onclick="detele(\'' + row.id + '\')" class="easyui-linkbutton"><b style="text-decoration: underline;">删除</b></a>';
						aStr += '  <a href="' + row.fileUrl+ '" target="_blank" class="easyui-linkbutton"><b style="text-decoration: underline;">下载</b></a>';
						return aStr;
					}
				} ] ]
			});

			$('#fileTypeSum').datagrid({
				onSelect : function(index, row) {
					var url = '${base}file/getFiles?type=' + row.fileType;
					$("#fileShow").empty();
					$.ajax({
						type : 'POST',
						dataType : "json",
						url : url,
						success : function(result) {
							var url = '${base}file/getFiles';
							$('#fileList').datagrid({
								url : url,
								queryParams : {
									type : row.fileType
								},
								method : "post"
							});
							console.log(url);
						}
					});
				}
			});

			// 			$('#fileList').datagrid({
			// 				onSelect : function(index, row) {
			// 					$("#fileShow").empty();
			// 					var url = row.fileUrl;
			// 					var type = row.fileType;
			// 					console.log(type);
			// 					var context = null;
			// 					if (type == 'mp3') {
			// 						context = "<audio src="+url+" controls='controls' ></audio>";
			// 					} else if (type == 'mp4' || type == 'ogg') {
			// 						context = "<video  src="+url+" controls='controls' ></video >";
			// 					} else if (type == 'png' || type == 'jpeg' || type == 'jpg') {
			// 						context = "<img src='"+url+"'></img>";
			// 					} else {
			// 						context = " <b style='color:red'>该文件类型不支持预览或播放</b>";
			// 					}
			// 					$("#fileShow").append(context);
			// 				}
			// 			});
		});
		function play(url) {
			$("#fileShow").html("<audio src="+url+" controls='controls' autoplay='autoplay' ></audio>");
		}
		function img(url) {
			$("#fileShow").html("<img src='"+url+"'></img>");
		}
		function detele(id) {
			progressLoad();
			$.ajax({
				type : 'POST',
				dataType : "json",
				url : '${base}file/delete?id=' + id,
				success : function(result) {
					progressClose();
					if (result.code == 200) {
						$("#fileShow").empty();
						$.messager.alert('提示', result.message, 'info');
						$('#fileTypeSum').datagrid('reload');
						$('#fileList').datagrid('reload');
					} else {
						$.messager.alert("提示", result.message, "warning");
					}
				}
			});
		}
	</script>
</body>
</html>