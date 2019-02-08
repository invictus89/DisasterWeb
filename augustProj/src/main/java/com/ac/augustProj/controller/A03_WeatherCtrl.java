package com.ac.augustProj.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ac.augustProj.service.A02_WeatherService;
import com.ac.augustProj.vo.RainForCombo;
import com.ac.augustProj.vo.RainYearMonth;
import com.ac.augustProj.vo.Weather_Forecast;
import com.ac.augustProj.vo.WthYear;



@Controller
public class A03_WeatherCtrl {
	@Autowired(required=false)
	private A02_WeatherService service;

	
	@RequestMapping("/getWthYear.do")
	public ModelAndView getWthYear(String code_name){	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		Object getWthYear = service.wthYearList(code_name);
	    mav.addObject("wthYear",getWthYear); 
		return mav;
	}
	@RequestMapping("/getWthYearDistrict.do")
	public ModelAndView getWthYearDistrict(String shiname){	
		System.out.println("도시 이름: "+shiname);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		Object getWthYearDistrict = service.wthYearListDistrict(shiname);
	    mav.addObject("wthYearDistrict",getWthYearDistrict); 
		return mav;
	}
	@RequestMapping("/getWthYearCount.do")
	public ModelAndView getWthYearCount(){	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		Object getWthYear = service.wthGetYear();
	    mav.addObject("wthYear",getWthYear); 
		return mav;
	}
	@RequestMapping("/getWthCount.do")
	public ModelAndView getWthCount(WthYear wthYear){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		System.out.println("컨트롤러"+wthYear.getWth_year()+", "+wthYear.getShiname());
		if(wthYear.getShiname().equals("광역시")){
		Object getWthCount = service.getWthCountG(wthYear);
		mav.addObject("wthCount",getWthCount);
		}
		if(!wthYear.getShiname().equals("광역시")){
		Object getWthCount = service.getWthCount(wthYear);
	    mav.addObject("wthCount",getWthCount);
		}
		return mav;
	}
	
	@RequestMapping(value="/weatherMonthSelect.do")
	public ModelAndView weatherMonthSelect(String selectYearAndMonth , String selectLocal ){
	System.out.println(selectYearAndMonth+selectLocal);
	ModelAndView mav = new ModelAndView();
		if(selectLocal.equals("광역시")){
			List<RainYearMonth> detailweatherMonthG = service.weatherMonthSelectG(selectYearAndMonth);
			System.out.println(detailweatherMonthG.toString());
			mav.setViewName("pageJsonReport");
			mav.addObject("detailweatherMonth",detailweatherMonthG);
		}
		if(!selectLocal.equals("광역시")){
			List<RainYearMonth> detailweatherMonth = service.weatherMonthSelect(selectYearAndMonth,selectLocal);
			System.out.println(detailweatherMonth.toString());
			mav.setViewName("pageJsonReport");
			mav.addObject("detailweatherMonth",detailweatherMonth);
		}
		return mav;
	}
	@RequestMapping(value="/rainForCombo.do")
	public ModelAndView rainForCombo(String selectCode, String selectYear) {
		ModelAndView mav = new ModelAndView();
		List<RainForCombo> rainForCombo = service.rainForCombo(selectCode, selectYear);

		mav.setViewName("pageJsonReport");
		mav.addObject("rainForCombo",rainForCombo);		
		return mav;
	}
	@RequestMapping("/weatherCodeName.do")
	public ModelAndView weatherCodeNameJsonList(String shidoValue){
		System.out.println(shidoValue);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");	
	    mav.addObject("WeatherCodeName",service.getWeatherCodeName(shidoValue)); 
		return mav;
	
	}
	
	@RequestMapping("/forecastweather.do")
	public ModelAndView forecastweather(){		
		ModelAndView mav = new ModelAndView();
		List<Weather_Forecast> forecastweatherData = service.forecastweather();
		mav.setViewName("pageJsonReport");
	    mav.addObject("forecastweatherData",forecastweatherData); 
	    return mav;
	}
	@RequestMapping("/weatherRealTIme.do")
	public ModelAndView weatherRealTImeJsonList(String weatherFordate){
		System.out.println(weatherFordate);
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("pageJsonReport");				
		mav.addObject("weatherRealTIme",service.getWeatherRealTIme(weatherFordate));		
		return mav;
	}
	
}