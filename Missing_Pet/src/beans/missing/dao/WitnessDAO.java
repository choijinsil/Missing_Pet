package beans.missing.dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

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

}
