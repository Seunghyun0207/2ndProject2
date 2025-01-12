package com.smhrd.model;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.SqlSessionManager;

public class PartyDAO {
	private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	// 모든 모임 가져오기 (모임 찾기)
	public List<PartyVO> selectAllParties(String userRegion) {
		SqlSession session = sqlSessionFactory.openSession();
		List<PartyVO> partyList = null;
		try {
			partyList = session.selectList("com.smhrd.db.Mapper.selectAllParties", userRegion);
		} finally {
			session.close();
		}
		return partyList;
	}

	// 내가 가입한 모임 가져오기 (나의 모임)
	public List<PartyVO> selectMyParties(String userId) {
		SqlSession session = sqlSessionFactory.openSession();
		List<PartyVO> myPartyList = null;
		try {
			myPartyList = session.selectList("com.smhrd.db.Mapper.selectMyParties", userId);
			if (myPartyList == null || myPartyList.isEmpty()) {
				System.out.println("No parties found for user: " + userId);
			} else {
				for (PartyVO party : myPartyList) {
					if (party == null) {
						System.out.println("Null party object found!");
					} else {
						System.out.println("Party name: " + party.getPartyNm()); // Log party name
					}
				}
			}
		} finally {
			session.close();
		}
		return myPartyList;
	}

	// 지역에 맞는 모임 목록 가져오기
	public List<PartyVO> selectPartiesByRegion(String userRegion) {
		SqlSession session = sqlSessionFactory.openSession();
		List<PartyVO> partyList = null;
		try {
			partyList = session.selectList("com.smhrd.db.Mapper.selectPartiesByRegion", userRegion);
		} finally {
			session.close();
		}
		return partyList;
	}

	// 모임 방 생성
	public int insertParty(PartyVO party) {
		SqlSession session = sqlSessionFactory.openSession(true); // Auto-commit
		int cnt = 0;
		try {
			System.out.println("Inserting party: " + party.getPartyNm() + ", Info: " + party.getPartyInfo()); // 디버그 로그
																												// 추가
			// 모임 삽입
			cnt = session.insert("com.smhrd.db.Mapper.insertParty", party);
			// 생성된 partyIdx 값 확인
			System.out.println("Generated partyIdx: " + party.getPartyIdx()); // 자동 생성된 partyIdx 출력
			return party.getPartyIdx(); // 자동 생성된 partyIdx 반환
		} finally {
			session.close();
		}
	}

	// 특정 모임 방 정보 가져오기
	public PartyVO selectPartyById(int partyIdx) {
		SqlSession session = null;
		try {
			session = SqlSessionManager.getSqlSession().openSession();
			return session.selectOne("com.smhrd.db.Mapper.selectPartyById", partyIdx);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (session != null) {
				session.close(); // 세션 닫기
			}
		}
	}

	// 모임 방에 가입된 회원 수 가져오기
	public int getMemberCount(int partyIdx) {
		SqlSession session = sqlSessionFactory.openSession();
		int count = 0;
		try {
			count = session.selectOne("com.smhrd.db.Mapper.getMemberCount", partyIdx);
		} finally {
			session.close();
		}
		return count;
	}

	// 모임방 정보 수정
	public int updateParty(PartyVO party) {
	    String sql = "UPDATE tb_party SET party_nm = ?, party_info = ?, party_region = ?, party_file = ?, party_notice = ? WHERE party_idx = ?";
	    try (Connection conn = SqlSessionManager.getSqlSession().openSession().getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        // 디버깅 출력
	        System.out.println("Updating party with partyNotice: " + party.getPartyNotice()); // partyNotice 출력

	        pstmt.setString(1, party.getPartyNm());
	        pstmt.setString(2, party.getPartyInfo());
	        pstmt.setString(3, party.getPartyRegion());
	        pstmt.setString(4, party.getPartyFile());
	        pstmt.setString(5, party.getPartyNotice());  // partyNotice 값 설정
	        pstmt.setInt(6, party.getPartyIdx());

	        int result = pstmt.executeUpdate();
	        conn.commit(); // 반드시 커밋 호출
	        return result;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

	// 모임방 삭제
	public int deleteParty(int partyIdx, String userId) {
	    SqlSession session = null;
	    try {
	        // 세션 열기 (openSession()을 사용)
	        session = SqlSessionManager.getSqlSession().openSession();  // 세션을 openSession()으로 열어줍니다.

	        // 파라미터 맵 생성
	        Map<String, Object> params = new HashMap<>();
	        params.put("partyIdx", partyIdx);
	        params.put("userId", userId);

	        // 디버깅: 파라미터 값 확인
	        System.out.println("Deleting party with ID: " + partyIdx + " and user ID: " + userId);

	        // MyBatis 쿼리 실행
	        int result = session.delete("com.smhrd.db.Mapper.deleteParty", params);

	        // 삭제 후 커밋
	        session.commit();

	        // 로그로 결과 출력
	        System.out.println("Number of deleted records: " + result);

	        return result;
	    } catch (Exception e) {
	        e.printStackTrace();
	        if (session != null) {
	            session.rollback();  // 오류가 나면 롤백
	        }
	    } finally {
	        if (session != null) {
	            session.close();  // 세션 종료하여 자원 반납
	        }
	    }
	    return 0;  // 삭제되지 않으면 0 반환
	}
	
	public boolean updateParty(int partyIdx, String partyTitle, String partyDescription, String partyRegion,
			String fileName, String partyNotice) {

		return false;
	}

	// 기존 파일명을 가져오는 메서드
	public String getExistingFileName(int partyIdx) {
		String sql = "SELECT party_file FROM tb_party WHERE party_idx = ?";
		try (Connection conn = SqlSessionManager.getSqlSession().openSession().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, partyIdx);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString("party_file"); // 기존 파일명 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 파일명이 없을 경우 null 반환
	}

	public PartyVO selectPartyByIdx(int partyIdx) {
		SqlSession session = sqlSessionFactory.openSession();
		PartyVO party = null;
		try {
			party = session.selectOne("com.smhrd.db.Mapper.selectPartyByIdx", partyIdx);
		} finally {
			session.close();
		}
		return party;
	}

	public int insertJoinRequest(String userId, int partyIdx, String joinIntro, char agreeYn) {
		SqlSession session = sqlSessionFactory.openSession(true); // Auto-commit
		int result = 0;
		try {
			JoinRequestVO joinRequest = new JoinRequestVO(userId, partyIdx, joinIntro, agreeYn);
			result = session.insert("com.smhrd.db.Mapper.insertJoinRequest", joinRequest);
		} finally {
			session.close();
		}
		return result;
	}

	// 특정 모임의 회원 목록 가져오기
	public List<UserVO> getMembersByPartyIdx(int partyIdx) {
		SqlSession session = sqlSessionFactory.openSession();
		List<UserVO> members = null;
		try {
			members = session.selectList("com.smhrd.db.Mapper.selectMembersByPartyIdx", partyIdx);
		} finally {
			session.close();
		}
		return members;
	}

	// 특정 모임의 회원들의 자기소개글 가져오기
	public List<String> getJoinIntroByPartyIdx(int partyIdx) {
		SqlSession session = sqlSessionFactory.openSession();
		List<String> introList = null;
		try {
			introList = session.selectList("com.smhrd.db.Mapper.selectJoinIntroByPartyIdx", partyIdx); // 자기소개글 조회
		} finally {
			session.close();
		}
		return introList;
	}
}
