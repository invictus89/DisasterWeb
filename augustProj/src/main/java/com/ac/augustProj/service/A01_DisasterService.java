package com.ac.augustProj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ac.augustProj.dao.A01_disasterDao;
import com.ac.augustProj.vo.AreaAnalysis;
import com.ac.augustProj.vo.DegPerHour;
import com.ac.augustProj.vo.EarthYear;
import com.ac.augustProj.vo.EarthquakeCount;
import com.ac.augustProj.vo.Earthquake_Forecast;
import com.ac.augustProj.vo.Notice;
import com.ac.augustProj.vo.Realtime;
import com.ac.augustProj.vo.Shelter;
import com.ac.augustProj.vo.ShelterAreaForPreference;
import com.ac.augustProj.vo.ShelterCount;
import com.ac.augustProj.vo.Shelter_accommodate;

@Service
public class A01_DisasterService {
	@Autowired(required=false)
	private A01_disasterDao dao;
	
	public List<Realtime> getRealtime(Realtime rt){
		return dao.getRealtime(rt);
	}
	
	public List<Shelter> getShelter(){
		List<Shelter> list = dao.getShelter();
		return list;
	}

	public List<Notice> getNotice(){
		return dao.getNotice();
	}
	
	public List<DegPerHour> getInfoPerHour(){
		List<DegPerHour> list = dao.getInfoPerHour();
		return list;
	}
	public List<EarthYear> yearList(){
		return dao.yearList();
	}
	
	public List<EarthYear> monthList(){
		return dao.monthList();
	}
	public List<AreaAnalysis> getAreaAnalysis(){
		return dao.getAreaAnalysis();
	}
	public List<Realtime> month_detail(String select_month){
		return dao.month_detail(select_month);
	}
	public List<Realtime> year_detail(String select_year){
		return dao.year_detail(select_year);
	}
	public AreaAnalysis region_detail(String regionclick){
		return dao.region_detail(regionclick);
	}
	public List<ShelterCount> sheltercount(){
		return dao.sheltercount();
	}
	public List<EarthquakeCount> earthquakecount(){
		return dao.earthquakecount();
	}
	public List<Shelter_accommodate> shelter_accommodate(){
		return dao.shelter_accommodate();
	}
	public List<ShelterAreaForPreference> getShelterAreaForPreference(String test){
		List<ShelterAreaForPreference> list = dao.getShelterAreaForPreference(test);
		for(ShelterAreaForPreference t : list)
			System.out.println(t.getSiDoName());
		return list;
	}
	public List<Realtime> getCurrentRt(){
		List<Realtime> list = dao.getCurrentRt();
		for(Realtime t : list)
			System.out.println(t.getTitle());
		return list;
	}
	
	public int total_num_eq(){ return dao.total_num_eq(); }
	public int total_num_sh(){ return dao.total_num_sh(); }
	public String avg_eq(){ return dao.avg_eq(); }
	public String max_eq(){ return dao.max_eq(); }
	public String min_eq(){ return dao.min_eq(); }
	public int has_num_eq(){ return dao.has_num_eq(); }
	public List<Earthquake_Forecast> forecastearthquake(){
		return dao.forecastearthquake();
	}


}
