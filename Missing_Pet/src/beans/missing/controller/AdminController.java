package beans.missing.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.missing.dao.AdminDAO;
import beans.missing.dao.UserDAO;
import beans.missing.vo.PetVO;
import beans.missing.vo.UserVO;


@WebServlet("/admin")
public class AdminController extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		AdminDAO dao = new AdminDAO();
		UserDAO userDao= new UserDAO();
		
		if (action.equals("admin")) {// 회원 전체 목록 조회

			String pageNo = request.getParameter("page");

			// 페이지 요청 파라미터 얻어오기
			int page;
			if (pageNo == null) {
				page = 1; // 페이지 요청이 없었을 시 기본페이지를 1페이지로 하겠음.
			} else {
				page = Integer.parseInt(pageNo);
			}

			List<UserVO> list = dao.select_user_info(page);
			
			int totalPage = dao.select_user_total_page();
			
			request.setAttribute("list", list);
			request.setAttribute("page", page);// 현재 페이지 (1페이지,2페이지)
			request.setAttribute("totalPage", totalPage);// 전체페이지 수

			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user_list.jsp");
			rd.forward(request, response);
			
		} else if (action.equals("edit")) {// 1. 수정폼 회원정보 조회
			String id = request.getParameter("id");

			request.setAttribute("user", dao.select_update_info(id));
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user_detail.jsp");
			rd.forward(request, response);
			
		} else if (action.equals("update")) {// 2. DB 수정기능
			String id = request.getParameter("id");
			String black = request.getParameter("black");
			
			Map<String, String> map = new HashMap<>();
				map.put("id", id);
				map.put("black", black);
				
			if (dao.update_black_info(map)) {
				response.sendRedirect("/admin?action=admin");
			}
			
		} else if (action.equals("delete")) {// 회원 삭제
			String id = request.getParameter("id");
			
			if (dao.delete(id)) {
				response.sendRedirect("/admin?action=admin");
			}
			
		} else if (action.equals("pet")) {// 강아지 분실 리스트 조회
			String pageNo = request.getParameter("page");
			System.out.println("pageNo>>>"+pageNo);

			// 페이지 요청 파라미터 얻어오기
			int page;
			if (pageNo == null) {
				page = 1; // 페이지 요청이 없었을 시 기본페이지를 1페이지로 하겠음.
			} else {
				page = Integer.parseInt(pageNo);
			}

			List<PetVO> list = dao.select_pet_list(page);
			
			int totalPage = dao.select_wit_total_Page();
			
			request.setAttribute("list", list);
			request.setAttribute("page", page);// 현재 페이지 (1페이지,2페이지)
			request.setAttribute("totalPage", totalPage);// 전체페이지 수

			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/missing_list.jsp");
			rd.forward(request, response);
			
		} else if(action.equals("wit")) {//신고 강아지 정보 조회
			String pageNo = request.getParameter("page");

			// 페이지 요청 파라미터 얻어오기
			int page;
			if (pageNo == null) {
				page = 1; // 페이지 요청이 없었을 시 기본페이지를 1페이지로 하겠음.
			} else {
				page = Integer.parseInt(pageNo);
			}

			List<PetVO> list = dao.select_wit_list(page);
			
			int totalPage = dao.select_wit_total_Page();
			
			request.setAttribute("list", list);
			request.setAttribute("page", page);// 현재 페이지 (1페이지,2페이지)
			request.setAttribute("totalPage", totalPage);// 전체페이지 수

			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/wit_list.jsp");
			rd.forward(request, response);
		}else if(action.equals("search_user")) { //회원 검색

			List<UserVO> list = userDao.search_user(request.getParameter("search_id"));//리턴이 List
			request.setAttribute("list", list);

			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/user_list.jsp");
			rd.forward(request, response);
		}
	}//service
	
	
}
