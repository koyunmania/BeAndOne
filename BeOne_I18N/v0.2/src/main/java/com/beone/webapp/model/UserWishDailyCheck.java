package com.beone.webapp.model;

import java.sql.Date;

public class UserWishDailyCheck {
	
	private int entryId;
	private UserWish wish;
	/**
	 * 0 means wish is not realized
	 * 1 means wish is realized
	 */
	private WishCheckStatus checkStatus;
	private Date targetDate;
	private Date checkedAt;


	/**
	 * @return the checkStatus
	 */
	public WishCheckStatus getCheckStatus() {
		return checkStatus;
	}
	/**
	 * @param checkStatus the checkStatus to set
	 */
	public void setCheckStatus(WishCheckStatus checkStatus) {
		this.checkStatus = checkStatus;
	}
	/**
	 * @return the entryId
	 */
	public int getEntryId() {
		return entryId;
	}
	/**
	 * @param entryId the entryId to set
	 */
	public void setEntryId(int entryId) {
		this.entryId = entryId;
	}
	public Date getTargetDate() {
		return targetDate;
	}
	public void setTargetDate(Date targetDate) {
		this.targetDate = targetDate;
	}
	public Date getCheckedAt() {
		return checkedAt;
	}
	public void setCheckedAt(Date checkedAt) {
		this.checkedAt = checkedAt;
	}
	public UserWish getWish() {
		return wish;
	}
	public void setWish(UserWish wish) {
		this.wish = wish;
	}
	
}
