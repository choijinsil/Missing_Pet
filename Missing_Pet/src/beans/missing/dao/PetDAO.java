package beans.missing.dao;


import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import beans.missing.vo.PetVO;
import iba.MySqlMapClient;

public class PetDAO {
	
	SqlMapClient smc;
	
	public PetDAO() {
		smc = MySqlMapClient.getSqlMapInstance();
	}
	
	public boolean register(PetVO vo) {
		try {
			smc.insert("pet.register", vo);
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public PetVO select_pet(int no) {
		
		try {
			return (PetVO) smc.queryForObject("pet.select_pet", no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	

	//<!--MYPAGE.JSP 회원MISSING삭제 -->
	public int delete_mymissing(int no) {
		try {
			return smc.delete("pet.delete_mymissing", no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	

	
}
