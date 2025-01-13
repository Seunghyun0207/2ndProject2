package com.smhrd.model;

import java.sql.Date;
import java.sql.Timestamp;

public class UserVO {
    private String userId;
    private String userPw;
    private String userName;
    private String userGender;
    private Date userAge;
    private String userRegion;
    private Timestamp joinedAt;
    private String intro;
    
 // 기본 생성자
    public UserVO() {}

    public UserVO(String userId, String userPw, String userName, String userGender, Date userAge, String userRegion, Timestamp joinedAt) {
        this.userId = userId;
        this.userPw = userPw;
        this.userName = userName;
        this.userGender = userGender;
        this.userAge = userAge;
        this.userRegion = userRegion;
        this.joinedAt = joinedAt;
    }
    public UserVO(String userId, String userPw, String userName, String userRegion) {
    	this.userId = userId;
    	this.userPw = userPw;
    	this.userName = userName;
    	this.userRegion = userRegion;
    }
    
    public UserVO(String userId, String userPw, String userName, String userGender, Date userAge, String userRegion) {
        this.userId = userId;
        this.userPw = userPw;
        this.userName = userName;
        this.userGender = userGender;
        this.userAge = userAge;
        this.userRegion = userRegion;
    }

    public UserVO(String userId, String userName) {
        this.userId = userId;
        this.userName = userName;
    }
    
    public UserVO(String userId, String userName, String intro) {
        this.userId = userId;
        this.userName = userName;
        this.intro = intro;
    }

    // Getter와 Setter
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getIntro() {
        return intro;
    }
    
    public void setIntro(String intro) {
        this.intro = intro;
    }

    public String getUserPw() {
        return userPw;
    }

    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public Date getUserAge() {
        return userAge;
    }

    public void setUserAge(Date userAge) {
        this.userAge = userAge;
    }

    public String getUserRegion() {
        return userRegion;
    }

    public void setUserRegion(String userRegion) {
        this.userRegion = userRegion;
    }

    public Timestamp getJoinedAt() {
        return joinedAt;
    }

    public void setJoinedAt(Timestamp joinedAt) {
        this.joinedAt = joinedAt;
    }
}
