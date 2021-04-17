package com.rule.model;

import java.util.List;

public class RuleService {
	private RuleDAO_interface dao;

	public RuleService() {
		dao = new RuleHibernateDAO();
	}

	public RuleVO addRule(String ruleName, String ruleCon) {
		RuleVO ruleVO = new RuleVO();

		ruleVO.setRuleName(ruleName);
		ruleVO.setRuleCon(ruleCon);

		dao.insert(ruleVO);

		return ruleVO;
	}

	public RuleVO updateRule(Integer ruleNo, String ruleName, String ruleCon) {

		RuleVO ruleVO = new RuleVO();
		ruleVO.setRuleNo(ruleNo);
		ruleVO.setRuleName(ruleName);
		ruleVO.setRuleCon(ruleCon);

		dao.update(ruleVO);

		return ruleVO;
	}

	public void deleteRule(Integer ruleNo) {
		dao.delete(ruleNo);
	}
	
	public RuleVO getOneRule(Integer ruleNo) {
		return dao.findByPrimaryKey(ruleNo);
	}
	
	public List<RuleVO> getAll() {
		return dao.getAll();
	}
}
