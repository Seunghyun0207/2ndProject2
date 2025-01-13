package com.smhrd.model;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class DataDAO {
    private SqlSessionFactory sqlSessionFactory;

    // 기본 생성자에서 SqlSessionFactory 초기화
    public DataDAO() {
        this.sqlSessionFactory = SqlSessionManager.getSqlSession();
    }

    // 모든 데이터 가져오기 (여성용)
    public List<PartyVO> getAllData() {
        SqlSession session = sqlSessionFactory.openSession();
        List<PartyVO> dataList = null;

        try {
            // 여성 사용자 데이터만 가져오기
            dataList = session.selectList("com.smhrd.db.Mapper.getAllDataForFemale");
            System.out.println("가져온 데이터 크기: " + dataList.size());  // 데이터 크기 확인
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return dataList;
    }
}