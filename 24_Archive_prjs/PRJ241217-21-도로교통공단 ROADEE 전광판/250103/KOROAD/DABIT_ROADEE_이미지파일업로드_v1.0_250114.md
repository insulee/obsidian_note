# **이미지 업로드 및 스케줄 관리 JSON 프로토콜**

## **개요**

본 문서는 MQTT 프로토콜을 통해 전광판에 이미지를 업로드하고, 업로드된 이미지를 스케줄링하여 표시하는 과정을 정의합니다. 이 프로토콜은 데이터 송수신을 표준화하며, 통신의 일관성과 확장성을 보장합니다.

---

## **1. 공통 필드 설명**

### **1.1 공통 키**

| 키 이름       | 설명                      | 데이터 타입 | 예시 값                            |
| ---------- | ----------------------- | ------ | ------------------------------- |
| `msg_type` | 메시지 유형                  | 문자열    | `IMAGE`, `SCHEDULE`             |
| `msg_ver`  | 프로토콜 버전                 | 숫자     | `20241028`                      |
| `msg_id`   | 메시지 고유 ID (UNIX 밀리초 포맷) | 숫자     | `1730011028000`                 |
| `moid`     | 메시지가 대상 장치를 나타내는 고유 식별자 | 문자열    | `2.RTE058.4`                    |
| `action`   | 수행할 작업                  | 문자열    | `start`, `data`, `set`          |
| `status`   | 작업 상태                   | 문자열    | `success`, `error`              |
| `code`     | 상태 코드 (HTTP 스타일 코드)     | 숫자     | `0, 1, -1 ~ -7`                 |
| `message`  | 설명 메시지                  | 문자열    | `Upload completed successfully` |

### **1.2 공통 데이터 형식**

- `msg_ver`와 `msg_id`는 정수형으로 처리되어 데이터 크기를 줄이고, 통일된 처리 방식 제공.
- `action`은 현재 수행 중인 작업을 나타내며, 동작에 따라 적절히 변경됩니다.

---

## **2. 이미지 업로드 프로토콜**

### **2.1 업로드 요청**

이미지 파일 업로드를 시작하는 요청을 보냅니다.

#### **요청 메시지**

```json
{
  "msg_type": "IMAGE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid":  {
	  "2.RTE058.4": {
		  "action": "start",
		  "file_info": {
		    "filename": "example_image.bmp",
		    "file_type": "bmp",
		    "file_size": 123456,
		    "chunk_size": 1500,
		    "total_chunks": 83
		}
  }
}
```

|필드명|설명|
|---|---|
|`filename`|업로드할 파일의 이름|
|`file_type`|파일 유형 (`bmp`, `gif` 등)|
|`file_size`|파일의 전체 크기(바이트 단위)|
|`chunk_size`|각 청크의 크기(바이트 단위)|
|`total_chunks`|전송될 전체 청크 개수|

---

### **2.2 데이터 전송**

파일 데이터를 청크 단위로 MQTT를 통해 전송합니다.

#### **요청 메시지**

```json
{
  "msg_type": "IMAGE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid": {
	  "2.RTE058.4": {
		  "action": "data", 
		  "chunk_info": {
		    "index": 1,
		    "total": 83
		  },
		  "file_data": "Base64_encoded_chunk_data"
	  }
  }
}
```

|필드명|설명|
|---|---|
|`chunk_info`|현재 청크 정보|
|`index`|전송 중인 청크의 인덱스 번호|
|`total`|전체 청크 개수|
|`file_data`|Base64로 인코딩된 이미지 데이터|

---

### **2.3 업로드 완료**

모든 청크 전송이 완료되었음을 알립니다.

#### **요청 메시지**

```json
{
  "msg_type": "IMAGE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid": {
	  "2.RTE058.4": {
		  "action": "end",
		  "status": "success",
		  "code": 0,
		  "message": "Upload completed successfully"
	  }
  }
}
```


### **2.4 공통 응답 구조**

모든 업로드 단계에서 응답은 아래 공통 구조를 따릅니다.

