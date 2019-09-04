package beans.missing.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import beans.missing.dao.PetDAO;
import beans.missing.vo.PetVO;

@WebServlet("/pet")
	 
public class PetController extends HttpServlet {

	PetDAO dao = new PetDAO();
	

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action.equals("registerForm")) {// main.jsp에서 동물등록 클릭시 register_pet.jsp로 이동
			RequestDispatcher rd = request.getRequestDispatcher("/views/user/register_pet.jsp");
			rd.forward(request, response);
			

		} else if (action.equals("map")) {// map.jsp로 이동

			String no = request.getParameter("no");
			request.getSession().setAttribute("vo", dao.select_pet(Integer.parseInt(no)));	
			
			request.getSession().setAttribute("vo", dao.select_pet(Integer.parseInt(no)));

			RequestDispatcher rd = request.getRequestDispatcher("/views/user/map.jsp");
			rd.forward(request, response);

		} else if (action.equals("register")) {// register_pet.jsp에서 실종동물 등록시 map.jsp로 이동
			String savePath = getServletContext().getRealPath("/") + "images";

			int maxSize = 10 * 1024 * 1024;
			MultipartRequest mreq = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		

			String id = (String) request.getSession().getAttribute("loginId");
			String place = mreq.getParameter("missing_place");
			String date = mreq.getParameter("missing_date");
			String time = mreq.getParameter("missing_time");
				SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd hh:mm");
				Date to = null;
				try {
					to = fm.parse(date +" " +time);
				} catch (ParseException e) {
					e.printStackTrace();
				}	
			
			String comment = mreq.getParameter("comment");
			String tip = mreq.getParameter("tip");
			String type = mreq.getParameter("type");
			

			String saveFileName1 = mreq.getFilesystemName("missing_pic1");
			String saveFileName2 = mreq.getFilesystemName("missing_pic2");
			String saveFileName3 = mreq.getFilesystemName("missing_pic3");
			

			String nameList = null;
			if(saveFileName2 == null && saveFileName3 == null) {
				nameList = "/images/" +saveFileName1;
				
			}else if(saveFileName3 == null) {
				nameList = "/images/" +saveFileName1 +"," +"/images/" +saveFileName2;
				
			}else {
				nameList = "/images/" +saveFileName1 +"," +"/images/" +saveFileName2 +"," +"/images/" +saveFileName3;
			
		
			PetVO vo = new PetVO(0, id, nameList, null, place, to, type, comment, tip, null, null);

			if (dao.register(vo)) {
				response.sendRedirect("/main?action=main");
			
		}}} else if (action.equals("delete_mymissing")) {

			// MISSING_NO(공고번호) 얻기
			int missing_no = Integer.parseInt(request.getParameter("missing_no"));
			System.out.println("missing_no>>" + missing_no);
			
			// 특정MISSING_NO(공고번호) 삭제 
			if(dao.delete_mymissing(missing_no)==1) {

			// 특정MISSING_NO(공고번호) 삭제
			if (dao.delete_mymissing(missing_no) == 1) {
				System.out.println("삭제 완료");
				// 리다이렉트이동
				RequestDispatcher rd = request.getRequestDispatcher("/main?action=user_mypost");
				rd.forward(request, response);
			} else {
				System.out.println("삭제 실패");
			}

		} else if (action.equals("register_upform")) {// 실종동물 등록 수정 이동

			// 정보가져오기
			String no = request.getParameter("missing_no");
			request.getSession().setAttribute("vo", dao.select_pet(Integer.parseInt(no)));

			// register_pet.jsp 로 이동
			RequestDispatcher rd = request.getRequestDispatcher("/views/user/register_upform.jsp");
			rd.forward(request, response);

		} else if (action.equals("register_update")) { // 실종동물 등록 수정 하기

			// register_pet.jsp에서 실종동물 등록시 map.jsp로 이동
			String savePath = getServletContext().getRealPath("/") + "images";

			int maxSize = 10 * 1024 * 1024;
			MultipartRequest mreq = new MultipartRequest(request, savePath, maxSize, "UTF-8",
					new DefaultFileRenamePolicy());

			int missing_no=Integer.parseInt(mreq.getParameter("missing_no"));
			String place = mreq.getParameter("missing_place");
			String date = mreq.getParameter("missing_date");
			String time = mreq.getParameter("missing_time");
			SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd hh:mm");
			Date to = null;
			try {
				to = fm.parse(date + " " + time);
			} catch (ParseException e) {
				e.printStackTrace();
			}

			String comment = mreq.getParameter("comment");
			String tip = mreq.getParameter("tip");
			String type = mreq.getParameter("type");

			String saveFileName1 = mreq.getFilesystemName("missing_pic1"); 
			String saveFileName2 = mreq.getFilesystemName("missing_pic2"); 
			String saveFileName3= mreq.getFilesystemName("missing_pic3");
			
						
			
			
		}else if(action.equals("register_upform")) {//등록 수정하기 
			String nameList = null;
			if (saveFileName2 == null && saveFileName3 == null) {
				nameList = "/images/" + saveFileName1;

			} else if (saveFileName3 == null) {
				nameList = "/images/" + saveFileName1 + "," + "/images/" + saveFileName2;

			} else {
				nameList = "/images/" + saveFileName1 + "," + "/images/" + saveFileName2 + "," + "/images/"
						+ saveFileName3;
			}
			
			// 정보가져오기  . 
			String no = request.getParameter("missing_no");
			System.out.println("no>>>>>>>>>>>>>"+no);
			request.getSession().setAttribute("vo", dao.select_pet(Integer.parseInt(no)));				
		
			
			//register_pet.jsp 로 이동 
			RequestDispatcher rd = request.getRequestDispatcher("/views/user/register_upform.jsp");
			rd.forward(request, response);	
			PetVO vo = new PetVO(missing_no, null, nameList, null, place, to, type, comment, tip, null, null);
			System.out.println("vo>>>"+vo	);
			 if(dao.update_pet_info(vo)) { 
				 response.sendRedirect("/main?action=main");
			 }else { 
				 System.out.println("업데이트 실패"); 
			 }
			 
		}
	

	}
	
}}}}}
