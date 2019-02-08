package com.ac.augustProj.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ac.augustProj.dao.A02_weatherDao;
import com.ac.augustProj.vo.RainForCombo;
import com.ac.augustProj.vo.RainYearMonth;
import com.ac.augustProj.vo.WeatherCodeName;
import com.ac.augustProj.vo.WeatherRealTIme;
import com.ac.augustProj.vo.Weather_Forecast;
import com.ac.augustProj.vo.WthYear;


@Service
public class A02_WeatherService {
	@Autowired(required=false)
	private A02_weatherDao dao;
	
	public List<WthYear> wthYearList(String district){ 
		List<WthYear> list = dao.wthYearList(district);
		for(WthYear e : list)
			System.out.println(e.getCode_name()+", "+e.getWth_year()+", "+e.getWth_pre());
		return list;
		}
	
	public List<WthYear> wthYearListDistrict(String shiname){ 
		List<WthYear> list = dao.wthYearListDistrict(shiname);
		for(WthYear e : list)
			System.out.print(e.getCode_name()+", ");
		System.out.println();
		return list;
		}
	public List<WthYear> wthGetYear(){ 
		System.out.println("test");
		List<WthYear> list = dao.wthGetYear();
		for(WthYear e : list)
			System.out.print(e.getWth_year()+", ");
		System.out.println();
		return list;
		}
	public List<WthYear> getWthCount(WthYear wthYear){ 
		List<WthYear> list = dao.getWthCount(wthYear);
		for(WthYear e : list)
			System.out.print(e.getShiname()+", "+e.getLocation()+", "+e.getWth_year()+", "+e.getWth_pre()+", "+e.getCount());
		return list;
	}
	public List<RainYearMonth> weatherMonthSelect(String selectYearAndMonth , String selectLocal){
		return dao.weatherMonthSelect(selectYearAndMonth,selectLocal);
	}
	public List<RainYearMonth> weatherMonthSelectG(String selectYearAndMonth){
		return dao.weatherMonthSelectG(selectYearAndMonth);
	}
	public List<RainForCombo> rainForCombo(String selectCode, String selectYear){
		System.out.println(selectCode);
		System.out.println(selectYear);
		return dao.getRainForCombo(selectCode, selectYear);
	}
	public List<WeatherCodeName> getWeatherCodeName(String shidoValue){
		List<WeatherCodeName> list = dao.getWeatherCodeName(shidoValue);
		System.out.println(shidoValue);
		return list;
	}
	public List<WthYear> getWthCountG(WthYear wthYear){ 
		List<WthYear> list = dao.getWthCountG(wthYear);
		for(WthYear e : list)
			System.out.print(e.getShiname()+", "+e.getLocation()+", "+e.getWth_year()+", "+e.getWth_pre()+", "+e.getCount());
		return list;
	}
	public List<Weather_Forecast> forecastweather(){
		return dao.forecastweather();
	}
	public List<WeatherRealTIme> getWeatherRealTIme(String weatherFordate){
		List<WeatherRealTIme> list = dao.getWeatherRealTIme(weatherFordate);
		return list;
	}
	public String countRainyday(){
		System.out.println("durldurl");
		return dao.countRainyday();
	}
	public float countManyS(){
		return dao.countManyS();
	}
	public float avgRainAmount(){
		return dao.avgRainAmount();
	}
	public int countDataWeather(){
		return dao.countDataWeather();
	}
}
