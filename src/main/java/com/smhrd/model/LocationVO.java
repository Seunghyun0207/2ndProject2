package com.smhrd.model;

import org.apache.ibatis.annotations.Mapper;

public class LocationVO {
	private int l_post_idx;
    private String l_post_nm; // 제목
    private String l_post_content; // 내용
    private int l_post_like;
    private double latitude; // 위도
    private double longitude; // 경도
    private String user_id;  // 사용자 ID 추가
    private int party_idx;   // 모임방 인덱스 추가


    // Getter & Setter
    public int getL_post_idx() {
        return l_post_idx;
    }

    public void setL_post_idx(int l_post_idx) {
        this.l_post_idx = l_post_idx;
    }

    public int getL_post_like() {
        return l_post_like;
    }

    public void setL_post_like(int l_post_like) {
        this.l_post_like = l_post_like;
    }
    
    public String getL_post_nm() {
        return l_post_nm;
    }

    public void setL_post_nm(String l_post_nm) {
        this.l_post_nm = l_post_nm;
    }

    public String getL_post_content() {
        return l_post_content;
    }

    public void setL_post_content(String l_post_content) {
        this.l_post_content = l_post_content;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getParty_idx() {
        return party_idx;
    }

    public void setParty_idx(int party_idx) {
        this.party_idx = party_idx;
    }
}

