package com.smhrd.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.smhrd.db.SqlSessionManager;

public class JoinRequestDAO {
    private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

    // 특정 방 신청자 정보 조회
    public List<JoinRequestVO> selectJoinRequestsByPartyIdx(int partyIdx) {
        SqlSession session = sqlSessionFactory.openSession();
        List<JoinRequestVO> joinRequests = null;
        try {
            joinRequests = session.selectList("com.smhrd.db.Mapper.selectJoinRequestsByPartyIdx", partyIdx);
        } finally {
            session.close();
        }
        return joinRequests;
    }
    
    // 모임 가입 요청 저장
    public int insertJoinRequest(JoinRequestVO joinRequest) {
    	SqlSession session = sqlSessionFactory.openSession(true);
        int result = session.insert("com.smhrd.db.Mapper.insertJoinRequest", joinRequest);
        session.close();
        return result;
    }
    
    // 가입 요청 상태 업데이트
    public int updateJoinRequestStatus(String userId, int partyIdx, char agreeYn) {
    	SqlSession session = sqlSessionFactory.openSession(true);
        JoinRequestVO joinRequest = new JoinRequestVO(userId, partyIdx, null, agreeYn);
        int result = session.update("com.smhrd.db.Mapper.updateJoinRequestStatus", joinRequest);
        session.close();
        return result;
    }
    
    // 모임 가입 요청 조회
    public List<JoinRequestVO> getJoinRequestsByPartyIdx(int partyIdx) {
    	SqlSession session = sqlSessionFactory.openSession(true);
        List<JoinRequestVO> joinRequests = session.selectList("com.smhrd.db.Mapper.selectJoinRequestsByPartyIdx", partyIdx);
        session.close();
        return joinRequests;
    }
    
}