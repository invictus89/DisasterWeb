package com.ac.augustProj.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

@Repository
public class A01_disasterDao {
	@Autowired
	private SqlSession session;
	
	public List<Realtime> getRealtime(Realtime rt){
		return session.selectList("getRealtime", rt);
	}

	public List<Shelter> getShelter(){
		return session.selectList("getShelter");
	}
	
	public List<Notice> getNotice(){
		return session.selectList("getNotice");
	}
	
	public List<AreaAnalysis> getAreaAnalysis(){
		return session.selectList("getAreaAnalysis");
		}
	
	public List<EarthYear> yearList(){
		return session.selectList("yearList");
	}
	public List<EarthYear> monthList(){
		return session.selectList("monthList");
	}
	public List<Realtime> month_detail(String select_month){
		return session.selectList("month_detail",select_month);
	}
	public List<Realtime> year_detail(String select_year){
		return session.selectList("year_detail",select_year);
	}
	public List<DegPerHour> getInfoPerHour(){
		return session.selectList("getInfoPerHour");
	}
	public AreaAnalysis region_detail(String regionclick){
		return session.selectOne("region_detail",regionclick);
	}
	public List<ShelterCount> sheltercount() {
		return session.selectList("sheltercount");
	}
	public List<EarthquakeCount> earthquakecount() {
		return session.selectList("earthquakecount");
	}
	public List<Shelter_accommodate> shelter_accommodate(){
		return session.selectList("accomodationbylocal");
	}
	public int total_num_eq(){
		return session.selectOne("total_num_eq");
	}
	public int total_num_sh(){
		return session.selectOne("total_num_sh");
	}
	public String avg_eq(){
		return session.selectOne("avg_eq");
	}
	public String max_eq(){
		return session.selectOne("max_eq");
	}
	public String min_eq(){
		return session.selectOne("min_eq");
	}
	public int has_num_eq(){
		return session.selectOne("has_num_eq");
	}
	public List<Earthquake_Forecast> forecastearthquake(){
		return session.selectList("forecastearthquake");
	}
	public List<ShelterAreaForPreference> getShelterAreaForPreference(String test){
		return session.selectList("getShelterAreaForPreference",test);
	}	
	public List<Realtime> getCurrentRt(){
		return session.selectList("getCurrentRt");
	}	
}
