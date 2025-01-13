package com.smhrd.model;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class UserDAO {
    private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
    
    // 회원가입
    public int insertUser(UserVO user) {
        SqlSession session = sqlSessionFactory.openSession();
        int cnt = 0;

        try {
            cnt = session.insert("com.smhrd.db.Mapper.insertUser", user);
            if (cnt > 0) {
                session.commit();
            } else {
                session.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }

        return cnt;
    }

    // 로그인
    public UserVO loginUser(String userId, String userPw) {
        SqlSession session = sqlSessionFactory.openSession();
        UserVO user = null;
        try {
            // 파라미터를 Map으로 생성
            Map<String, Object> params = new HashMap<>();
            params.put("userId", userId);
            params.put("userPw", userPw);

            // selectOne 호출
            user = session.selectOne("com.smhrd.db.Mapper.loginUser", params);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return user;
    }
    // 사용자 정보 조회
    public UserVO selectUserById(String userId) {
        SqlSession session = sqlSessionFactory.openSession();
        UserVO user = null;
        try {
            user = session.selectOne("com.smhrd.db.Mapper.selectUserById", userId);
        } finally {
            session.close();
        }
        return user;
    }

    // 사용자 정보 수정
    public int updateUser(UserVO user) {
        SqlSession session = sqlSessionFactory.openSession(true); // Auto-commit
        int cnt = 0;
        try {
            cnt = session.update("com.smhrd.db.Mapper.updateUser", user);
        } finally {
            session.close();
        }
        return cnt;
    }

    // 사용자 정보 삭제
    public int deleteUser(String userId) {
        SqlSession session = sqlSessionFactory.openSession(true); // Auto-commit
        int cnt = 0;
        try {
            cnt = session.delete("com.smhrd.db.Mapper.deleteUser", userId);
        } finally {
            session.close();
        }
        return cnt;
    }
    
    // 아이디 중복 확인
    public boolean checkDuplicateId(String userId) {
        SqlSession session = sqlSessionFactory.openSession();
        boolean exists = false;
        try {
            int count = session.selectOne("com.smhrd.db.Mapper.checkDuplicateId", userId);
            exists = count > 0;
        } finally {
            session.close();
        }
        return exists;
    }
}