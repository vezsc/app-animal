package controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import data.animal.AnimalResponse;
import util.AnimalAPI;


public class ChartControllerCopy extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//데이터 처리를 해주는 작업이 들어갈꺼고
		String[] de=new String[] {"20230418","20230417","20230416","20230415","20230414"};
		for(String d : de) {
		AnimalResponse response=AnimalAPI.getAnimals(null, null, null, d,d);
		int total=response.getBody().getTotalCount();
	//	System.out.println(total);
		}
		
		//처리결과를 setAttribute
		Map<String,Object> map =new LinkedHashMap<>(); 
		map.put("labels", de);
		Map<String,Object>item =new LinkedHashMap<>();	
		item.put("label", "발생건수");
		item.put("data",new int[] {33,15,2,3,4});
		List<Map> li =List.of(item);
			
		Gson gson =new Gson();
		map.put("datasets", li);
		
		String mapJSON =gson.toJson(map);
		req.setAttribute("mapJSON", mapJSON);
		
		
		//뷰로 제어를 넘기는
		req.getRequestDispatcher("/WEB-INF/views/chart.jsp").forward(req, resp);
		
	}
}
