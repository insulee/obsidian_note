_(MQTT Server ↔ MQTT‑to‑Serial Converter DB300eM)_

> **필수 준수 사항** : 본 문서는 장치 ↔ 서버 호환을 위한 "단일 소스 규격서"입니다. **어떤 항목도 생략하거나 변형하지 말고 그대로 구현**하십시오.

---

## API 서버

| 구분                 | 값                                                                             |
| -------------------- | ------------------------------------------------------------------------------ |
| **URL**              | <https://port-0-mqttservertest-m46korurac9025e4.sel4.cloudtype.app/>           |
| **Firmware URL**     | <https://port-0-mqttservertest-m46korurac9025e4.sel4.cloudtype.app/brokerInfo> |
| **Mosquitto broker** | `mosquitto -c "C:\mosquitto\config\mosquitto.conf" -v`                         |

---

## 1. 개요

- **목적** : 서버와 DB300eM (ESP32) 간 제어·관리를 **MQTT** 로 수행하며, 명령·응답은 **Key‑Value JSON** 객체 형식으로 교환한다.
- **특징**
  1. 모든 MQTT 메시지는 **JSON** 객체
  2. **MOID**(Management Object ID) 또는 파라미터명을 Key 로, 실제 데이터(상태·설정)를 Value 로 매핑
  3. `json["MOID"]` 접근이 가능하여 로직 작성·유지보수가 용이

---

## 2. MQTT 토픽

| 구분     | 토픽          | Publish  | Subscribe |
| -------- | ------------- | -------- | --------- |
| **명령** | `igw/tsc/dev` | **서버** | **장치**  |
| **응답** | `feedback.20` | **장치** | **서버**  |

---

## 3. 메시지 흐름

1. **서버** → 명령 토픽으로 JSON 명령 Publish
2. **장치(ESP32)** 는 명령 토픽 Subscribe 중에 메시지 수신
3. 장치가 명령 실행 후 응답 토픽으로 결과 JSON Publish
4. **서버** 는 응답 토픽 Subscribe 중이므로 결과를 비동기로 수신

---

## 4. JSON 공통 필드

| 필드          | 설명                                                                                                                                |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `MSG_TYPE`    | 요청: `GET` `SET` `REBOOT` `RESET` `FACTORY_RESET` …<br>응답: `RESP_GET` `RESP_SET` `RESP_REBOOT` `RESP_RESET` `RESP_FACTORY_RESET` |
| `MSG_ID`      | 요청·응답 매칭용 고유 ID (Timestamp·GUID 등)                                                                                        |
| `RESULT_CODE` | 0 = Success, 1 = Bad Request, 2 = Internal Error …                                                                                  |
| `RESULT_MSG`  | 오류 원인 문자열·배열 (성공 시 `null`)                                                                                              |
| `MOID`        | 기능별 ID, 예 `2.RTE058.3.4` — Key 로 사용, Value 에 데이터 매핑                                                                    |

---

## 5. 메시지 상세 사양

### 5‑1. 재부팅·초기화 (`REBOOT` / `RESET` / `FACTORY_RESET`)

#### Request

```json
{
  "MSG_TYPE": "REBOOT", // 또는 "RESET" / "FACTORY_RESET"
  "MSG_ID": 1349333576093,
  "REBOOT_TYPE": "RTE058" // 옵션
}
```

#### Response — Success

```json
{
  "MSG_TYPE": "RESP_REBOOT",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 0,
  "RESULT_MSG": null
}
```

#### Response — Fail

```json
{
  "MSG_TYPE": "RESP_REBOOT",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 2,
  "RESULT_MSG": "Device busy"
}
```

---

### 5‑2. 상태 조회 (`GET`)

#### Request

```json
{
  "MSG_TYPE": "GET",
  "MSG_ID": 1349333576093,
  "MOID": ["2.RTE058.2.1", "2.RTE058.2.2", "2.RTE058.2.3", "2.RTE058.2.5"]
}
```

#### Response — Success

```json
{
  "MSG_TYPE": "RESP_GET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 0,
  "RESULT_MSG": null,
  "RESULT": [
    { "2.RTE058.2.1": 1349333576 }, // 현재 시간(Unix Timestamp)
    { "2.RTE058.2.2": 50 }, // 밝기(0~100)
    { "2.RTE058.2.3": [6, 2, 0, 0] }, // 화면 설정(가로모듈, 세로모듈, 양면여부(0:단면, 1:양면), 배열방향(0:가로형, 1:세로형))
    { "2.RTE058.2.5": ["1.0.0", 1000] } // 펌웨어 버전, CPU 속도
  ]
}
```

#### Response — Fail

```json
{
  "MSG_TYPE": "RESP_GET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 1,
  "RESULT_MSG": [{ "2.RTE058.2.5": "Undefined MOID" }],
  "RESULT": null
}
```

---

### 5‑3. 일반 설정 (`SET`)

#### Request

