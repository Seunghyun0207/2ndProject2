package com.smhrd.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.smhrd.db.SqlSessionManager;

public class JoinRequestDAO {
    private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

    // 신청 정보 저장
    public int insertJoinRequest(JoinRequestVO joinRequest) {
        SqlSession session = sqlSessionFactory.openSession(true); // Auto-commit
        int result = 0;
        try {
            result = session.insert("com.smhrd.db.Mapper.insertJoinRequest", joinRequest);
        } finally {
            session.close();
        }
        return result;
    }

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
    
    // 가입 상태 업데이트 메서드
    public int updateJoinRequestStatus(int partyIdx, String userId, char agreeYn) {
        SqlSession session = sqlSessionFactory.openSession(true); // Auto-commit
        int result = 0;
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("partyIdx", partyIdx);
            params.put("userId", userId);
            params.put("agreeYn", agreeYn);

            result = session.update("com.smhrd.db.Mapper.updateJoinRequestStatus", params);
        } finally {
            session.close();
        }
        return result;
    }
}