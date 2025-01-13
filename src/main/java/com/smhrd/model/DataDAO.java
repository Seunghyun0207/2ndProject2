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
            dataList = session.selectList("com.smhrd.db.Mapper.getAllData");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return dataList;
    }
}