package beans.missing.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.missing.dao.UserDAO;
import beans.missing.dao.WitnessDAO;
import beans.missing.vo.PetVO;
import beans.missing.vo.UserVO;
import beans.missing.vo.WitnessVO;

@WebServlet("/main")
public class UserController extends HttpServlet {

	String loginId;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		UserDAO dao = new UserDAO();

		if (action == null || action.equals("main")) {// main.jsp 접속

			String pageNo = request.getParameter("page");
			int page;

			if (pageNo == null) {
				page = 1;
			} else {
				page = Integer.parseInt(pageNo);
			}

			request.getSession().setAttribute("list", dao.pet_list(page));
			request.getSession().setAttribute("page", page);// 현재 페이지 수

			// 총 페이지 구하기
			int totalPage = dao.total_page();
			request.getSession().setAttribute("totalPage", totalPage);// 전체 페이지 수

			RequestDispatcher rd = request.getRequestDispatcher("/views/common/main.jsp");
			rd.forward(request, response);

		} else if (action.equals("joinForm")) {// 회원 가입
			RequestDispatcher rd = request.getRequestDispatcher("/views/common/join.jsp");
			rd.forward(request, response);

		} else if (action.equals("join")) { // 회원가입 버튼 누르면
			UserVO vo = new UserVO(request.getParameter("id"), request.getParameter("name"),
					request.getParameter("pass"), request.getParameter("email"), request.getParameter("tel"),
					request.getParameter("address"), "N");

			if (dao.insert_user(vo)) {// 회원 가입 성공시
				response.sendRedirect("/main?action=main");
			} else {
				System.out.println("회원가입 실패");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('회원가입 실패 하였습니다!'); history.back();</script>");
				out.flush();
			}

		} else if (action.equals("loginForm")) {// 로그인 창으로 이동
			RequestDispatcher rd = request.getRequestDispatcher("/views/common/login.jsp");
			rd.forward(request, response);

		} else if (action.equals("login")) { // 로그인 시
			loginId = request.getParameter("id");
			String pass = request.getParameter("pass");

			Map<String, String> map = new HashMap<String, String>(); // sql문에 전달할 값
			map.put("id", loginId);
			map.put("pass", pass);

			if (dao.select_user(map) && "N".equals(dao.select_black_user(loginId))) {
				// id, pass가 맞고 블랙리스트값이 N인 경우 --로그인 성공!
				request.getSession().setAttribute("loginId", loginId);
				response.sendRedirect("/main?action=main");

			} else { // 로그인 실패시

				if ("Y".equals(dao.select_black_user(loginId))) {// 블랙리스트가 맞으면 로그인 실패
					response.setContentType("text/html; charset=utf-8");
					PrintWriter out = response.getWriter();
					out.println("<script>alert('회원님은 현재 블랙리스트 상태 입니다.'); history.back();</script>");
					out.flush();
					return;
				}
				// 아이디가 틀렸을 경우
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('로그인 실패 했지롱~! 다시해라!'); history.back();</script>");
				out.flush();
				return;
			}

		} else if (action.equals("loginOut")) {// 로그아웃
			request.getSession().invalidate();
			response.sendRedirect("/main?action=main");

		} else if (action.equals("user_mypage")) {
			/* MYPAGE이동 1. 회원정보조회 2. 회원MISSING정보조회 */

			// ID파라미터 SESSION영역에 저장 -> REDIRECT이동시 공유

			// 회원정보,회원MISSING정보 REQUEST객체 영역에 저장

			UserVO userlist = dao.select_myinfo(loginId);
			request.setAttribute("userlist", userlist);
			List<PetVO> missinglist = dao.select_mymissing(loginId);
			request.setAttribute("missinglist", missinglist);
			// FORWARD이동
			RequestDispatcher rd = request.getRequestDispatcher("/views/user/mypage.jsp");
			rd.forward(request, response);

		} else if (action.equals("update_myinfo")) {
			/* MYPAGE이동 1. 회원정보수정 */

			// 회원정보얻어오기
			UserVO user = new UserVO();
			user.setId(request.getParameter("id"));
			user.setPass(request.getParameter("pass"));
			user.setName(request.getParameter("name"));
			user.setEmail(request.getParameter("email"));
			user.setTel(request.getParameter("tel"));
			user.setAddress(request.getParameter("address"));
			user.setBlack(request.getParameter("black"));

			// 회원정보수정

			dao.update_myinfo(user);

			// 회원정보,회원MISSING정보 SESSION객체 영역에 저장
			UserVO userlist = dao.select_myinfo(loginId);
			request.getSession().setAttribute("loginId", loginId);

			HttpSession session = request.getSession();
			session.setAttribute("userlist", userlist);
			List<PetVO> missinglist = dao.select_mymissing(loginId);
			session.setAttribute("missinglist", missinglist);

			// 리다이렉트이동
			response.sendRedirect("/main?action=user_mypage");

		} else if (action.equals("update_mymissing")) {
			/* 회원MISSING정보업데이트-> 인계날짜 SYSDATE입력 */

			// ID와 MISSING_NO(공고번호) 얻기
			int missing_no = Integer.parseInt(request.getParameter("missing_no"));

			// 특정MISSING_NO(공고번호)의 인계날짜 SYSDATE입력

			if (dao.update_mymissing(missing_no)) {
				System.out.println("인계정보 수정 완료");
			} else {
				System.out.println("인계정보 수정 실패");
			}

			// 회원정보,회원MISSING정보 SESSION객체 영역에 저장
			UserVO userlist = dao.select_myinfo(loginId);
			HttpSession session = request.getSession();
			session.setAttribute("userlist", userlist);
			List<PetVO> missinglist = dao.select_mymissing(loginId);
			session.setAttribute("missinglist", missinglist);

			// 리다이렉트이동
			response.sendRedirect("/views/user/mypage.jsp");
		} else if (action.equals("user_mypost")) {

			// 내게시글 목록
			List<PetVO> missinglist = dao.select_mymissing(loginId);
			request.setAttribute("missinglist", missinglist);

			// 내 목격 글 목록 조회
			WitnessDAO wdao = new WitnessDAO();
			List<WitnessVO> witlist = wdao.select_mywit(loginId);
			request.setAttribute("witlist", witlist);

			// FORWARD이동
			RequestDispatcher rd = request.getRequestDispatcher("/views/user/mypost.jsp");
			rd.forward(request, response);
		} else if (action.equals("withdraw")) {// 회원탈퇴
			if (dao.withdraw_user(loginId)) {
				System.out.println("회원탈퇴되었다.");
				request.getSession().invalidate();
				response.sendRedirect("/main?action=main");
			}
		}
	}
}