```json
{
  "msg_type": "IMAGE_RESPONSE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid": {
	  "2.RTE058.4": {
		  "action": "response_action",
		  "status": "success",
		  "code": 200,
		  "message": "Descriptive response message",
		  "details": {
		    "chunk_index": 1,
		    "total_chunks": 83
		  }
	  }
  }
}
```

- `response_action`: 응답과 관련된 작업(`start`, `data`, `end` 등).
- `details`: 작업에 대한 추가 정보를 포함(예: 청크 번호).
---

## **3. 이미지 스케줄 프로토콜**

### **3.1 스케줄 등록**

업로드된 이미지를 전광판에 표출하도록 스케줄을 등록합니다.

#### **요청 메시지**

```json
{
  "msg_type": "SCHEDULE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid": {
	  "2.RTE058.5": {
		  "action": "set",
      "schedule": [
        {
          "image_id": "12345",
          "filename": "example_image.bmp",
          "effect": "fade_in",
          "parameters": {
            "1": 500,
            "2": 1000,
            "3": 20,
            "4": 1000
          },
          "schedule_time": {
            "start": "2025-01-15T08:00:00Z",
            "end": "2025-01-15T20:00:00Z"
          }
        }
      ]
    }
  }
}
```

|필드명|설명|
|---|---|
|`schedule`|이미지 스케줄 목록|
|`image_id`|이미지 고유 ID|
|`effect`|이미지 효과|
|`parameters`|효과 속성 (`1`: 반복 간격, `2`: 유지 시간 등)|
|`schedule_time`|스케줄 시작 및 종료 시간|

---

### **3.2 스케줄 조회**

현재 등록된 스케줄 정보를 요청합니다.

#### **요청 메시지**

```json
{
  "msg_type": "SCHEDULE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid": {
	  "2.RTE058.5": {
		  "action": "get"
	  }
  }
}
```

---

### **3.3 스케줄 조회 응답**

등록된 스케줄 정보를 반환합니다.

#### **응답 메시지**

```json
{
  "msg_type": "SCHEDULE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid": {
	  "2.RTE058.5": {
		  "action": "get_response",
		  "status": "success",
		  "code": 0,
		  "message": "Current schedule retrieved successfully",
      "schedule": [
        {
          "image_id": "12345",
          "filename": "example_image.bmp",
          "effect": "fade_in",
          "parameters": {
            "1": 500,
            "2": 1000,
            "3": 20,
            "4": 1000
          },
          "schedule_time": {
            "start": "2025-01-15T08:00:00Z",
            "end": "2025-01-15T20:00:00Z"
          }
        }
      ]
    }
  }
}
```

---

### **3.4 스케줄 삭제**

특정 스케줄을 삭제하거나 모든 스케줄을 초기화합니다.

#### **요청 메시지**

```json
{
  "msg_type": "SCHEDULE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid": {
	  "2.RTE058.5": {
		  "action": "delete",
		  "delete_all": false,
		  "image_ids": ["12345"]
	  }
  }
}
```

#### **응답 메시지**

```json
{
  "msg_type": "SCHEDULE",
  "msg_ver": 20241028,
  "msg_id": 1730011028000,
  "moid": {
	  "2.RTE058.5": {
		  "action": "delete_response",
		  "status": "success",
		  "code": 0,
		  "message": "Schedule deleted successfully",
		  "details": [
		    {
		      "image_id": "12345",
		      "status": "success",
		      "message": "Deleted"
		    }
		  ]
	  }
  }
}
```

---

## **4. 장점**

1. **일관성**: 업로드 및 스케줄 작업 모두 공통된 구조와 키를 사용.
2. **확장성**: 새로운 속성과 동작을 손쉽게 추가 가능.
3. **효율성**: 간결한 데이터 구조로 전송 속도와 파싱 속도 최적화.

---

이 문서는 서버와 MQTT 컨버터 간의 데이터 통신을 표준화하여 구현의 일관성을 보장합니다. 추가 문의나 수정 요청이 있다면 언제든 연락 바랍니다.