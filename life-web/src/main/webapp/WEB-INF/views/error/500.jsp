<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript">
	$(function() {
		var isPc = IsPC();
		if (isPc) {
			window.location.href = "${base}login";
		} else {
			window.location.href = "${base}MOBIndex";
		}

	});
	function IsPC() {
		var userAgentInfo = navigator.userAgent;
		var Agents = [ "Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod" ];
		var flag = true;
		for (var v = 0; v < Agents.length; v++) {
			if (userAgentInfo.indexOf(Agents[v]) > 0) {
				flag = false;
				break;
			}
		}
		return flag;
	}
</script>
</head>
<body>
	<div>
		<h1>500</h1>
		<h4>
			ERROR:1.缓存已过期 或 登录的编号不存在，2.服务器出现异常，3.未知
			</h6>
			<h6>
				<a style="text-decoration: underline;" href="${base}">重新登录或刷新 </a>
			</h6>
	</div>
</body>
</html>