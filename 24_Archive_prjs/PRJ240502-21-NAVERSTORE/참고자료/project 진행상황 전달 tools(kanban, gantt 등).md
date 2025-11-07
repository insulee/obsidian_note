
- Gantt
	- https://olait.tistory.com/10
	- https://kaminik.tistory.com/entry/%EC%98%B5%EC%8B%9C%EB%94%94%EC%96%B8-%EC%8B%AC%ED%99%94-Mermaid
	- 


```mermaid
gantt
    dateFormat  YYYY-MM-DD
    axisFormat  %d
    title       프로젝트 일정

    section 기획
    아이디어 수집         :done,    2024-05-01, 3d
    요구 사항 정의         :active, 2024-05-05, 5d

    section 개발
    초기 개발             :         2024-05-12, 5d
    추가 개발             :         2024-05-20, 7d

    section 테스트
    알파 테스팅           :         2024-05-01, 3d
```
```mermaid


gantt

title DB300E, DB320W sales

dateFormat  MM-DD
    axisFormat  %m/%d
tickInterval 1week
weekday monday

section 진행상태

	완료 : done, 06-09, 1d
	진행중 : active, 06-09, 1d
	할일 : 06-09, 1d
	중요한일 : crit, 06-09, 1d

section 판매준비

	제품판매처결정 :done, 05-01, 2d
	네이버 스토어 가입 : active, 05-07, 1d
	네이버 스토어 비즈니스 스쿨 : active, 05-07, 7d 


section 상세페이지작성

	제품출시: crit, 05-02, 14d
	상세페이지 레퍼런스: 05-13, 2d
	상세페이지 작성 : 05-13, 7d
	나중에 할일 :05-12, 30d


```


```mermaid
gantt
    dateFormat  YYYY-MM-DD
	title  Gantt
	
    section A section
    Completed task            :done,    des1, 2021-09-06,2021-09-08
    Active task               :active,  des2, 2021-09-09, 3d
    Future task               :         des3, after des2, 5d
    Future task2              :         des4, after des3, 5d

    section Critical tasks
    Completed task in the critical line :crit, done, 2021-09-06,24h
    Implement parser and jison          :crit, done, after des1, 2d
    Create tests for parser             :crit, active, 3d
    Future task in critical line        :crit, 5d
    Create tests for renderer           :2d
    Add to mermaid                      :1d

    section Documentation
    Describe gantt syntax               :active, a1, after des1, 3d
    Add gantt diagram to demo page      :after a1  , 20h
    Add another diagram to demo page    :doc1, after a1  , 48h

    section Last section
    Describe gantt syntax               :after doc1, 3d
    Add gantt diagram to demo page      :20h
    Add another diagram to demo page    :48h
	
	section test
	Active task 			: doc1, 2021-09-02, 2021-09-04
	
```

출처: [https://olait.tistory.com/10](https://olait.tistory.com/10) [이토록 쉬운 옵시디언:티스토리]