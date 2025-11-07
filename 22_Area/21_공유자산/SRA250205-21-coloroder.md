---
share_link: https://share.note.sx/xjpafcvl#+fD+I6fAV9ayofh9ZUSIO468jZtgTAPmUtcQnX9Kxks
share_updated: 2025-02-06T08:04:27+09:00
---

---
#### 고장 혹은 문의에 대한 상세한 설명
- HEX 코드로 패킷전송 중 글자색상 부분에서 아래와 같이 표출
	- 파랑: 0x02
	- 자주색: 0x03
	- 녹색: 0x04
	- 노랑: 0x05



---
### 원인 분석 및 해결 방안

 
![[inf_빛의삼원색.png|300]]


| Color Code | [RGB] 매핑      | [RBG] 매핑      |
| ---------- | ------------- | ------------- |
| (100)      | 01H (Red)     | -             |
| (010)      | 02H (Green)   | 02H (Blue)    |
| (110)      | 03H (Yellow)  | 03H (Magenta) |
| (001)      | 04H (Blue)    | 04H (Green)   |
| (101)      | 05H (Magenta) | 05H (Yellow)  |
| (011)      | 06H (Cyan)    | -             |
| (111)      | 07H (White)   | -             |

- 원인
	- RGB 매핑과 RBG 매핑의 차이는 G <-> B가 바뀐다는 점
	- 그로 인해 Yellow, Magenta 코드도 바뀌어 색상이 다르게 표현
- 해결방안
	- 표출신호 설정 창 > Color Order에서 현재 설정되어 있는 순서에서 G <-> B 인 옵션을 선택해 전송