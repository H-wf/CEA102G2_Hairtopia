package com.cos.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.coudet.model.CosdetVO;

public class CosService {
	private CosDAO_interface dao;

	public CosService() {
		dao = new CosDAO();
	}
	
	public CosVO addCos(Integer lecNo, Integer cosTypeNo, Timestamp cosFrom, Timestamp cosTo, 
			String cosIntro, byte[] cosPic, String cosAdd, 
			Boolean cosStatus, Integer cosMinCount, Integer cosMaxCount, Integer cosPrice, Timestamp cosApplyFrom, 
			Timestamp cosApplyTo, String cosName){
		CosVO cosVO = new CosVO();
		
		cosVO.setLecNo(lecNo);
		cosVO.setCosTypeNo(cosTypeNo);
		cosVO.setCosFrom(cosFrom);
		cosVO.setCosTo(cosTo);
		cosVO.setCosIntro(cosIntro);
		cosVO.setCosPic(cosPic);
		cosVO.setCosAdd(cosAdd);
		cosVO.setCosStatus(cosStatus);
		cosVO.setCosMinCount(cosMinCount);
		cosVO.setCosMaxCount(cosMaxCount);
		cosVO.setCosPrice(cosPrice);
		cosVO.setCosApplyFrom(cosApplyFrom);
		cosVO.setCosApplyTo(cosApplyTo);
		cosVO.setCosName(cosName);

		dao.insert(cosVO);

		return cosVO;
	}

	public CosVO updateCos(Integer cosNo, Integer lecNo, Integer cosTypeNo, Timestamp cosFrom, Timestamp cosTo, 
			String cosIntro, byte[] cosPic, String cosAdd, 
			Boolean cosStatus, Integer cosMinCount, Integer cosMaxCount, Integer cosPrice, Timestamp cosApplyFrom, 
			Timestamp cosApplyTo, String cosName) {
		
			CosVO cosVO = new CosVO();

			cosVO.setCosNo(cosNo);
			cosVO.setLecNo(lecNo);
			cosVO.setCosTypeNo(cosTypeNo);
			cosVO.setCosFrom(cosFrom);
			cosVO.setCosTo(cosTo);
			cosVO.setCosIntro(cosIntro);
			cosVO.setCosPic(cosPic);
			cosVO.setCosAdd(cosAdd);
			cosVO.setCosStatus(cosStatus);
			cosVO.setCosMinCount(cosMinCount);
			cosVO.setCosMaxCount(cosMaxCount);
			cosVO.setCosPrice(cosPrice);
			cosVO.setCosApplyFrom(cosApplyFrom);
			cosVO.setCosApplyTo(cosApplyTo);
			cosVO.setCosName(cosName);	
			
			dao.update(cosVO);

			return cosVO;
	}
	
	public CosVO updateCosNoPic(Integer cosNo, Integer lecNo, Integer cosTypeNo, Timestamp cosFrom, Timestamp cosTo, 
			String cosIntro, String cosAdd,  
			Boolean cosStatus, Integer cosMinCount, Integer cosMaxCount, Integer cosPrice, Timestamp cosApplyFrom, 
			Timestamp cosApplyTo, String cosName) {
		System.out.println("error");
			CosVO cosVO = new CosVO();

			cosVO.setCosNo(cosNo);
			cosVO.setLecNo(lecNo);
			cosVO.setCosTypeNo(cosTypeNo);
			cosVO.setCosFrom(cosFrom);
			cosVO.setCosTo(cosTo);
			cosVO.setCosIntro(cosIntro);
			cosVO.setCosAdd(cosAdd);
			cosVO.setCosStatus(cosStatus);
			cosVO.setCosMinCount(cosMinCount);
			cosVO.setCosMaxCount(cosMaxCount);
			cosVO.setCosPrice(cosPrice);
			cosVO.setCosApplyFrom(cosApplyFrom);
			cosVO.setCosApplyTo(cosApplyTo);
			cosVO.setCosName(cosName);	
			
			dao.updateNoPic(cosVO);

			return cosVO;
	}

	public void deleteCos(Integer cosNo) {
		dao.delete(cosNo);
	}

	public CosVO findByPrimaryKeyCos(Integer cosNo) {
		return dao.findByPrimaryKey(cosNo);
	}
	
	public List<CosVO> getAllCosApplyFrom(){
		return dao.getAllCosApplyFrom();
	}
	
	public List<CosVO> getAllCosFrom(){
		return dao.getAllCosFrom();
	}

	public List<CosVO> getAll() {
		return dao.getAll();
	}
	
	public List<CosVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
	public CosVO AddCountApplyNo(Integer cosNo, Integer cosCount) {
		
			CosVO cosVO = new CosVO();

			cosVO.setCosNo(cosNo);
			cosVO.setCosCount(cosCount);

			dao.AddCountApplyNo(cosVO);

			return cosVO;
	}
	
	public CosVO FindCountApplyNo(Integer cosNo) {
		return dao.FindCountApplyNo(cosNo);
	}
	
	public CosdetVO getAvgCosRateByCosNo(Integer cosNo) {
		return dao.getAvgCosRateByCosNo(cosNo);
	}
}	
	