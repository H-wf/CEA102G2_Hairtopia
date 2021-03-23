package com.orderdetail.model;

public class OrderDetailVO {
	private Integer ordNo;
	private Integer proNo;
	private Integer ordDetAmt;
	private Integer ordDetPrice;
	
	public Integer getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(Integer ordNo) {
		this.ordNo = ordNo;
	}
	public Integer getProNo() {
		return proNo;
	}
	public void setProNo(Integer proNo) {
		this.proNo = proNo;
	}
	public Integer getOrdDetAmt() {
		return ordDetAmt;
	}
	public void setOrdDetAmt(Integer ordDetAmt) {
		this.ordDetAmt = ordDetAmt;
	}
	public Integer getOrdDetPrice() {
		return ordDetPrice;
	}
	public void setOrdDetPrice(Integer ordDetPrice) {
		this.ordDetPrice = ordDetPrice;
	}
	
//	@Override
//	public String toString() {
//		return "BOOK [proNo=" + proNo + ", ordDetAmt=" + ordDetAmt + ", ordDetPrice=" + ordDetPrice + "]";
//	}
//
//	@Override
//	public int hashCode() {
//		final int prime = 31;
//		int result = 1;
//		result = prime * result + ((proNo == null) ? 0 : proNo.hashCode());
//		return result;
//	}
//
//	@Override
//	public boolean equals(Object obj) {
//		if (this == obj)
//			return true;
//		if (obj == null)
//			return false;
//		if (getClass() != obj.getClass())
//			return false;
//		OrderDetailVO other = (OrderDetailVO) obj;
//		if (proNo == null) {
//			if (other.proNo != null)
//				return false;
//		} else if (!proNo.equals(other.proNo))
//			return false;
//		return true;
//	}
}
