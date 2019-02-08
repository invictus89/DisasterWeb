package com.ac.augustProj.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ac.augustProj.service.*;
import com.ac.augustProj.vo.EarthYear;
import com.ac.augustProj.vo.EarthquakeCount;
import com.ac.augustProj.vo.Realtime;
import com.ac.augustProj.vo.ShelterCount;
import com.ac.augustProj.vo.Shelter_accommodate;
@Controller
public class A01_PageCtrl {
	@Autowired(required=false)
	private A01_DisasterService service;
	@Autowired(required=false)
	private A02_WeatherService wservice;
	@RequestMapping("/intro.do")
	public String start(HttpSession ses, Model d){
		ses.invalidate();
		return "a00_intro";
	}

	@RequestMapping("/mainProc.do")
	public String move(@RequestParam("midPage") String midPage,
			@RequestParam("leftPage") String leftPage, Model d,HttpSession ses){
		if(midPage.equals("wanaly") & leftPage.equals("weather")){
			//흐림지수& 날씨 데이터 갯수 & 강수량 평균 구하기
			String rainyday = wservice.countRainyday();
			float manyweatherS = wservice.countManyS();
			float avgRainAmount = wservice.avgRainAmount();
			int countDataWeather = wservice.countDataWeather();
			d.addAttribute("rainyday",rainyday);
			d.addAttribute("manyweather",manyweatherS);
			d.addAttribute("avgRainAmount",avgRainAmount);
			d.addAttribute("countDataWeather",countDataWeather);
		}
		if(midPage.equals("analy") & (leftPage.equals("earthquake") || (leftPage.equals(null)))){
			List<EarthYear> earthYear = service.yearList();
			d.addAttribute("earthYear", earthYear);
			List<EarthYear> earthMonth = service.monthList();
			d.addAttribute("earthMonth", earthMonth);
			
			List<EarthquakeCount> earthquakecount = service.earthquakecount();
			d.addAttribute("earthquakecount", earthquakecount);
			
			List<ShelterCount> sheltercount = service.sheltercount();
			d.addAttribute("sheltercount", sheltercount);
			
			//총 지진 횟수
			int total_num_eq = service.total_num_eq();
			d.addAttribute("total_num_eq",total_num_eq);
			
			//총 대피소 횟수
			int total_num_sh = service.total_num_sh();
			d.addAttribute("total_num_sh",total_num_sh);
			
			//지진 평균
			String avg_eq = service.avg_eq();
			d.addAttribute("avg_eq",avg_eq);
			System.out.println(avg_eq);
			
			//지진 MAX
			String max_eq = service.max_eq();
			d.addAttribute("max_eq",max_eq);

			//지진 MIN
			String min_eq = service.min_eq();
			d.addAttribute("min_eq",min_eq);
			
			//지진 데이터 보유량
			int has_num_eq = service.has_num_eq();
			d.addAttribute("has_num_eq",has_num_eq);
			
			//Graph07 - 인구수 그래프 
			List<Shelter_accommodate> shelter_accommodate = service.shelter_accommodate();
			int [] population = { 1518040,12479061,3334524,2680294,1502881,2466052,
					1538394,3448737,9904312,204088,1166615,2890451,1799044,1834114,605619,2107802,1589347};
			d.addAttribute("shelter_accommodate", shelter_accommodate);
			d.addAttribute("population", population);
			System.out.println(population[0]);
		}
		ses.setAttribute("midPage", midPage);
		ses.setAttribute("leftPage", leftPage);
		return "a01_main";
	}
}
