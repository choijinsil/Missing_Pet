package beans.missing.dao;

import java.sql.SQLException;
import java.util.List;

import java.util.Map;
import com.ibatis.sqlmap.client.SqlMapClient;

import beans.missing.vo.PetVO;
import beans.missing.vo.UserVO;
import iba.MySqlMapClient;

public class UserDAO {
	

	SqlMapClient smc;
	

	public UserDAO() {
		smc = MySqlMapClient.getSqlMapInstance();
	}
	
	public boolean insert_user(UserVO vo) { // 회원 가입
		try {
			smc.insert("user.insert_user", vo);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean select_user(Map<String, String> map) { // 로그인시 회원조회
		try {
			int t = (Integer) smc.queryForObject("user.select_user", map);
			if (t == 1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("map>>" + map.get("id") + "," + map.get("pass"));
		return false;
	}

	// <!--MYPAGE.JSP 회원정보조회 -->
	public UserVO select_myinfo(String id) {
		try {
			return (UserVO) smc.queryForObject("user.select_myinfo", id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// <!--MYPAGE.JSP 회원MISSING정보조회 -->
	public List<PetVO> select_mymissing(String id) {
		try {
			return (List<PetVO>) smc.queryForList("pet.select_mymissing", id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// <!--MYPAGE.JSP 회원정보수정 -->
	public boolean update_myinfo(UserVO user) {
		try {
			if (smc.update("user.update_myinfo", user) == 1)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// <!--MYPAGE.JSP 회원MISSING귀가처리 -->
	public boolean update_mymissing(int missing_no) {
		try {
			if (smc.update("pet.update_mymissing", missing_no) != 0)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//main.jsp에 실종 동물 리스트 select
	public List<PetVO> pet_list () {
			
			List<PetVO> list = null;
			try {
				list = smc.queryForList("user.pet_list");
				return list;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return  list;
		}


	// 블랙리트스 조회하기
	public String select_black_user(String id) {
		try {
			return (String) smc.queryForObject("user.select_black_user", id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

}
