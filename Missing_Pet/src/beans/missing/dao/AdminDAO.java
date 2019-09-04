package beans.missing.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import beans.missing.vo.PetVO;
import beans.missing.vo.UserVO;
import iba.MySqlMapClient;

public class AdminDAO {

	SqlMapClient smc;
	
	public AdminDAO() {
		smc = MySqlMapClient.getSqlMapInstance();
	}
	
	public List<UserVO> select_user_info(int page) {
		try {
			return smc.queryForList("admin.select_user_info", 10*(page-1), 10);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	

	public Integer select_user_total_page() {
    	try {
			return (Integer) smc.queryForObject("admin.select_user_total_page");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
    }
	
	public Integer select_wit_total_Page() {//실종동물 토탈페이지
		try {
			return (Integer) smc.queryForObject("admin.select_wit_total_Page");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//업데이트 회원 정보 조회
	public UserVO select_update_info(String id) {
		try {
			return (UserVO) smc.queryForObject("admin.select_update_info", id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//회원 정보 수정
	public boolean update_black_info(Map<String,String> map) {
		try {
			int t=(Integer)smc.update("admin.update_black_info", map);
			if(t==1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//회원 삭제
	public boolean delete(String id) {
		try {
			if(smc.delete("admin.delete_user_info",id)==1) 
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	//분실 강아지 정보 조회
	public List<PetVO> select_pet_list(int page) {
		try {
			return smc.queryForList("admin.select_pet_list", 10*(page-1), 10);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//신고 강아지 정보 조회
	public List<PetVO> select_wit_list(int page) {
		try {

			return smc.queryForList("admin.select_wit_list", 10*(page-1), 10);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
