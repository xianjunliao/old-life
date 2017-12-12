package com.life.model;

import java.io.Serializable;

public class LifeUserModel implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2655175296386923307L;
	private String userCode;//编号
	private String createTime;//创建时间
	private String userRole;//用户角色
	private String updateTime;//修改时间
	private String userMotto;//座右铭
	private String userMusic;//音乐名称
	
	public String getUserMotto() {
		return userMotto;
	}
	public void setUserMotto(String userMotto) {
		this.userMotto = userMotto;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;

	}
	public String getUserMusic() {
		return userMusic;
	}
	public void setUserMusic(String userMusic) {
		this.userMusic = userMusic;
	}
	@Override
	public String toString() {
		return "LifeUserModel [userCode=" + userCode + ", createTime=" + createTime + ", userRole=" + userRole
				+ ", updateTime=" + updateTime + ", userMotto=" + userMotto + ", userMusic=" + userMusic + "]";
	}
	
}