```json
{
  "MSG_TYPE": "SET",
  "MSG_ID": 1349333576093,
  "MOID": [
    { "2.RTE058.3.1": 1349333576093 }, // 현재 시간(Unix Timestamp)
    { "2.RTE058.3.2": 50 }, // 밝기(0~100)
    { "2.RTE058.3.3": [6, 2, 0, 0] }, // 화면 설정(가로모듈, 세로모듈, 양면여부(0:단면, 1:양면), 배열방향(0:가로형, 1:세로형))
    { "2.RTE058.3.4": 1 } // 전원 ON(1)/OFF(0)
  ]
}
```

#### Response — Success

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 0,
  "RESULT_MSG": null,
  "RESULT": null
}
```

#### Response — Fail

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 1,
  "RESULT_MSG": [{ "2.RTE058.3.3": "Invalid value" }],
  "RESULT": null
}
```

---

### 5‑4. 이미지 파일 전송 (`SET`)

청크 전송 순서 `"start"` → `"data"`(반복) → `"end"`.

#### Request — 첫 청크 `"start"`

```json
{
  "MSG_TYPE": "SET",
  "MSG_ID": 1349333576093,
  "MOID": [
    { "2.RTE058.4.1": "start" }, // 파일 전송상태(start, data, end)
    { "2.RTE058.4.2.1": "flashing.bmp" }, // 이미지 파일명
    { "2.RTE058.4.2.2": "bmp" }, // 파일 유형
    { "2.RTE058.4.2.3": 123456 }, // 원본 이미지 전체 크기(Byte)
    { "2.RTE058.4.2.4": 1500 }, // 전송할 원본 이미지를 Base64로 인코딩한 청크 크기(Byte)
    { "2.RTE058.4.2.5": 83 }, // 전체 청크 개수
    { "2.RTE058.4.2.6": "d41d8cd98f00b204e9800998ecf8427e" }, // 전체 파일 MD5 체크섬 (32자 hex)
    { "2.RTE058.4.3.1": 0 }, // 청크 인덱스
    { "2.RTE058.4.3.2": "" } // 첫 청크는 데이터 없음
  ]
}
```

**필드 설명**

- `2.RTE058.4.1`: 전송 단계(start/data/end)
- `2.RTE058.4.2.x`: 파일 식별 정보 (파일명, 형식, 전체 크기, 청크 크기, 총 청크 수)
- `2.RTE058.4.3.x`: 개별 청크 정보 (인덱스, Base64 데이터)
- `2.RTE058.4.2.6`: 무결성 검증은 MD5 우선(수신 시 필수 비교) → 그다음 파일 크기 확인 순으로 수행하며, MD5가 없는 예외 상황에는 크기 검증만으로 전송 완료를 판단한다.

#### Response (모든 단계 동일) — Success

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 0,
  "RESULT_MSG": null,
  "RESULT": null
}
```

#### Response — Fail

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 1,
  "RESULT_MSG": [{ "2.RTE058.4.2.5": "Undefined MOID" }],
  "RESULT": null
}
```

---

### 5‑5. 이미지 스케줄/이펙트 (`SET`)

#### 5‑5‑A. 스케줄 명령 키워드

| 키워드   | 설명                                       |
| -------- | ------------------------------------------ |
| `set`    | 스케줄 **등록 또는 수정**                  |
| `list`   | 전체 스케줄 **목록 조회**                  |
| `clear`  | 모든 스케줄 및 이미지 파일일 **일괄 삭제** |
| `deploy` | 스케줄 및 이미지 파일 배포                 |

---

#### 5‑5‑B. 스케줄 등록·수정 (`set`)

##### Request

```json
{
  "MSG_TYPE": "SET",
  "MSG_ID": 1349333576093,
  "MOID": [
    { "2.RTE058.5.1": "set" }, //set/list/clear/deploy
    { "2.RTE058.5.2.1": "12345" }, // ID: 스케쥴 파일명으로 사용
    { "2.RTE058.5.2.2": "flashing.bmp" }, // bmp 이미지 파일명
    { "2.RTE058.5.2.3": "move_left" }, // 이미지 효과
    { "2.RTE058.5.2.4.1": 500 }, // 반복 간격(ms), 사용안함
    { "2.RTE058.5.2.4.2": 5000 }, // 유지 시간(ms), 사용안함
    { "2.RTE058.5.2.4.3": 50 }, // 이미지 효과 속도(0~100), 높은 값일수록 느리게 표시
    { "2.RTE058.5.2.4.4": 1 } // 이미지 효과 지연 시간(sec)
  ]
}
```

##### Response — Success

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 0,
  "RESULT_MSG": null,
  "RESULT": null
}
```

##### Response — Fail

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 1,
  "RESULT_MSG": [{ "2.RTE058.5.2.4.4": "Value out of range" }],
  "RESULT": null
}
```

---

#### 5‑5‑C. 스케줄 목록 조회 (`list`)

