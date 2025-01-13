package com.smhrd.model;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.smhrd.db.SqlSessionManager;

public class LocationDAO {
    private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

    // 위치 기반 글 저장 메서드
    public boolean insertLocationPost(LocationVO location) {
        SqlSession session = sqlSessionFactory.openSession();
        try {
            int result = session.insert("com.smhrd.db.Mapper.insertLocationPost", location);
            session.commit();
            return result > 0; // 삽입 성공 여부 반환
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
            return false;
        } finally {
            session.close();
        }
    }

    // 특정 위치 데이터 조회 메서드
    public Map<String, Object> getLocation(int postIdx) {
        SqlSession session = sqlSessionFactory.openSession();
        Map<String, Object> result = new HashMap<>();

        try {
            // MyBatis Mapper에서 SQL 실행
            result = session.selectOne("com.smhrd.db.Mapper.getLocation", postIdx);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return result;
    }

public LocationVO getLocationById(int locationIdx) {
    SqlSession session = sqlSessionFactory.openSession();
    LocationVO location = null;

    try {
        location = session.selectOne("com.smhrd.db.Mapper.getLocationById", locationIdx);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        session.close();
    }

    return location;
}

public List<LocationVO> getLocationsByPartyIdx(int partyIdx) {
    SqlSession session = sqlSessionFactory.openSession();
    try {
        return session.selectList("com.smhrd.db.Mapper.getLocationsByPartyIdx", partyIdx);
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    } finally {
        session.close();
    }
}
}
