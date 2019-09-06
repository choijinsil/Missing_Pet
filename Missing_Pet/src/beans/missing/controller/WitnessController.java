package beans.missing.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import beans.missing.dao.WitnessDAO;
import beans.missing.vo.PetVO;
import beans.missing.vo.WitnessVO;

@WebServlet("/wit")
public class WitnessController extends HttpServlet {
	
	ArrayList<String> nameList;
	int count=0;
	String pathList="";
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		WitnessDAO dao = new WitnessDAO();
		
		if(action ==null || action.equals("wit")) { //목격자 정보입력페이지 이동
			
			String missing_no = request.getParameter("missing_no");
			String place = request.getParameter("missing_place");
				String latitude = place.split(",")[0];
				String longitude = place.split(",")[1];
			
			request.setAttribute("latitude", latitude);
			request.setAttribute("longitude", longitude);
			request.setAttribute("missing_no", missing_no);
			
			RequestDispatcher rd = request.getRequestDispatcher("/views/common/map.jsp");
			rd.forward(request, response);
			
		}else if(action.equals("witpet")) {
			
			System.out.println("목격지 마커의 주소값>>>"+request.getParameter("addr"));
			
			String lalt=request.getParameter("latLng");
			 int idx=lalt.indexOf(",");
			 int idx2=lalt.indexOf(")");
			String la=lalt.substring(1, idx)+",";
			String lt=lalt.substring(idx+2, idx2);
				 System.out.println("경도값>>>"+la);
				 System.out.println("경도값>>>"+lt);
				 
			request.getSession().setAttribute("addr", request.getParameter("addr"));
			request.getSession().setAttribute("latLng",la+lt);
			RequestDispatcher rd = request.getRequestDispatcher("/views/common/wit_pet.jsp");
			rd.forward(request, response);
			
			
			
		} else if(action.equals("fileUp")) { //목격자 정보입력페이지-목격자가 정보입력완료 버튼을 눌렀을때
			String id = (String) request.getSession().getAttribute("loginId");
			
			String realPath=request.getServletContext().getRealPath("/images/witimage");
			  //String realPath="E:\\ldh\\workspace3\\DVDInfor\\WebContent\\images\\witimage";
			
			  //src="/images/witimage/이미지명"
				String img1Path="";
				String img2Path="";
				String img3Path="";
			
			Date date = null;	
			
			File dir=new File(realPath);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			int sizeLimit=15*1024*1024;
			
			MultipartRequest multipartRequest=new MultipartRequest(request, realPath,sizeLimit,"utf-8",new DefaultFileRenamePolicy());
			
			String no = multipartRequest.getParameter("missing_no");
			
			Enumeration fileNames=multipartRequest.getFileNames();
				
			String date_s=multipartRequest.getParameter("wit_date")+" "+multipartRequest.getParameter("wit_time");
				System.out.println(date_s);
			SimpleDateFormat dt=new SimpleDateFormat("yyyy-mm-dd hh:mm");//wit_pet.jsp에서 발견날짜,발견시간을 불러와서 포맷을 지정
			
			try {
				 date=dt.parse(date_s);
				 System.out.println("parse한 포맷>>"+date);
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			
			nameList=new ArrayList<String>();
			
			while(fileNames.hasMoreElements()) {
				
			 	String file=(String)fileNames.nextElement();
			 	String file_name=multipartRequest.getFilesystemName(file);
			 	System.out.println("file_name>>"+file_name);
			 	
			 	if(file_name!=null) {
			 		nameList.add(count,"/images/witimage"+"/"+ file_name);//업로드한 파일을 읽어와서 List에 저장(최대 3개)
			 		
					if(count<2) {	
					 	pathList+=nameList.get(count)+",";	 
					 	count++;
					}else if(count==2) {
						pathList+=nameList.get(count);
					}
			 	}
			}//while	
			
			count=0;
				
			//회원 id에 대한 정보를 받아와야함.
			//user>map.jsp에서 클릭한 동물에대한 missing_no값을 받아와야함.
				
				WitnessVO wVO=new WitnessVO(pathList,date,(String)request.getSession().getAttribute("latLng"),multipartRequest.getParameter("comment"),id,Integer.parseInt(no)); 
				//목격자 테이블에 들어갈 정보를담은 vo ===>끝에 파라미터인자 2개는 map.jsp에저장되어있는 실종동물테이블에서 정보를 받아와야함
				pathList="";
				WitnessDAO wDAO=new WitnessDAO();
					try {
						if(wDAO.witInfor_insert(wVO)==null)
							System.out.println("DB입력성공!!!");
							WitnessVO firstVO=wDAO.printData();
							System.out.println("발견장소>>>>"+request.getSession().getAttribute("addr"));
							
							
							String missing_pic=firstVO.getMissing_pic();
							
							request.getSession().setAttribute("nameList", nameList);
							
							request.getSession().setAttribute("witInfor_insert",firstVO);
							response.sendRedirect("/main?action=main");//저장된 VO위치정보로 마커표시하기, ajax로 wit_info.jsp띄어서 등록한 목격정보 띄우기
																		   // 목격마커 숨기기(실종마커 클릭했을때 missing_no와 일치하는 목격마커 띄우기)
					} catch (SQLException e) {
						e.printStackTrace();
					}						
					
		}//action="fileUp" 
	
	}//service
}
