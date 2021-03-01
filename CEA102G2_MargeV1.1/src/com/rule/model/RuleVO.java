package com.rule.model;

import java.io.Serializable;

public class RuleVO implements Serializable{
	
	private Integer ruleNo;
	private String ruleName;
	private String ruleCon;
	
	public RuleVO() {
		super();
	}
	public Integer getRuleNo() {
		return ruleNo;
	}
	public void setRuleNo(Integer ruleNo) {
		this.ruleNo = ruleNo;
	}
	public String getRuleName() {
		return ruleName;
	}
	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}
	public String getRuleCon() {
		return ruleCon;
	}
	public void setRuleCon(String ruleCon) {
		this.ruleCon = ruleCon;
	}
}
