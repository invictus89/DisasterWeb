## 재난-사고 알림 웹 서비스
재난-사고 알림 웹서비스를 지원하는 Web Server입니다.

## 목차
### 1. 기반
### 2. 개요
### 3. 기능
### 4. 구성
### 5. 특징

## 기반
* CSS / HTML / Javascript / jQuery / Spring Framework / mybatis / JSTL

## 개요
1. 파이썬 서버와 연동하여 SNS 특징을 이용한 실시간 알림
2. 수집되는 데이터를 기반으로 분석
3. 기계학습을 통한 예측  

## 기능
1. 실시간 알림
* 스크래핑 및 소켓통신을 통한 재난관련 News와 트위터 게시글 알림
2. 실시간 탭
* 지도 위에 지진 마커 표시 / 속도 그래프 출력
3. 분석 탭
* 각종 카테고리별 재난 데이터 시각화
4. 예측
* 내일의 재난 결과 예측

## 구성
### 시스템 전체 개발 구성도
client - server - database - python - client

### [augustProj/src/main/java/com/ac/augustProj]
mvc 패턴 기반의 웹 서버 구현
### [augustProj/src/main/resources]
데이터베이스 설정 및 SQL 구현 xml
### [augustProj/src/main/webapp]
클라이언트 단 구현

## 특징
1. 직관적인 시각화를 위한 Google Map과 Chart API 이용
2. SNS의 특징을 이용한 실시간 알림
