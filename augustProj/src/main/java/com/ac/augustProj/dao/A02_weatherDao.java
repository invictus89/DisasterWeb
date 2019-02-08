package com.ac.augustProj.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ac.augustProj.vo.RainForCombo;
import com.ac.augustProj.vo.RainYearMonth;
import com.ac.augustProj.vo.WeatherCodeName;
import com.ac.augustProj.vo.WeatherRealTIme;
import com.ac.augustProj.vo.Weather_Forecast;
import com.ac.augustProj.vo.WthYear;

import java.util.HashMap;
import java.util.Map;

@Repository
public class A02_weatherDao {
	@Autowired
	private SqlSession session;

	public List<WthYear> wthYearList(String district){
		return session.selectList("wthYearList",district);
	}
	public List<WthYear> wthYearListDistrict(String shiname){
		return session.selectList("wthYearListDistrict",shiname);
	}
	public List<WthYear> wthGetYear(){
		return session.selectList("wthGetYear");
	}
	public List<WthYear> getWthCount(WthYear wthYear){
		return session.selectList("getWthCount",wthYear);
	}
	public List<RainYearMonth> weatherMonthSelect(String selectYearAndMonth , String selectLocal){
		Map<String, String> map = new HashMap<String, String>();
		map.put("selectYearAndMonth", selectYearAndMonth);
		map.put("selectLocal", selectLocal);
		return session.selectList("weatherMonthSelect",map);
	}
	public List<RainYearMonth> weatherMonthSelectG(String selectYearAndMonth){
		return session.selectList("weatherMonthSelectG",selectYearAndMonth);
	}
	public List<RainForCombo> getRainForCombo(String selectCode,String selectYear){
		Map<String, String> map = new HashMap<String, String>();
		map.put("selectCode", selectCode);
		map.put("selectYear", selectYear);
		System.out.println(map);
		return session.selectList("getRainForCombo",map);
	}
	public List<WeatherCodeName> getWeatherCodeName(String shidoValue){
		System.out.println(shidoValue);
		return session.selectList("getWeatherCodeName",shidoValue);
		}
	public List<WthYear> getWthCountG(WthYear wthYear){
		return session.selectList("getWthCountG",wthYear);
	}
	public List<Weather_Forecast> forecastweather(){
		return session.selectList("forecastweather");
	}
	public List<WeatherRealTIme> getWeatherRealTIme(String weatherFordate){
		return session.selectList("getWeatherRealTIme",weatherFordate);
	}
	public String countRainyday(){
		return session.selectOne("countRainyday");
	}
	public float countManyS(){
		return session.selectOne("countManyS");
	}
	public float avgRainAmount(){
		return session.selectOne("countRainAmount");
	}
	public int countDataWeather(){
		return session.selectOne("countDataWeather");
	}
}
