# CoinTracker
<img src = "https://file.notion.so/f/f/6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971/a21c74c4-1bc0-4926-bdb0-c101d02359b6/Apple_iPhone_Xs_Max_Presentation_(1)_%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB_2.jpg?table=block&id=120e9da4-b740-80e2-ac67-df0fba022a40&spaceId=6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971&expirationTimestamp=1737460800000&signature=LVBUZB6dsfOeDSazNQv7qW7MtZpiFGmuB0sfKTY4eO0&downloadName=Apple+iPhone+Xs+Max+Presentation+%281%29+%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB+2.jpg" />
API를 이용한 coin시세 Tracking앱<br><br>

실시간 가격, 변동폭 표시<br>
실시간 시가총액에 따른 순위 표시<br>
흑백 테마 변경 가능<br>
<a href="https://youtube.com/shorts/GF8x7Xl29nQ?feature=share">
    <img src="[https://file.notion.so/f/f/6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971/4f7d8290-b6b7-4684-a39e-1d514a8558fc/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2025-01-21_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_3.02.27.png](https://file.notion.so/f/f/6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971/4f7d8290-b6b7-4684-a39e-1d514a8558fc/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2025-01-21_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_3.02.27.png?table=block&id=182e9da4-b740-809c-9653-fa310b1d727e&spaceId=6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971&expirationTimestamp=1737468000000&signature=7Yyb1wYRMKOAdvI2Si5qSoS7UUYG6W_MQwdSbddm2WU&downloadName=%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2025-01-21+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+3.02.27.png)" 
         alt="영상" class="custom-image">
</a>

<style>
    .custom-image {
        width: 300px;
        height: auto; /* 비율 유지 */
    }
</style>
### Detail
- Restful API, WebSocket을 APP에 연동<br>
  - RestfulAPI를 이용해 정적데이터를 수신, WebSocket을 이용해 실시간 데이터를 갱신
  - viewLogic구현
- Async/Await를 활용해 Thread블럭 방지<br>
  - 네트워크 요청과 데이터 디코딩 작업을 비동기 처리
  - Thread가 죽는걸 방지
- WebSocket을 코인 거래데이터를 수신하는데 사용
  - JSON형식 디코딩 후 main thread에서 UI업데이트
  - 연결 실패시 세션 닫고 리소스 해제, reconnect과정 구현

