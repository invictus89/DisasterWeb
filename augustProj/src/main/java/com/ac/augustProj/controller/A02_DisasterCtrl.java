package com.ac.augustProj.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ac.augustProj.service.A01_DisasterService;
import com.ac.augustProj.vo.AreaAnalysis;
import com.ac.augustProj.vo.Earthquake_Forecast;
import com.ac.augustProj.vo.Realtime;
import com.ac.augustProj.vo.Weather_Forecast;


@Controller
public class A02_DisasterCtrl {
	@Autowired(required=false)
	private A01_DisasterService service;

	@RequestMapping("/getMapJson.do")
	public ModelAndView realtimeJsonList(Realtime rt){	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		Object realtime = service.getRealtime(rt);
		mav.addObject("realtime",realtime); 
		return mav;
	}
	@RequestMapping("/getMapJsonCurrent.do")
	public ModelAndView getMapJsonCurrent(){	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		Object realtime = service.getCurrentRt();
		mav.addObject("realEq_ctrl",realtime); 
		return mav;
	}

	
	@RequestMapping("/getAreaJson.do")
	public ModelAndView areaAnalysisJsonList(){
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");

		Object areaanalysis = service.getAreaAnalysis();
	    mav.addObject("areaanalysis",areaanalysis); 
		return mav;
	
	}
	
	
	@RequestMapping("/getShelterJson.do")
	public ModelAndView shelterJsonList(){
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		
		Object shelter = service.getShelter();
		mav.addObject("shelter",shelter); 
		
		return mav;
	}
	
	@RequestMapping("/getNoticeJson.do")
	public ModelAndView realtimeNoticeJsonList(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		mav.addObject("notice",service.getNotice());
		return mav;
	}
	
	@RequestMapping(value="/clickmonth_detail.do", method=RequestMethod.POST)
	public ModelAndView clickmonth_detail(String select_month){
		ModelAndView mav = new ModelAndView();
		List<Realtime> month_detail = service.month_detail(select_month);
		mav.setViewName("pageJsonReport");
		mav.addObject("month_detail",month_detail);
		mav.addObject("select_month",select_month);
		return mav;
	}
	
	@RequestMapping(value="/clickYear_detail.do", method=RequestMethod.POST)
	public ModelAndView clickYear_detail(String select_year){
		ModelAndView mav = new ModelAndView();
		List<Realtime> year_detail = service.year_detail(select_year);
		mav.setViewName("pageJsonReport");
		mav.addObject("year_detail",year_detail);
		mav.addObject("select_year",select_year);
		return mav;
	}
	
	@RequestMapping("/getPerHour.do")
	public ModelAndView analyPerHour(){		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
	    mav.addObject("analy",service.getInfoPerHour()); 
		return mav;
	}
	
	@RequestMapping("/forecast.do")
	public ModelAndView forecastearthquake(){		
		ModelAndView mav = new ModelAndView();
		System.out.println("list만들기전입니다");
		List<Earthquake_Forecast> forecastEdata = service.forecastearthquake();
		System.out.println("list만들기");
		mav.setViewName("pageJsonReport");
	    mav.addObject("forecastEdata",forecastEdata); 
		System.out.println(forecastEdata);
	    return mav;
	}	
	
	@RequestMapping("/getShelterAreaForPreferencen.do")
	public ModelAndView shelterAreaForPreferenceJsonList(String test){
		System.out.println(test);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pageJsonReport");
		mav.addObject("ShelterAreaForPreference",service.getShelterAreaForPreference(test));
		return mav;
	}
	

	
}