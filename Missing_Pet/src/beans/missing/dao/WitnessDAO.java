package beans.missing.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import beans.missing.vo.PetVO;
import beans.missing.vo.WitnessVO;
import iba.MySqlMapClient;

public class WitnessDAO {

		SqlMapClient smc; 
	
	public WitnessDAO() {
		smc=MySqlMapClient.getSqlMapInstance();
	}

	public String witInfor_insert(WitnessVO vo) throws SQLException {//목격자가 목격창에서 정보입력-> DB저장
		
		return (String)smc.insert("wit.witInfor_insert",vo);
	}

	public WitnessVO printData() throws SQLException {
		return (WitnessVO) smc.queryForObject("wit.printData");
	}
		
	
	
	
	public List<WitnessVO> select_mywit(String id) {
		
		try {
			return (List<WitnessVO>) smc.queryForList("wit.select_mywit",id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
		

	
		public int delete_mywit(int no) {
			try {
				return smc.delete("wit.delete_mywit", no);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return 0;
		}
	
}