##### Request

```json
{
  "MSG_TYPE": "SET",
  "MSG_ID": 1349333576093,
  "MOID": [{ "2.RTE058.5.1": "list" }]
}
```

##### Response — Success

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 0,
  "RESULT_MSG": null,
  "RESULT": [
    { "2.RTE058.5.2.1": "12345" }, // 이미지 ID
    { "2.RTE058.5.2.2": "flashing.bmp" },
    { "2.RTE058.5.2.3": "move_left" }, // 이미지 효과
    { "2.RTE058.5.2.4.1": 500 }, // 반복 간격(ms), 사용안함
    { "2.RTE058.5.2.4.2": 5000 }, // 유지 시간(ms), 사용안함
    { "2.RTE058.5.2.4.3": 50 }, // 효과 속도(0~99)
    { "2.RTE058.5.2.4.4": 1 } // 지연 시간(sec)
  ],
  "RESULT": null
}
```

##### Response — Fail

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 2,
  "RESULT_MSG": "Internal error",
  "RESULT": null
}
```

---

#### 5‑5‑D. 스케줄 일괄 삭제 (`clear`)

##### Request

```json
{
  "MSG_TYPE": "SET",
  "MSG_ID": 1349333576093,
  "MOID": [{ "2.RTE058.5.1": "clear" }]
}
```

##### Response — Success

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 0,
  "RESULT_MSG": null,
  "RESULT": null
}
```

##### Response — Fail

```json
{
  "MSG_TYPE": "RESP_SET",
  "MSG_ID": 1349333576093,
  "RESULT_CODE": 1,
  "RESULT_MSG": [{ "2.RTE058.5.1": "Operation failed" }],
  "RESULT": null
}
```

---

## 6. 에러 코드(`RESULT_CODE`)

| Code | 의미                                 |
| ---: | ------------------------------------ |
|    0 | **Success** — 정상 처리              |
|    1 | **Bad Request** — MOID·파라미터 오류 |
|    2 | **Internal Error** — 장치 내부 예외  |
|   ≥3 | 프로젝트별 추가 정의 가능            |

### 6-1. 세부 에러 코드

MQTT 통신 중 발생하는 오류에 대한 세부 코드를 아래와 같이 정의합니다. 이 코드는 내부 처리용으로 사용되며 모든 세부 코드는 위의 `RESULT_CODE`로 매핑됩니다.

| Code | 매핑 | 의미                              |
| ---: | ---: | --------------------------------- |
|    0 |    0 | **정상 처리** (`MQTT_RX_SUCCESS`) |
|    1 |    1 | **일반 실패**(세부 원인 불명)     |
|  100 |    1 | **JSON 파싱 오류**                |
|  101 |    1 | **필수 키 누락**                  |
|  102 |    2 | **내부 처리 에러**(미분류)        |
|  103 |    1 | **알 수 없는 메시지 유형**        |
|  104 |    2 | **프로토콜 오류**                 |
|  105 |    1 | **알 수 없는 명령**               |
|  106 |    1 | **필드 값 유효성 오류**           |
|  107 |    2 | **MD5 체크섬 불일치**             |
|  108 |    2 | **BMP 파일 파싱 실패**            |
|  109 |    2 | **BMP → DAT 변환 실패**           |

### 6-2. 세부 에러 코드 매핑 원칙

1. **Bad Request(1)** 매핑 코드: 클라이언트 요청 오류(정보 누락, 형식 오류, 잘못된 값 등)
2. **Internal Error(2)** 매핑 코드: 서버/장치 내부 처리 오류(변환 실패, 체크섬 불일치 등)
3. 장치는 실제 응답에서 매핑된 `RESULT_CODE`(0, 1, 2)를 사용하나, 서버는 내부적으로 세부 코드를 활용하여 구체적인 오류 처리 가능

---

## 7. 구현 시 주의사항

1. **MSG_ID 일치** : 요청‑응답 간 동일 값 사용
2. **MOID 중복 금지** : 하나의 메시지에 동일 MOID 두 번 이상 포함 금지
3. **부분 실패 처리** : 다중 MOID 중 일부 실패 시 `RESULT_MSG` 배열에 실패‑MOID 별 원인 기재
4. **파일 전송** : 청크 크기·개수·지연 등은 요구사항에 맞춰 조정
5. **확장성** : 신규 기능은 `MSG_TYPE`·`MOID` 확장으로 추가, Key–Value 패턴 유지

---

## 8. 결론

- 모든 명령·응답은 `MSG_TYPE` `MSG_ID` `RESULT_CODE` `RESULT_MSG` 를 공통 포함하며, 실제 데이터는 `MOID` 로 전달한다.
- 서버와 장치 모두 본 사양을 **온전히 준수**해야 안정적인 통신이 가능하다.
- 차후 기능도 동일 JSON Key‑Value 구조를 사용하여 손쉽게 확장할 수 있다.

---
