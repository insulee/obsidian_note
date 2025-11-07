(참고) [[mtPaint 사용법]]
### 주요 메뉴 설명
#### View
- **아래의 내용을 체크**
- ![[mtpaint1.png]]
	- Show Main Toolbar
	- Show Tools Toolbar
	- Show Dock
	- Show Palette
	- Show Status Bar
	- Centeralize Image
	- Show Zoom Grid
#### Image
- Scale Canvas
	- 설명: 그린 이미지가 동일한 비율로 확대
	- Fix Aspect Ratio: 종횡비 고정
- Resize Canvas
	- 설명: 이미지는 유지되고 캔버스의 크기만 조절
	- Offset: 캔버스 내 원본 이미지 위치 지정
	- Fix Aspect Ratio: 종횡비 고정
	- Clear: 새로 추가된 영역이 배경색으로 채워짐
#### Palette
- Edit Colour A & B(Ctrl+E): A/B 컬러 지정
- Palette Editor: Palette index 변경
#### ToolBar
- New Image: 새로운 이미지 만들기
- Load Image File: 이미지 불러오기
- Save Image File: 이미지 저장하기
- Paint: 그리기
- Flood Fill: 채우기
- Straight Line: 직선 그리기
- Paste Text: 텍스트 입력

### (예시) 간단한 그림 그리기 
- File > New > 
	- Width/Height 지정
	- Colours: 256
	- Indexed Palette 선택
	- Undoable 체크: Export undoImage 사용시 선택
- Palette > Edit Colour A & B(Ctrl+E) > A/B 컬러 지정
	- 또는 왼쪽 palette 바에서 마우스 윈/오른쪽 클릭으로 선택
- Settings Toolbar > Size 두께 조절
- 이미지 확대를 해서 그리기 편하게 조정
- ToolBar > Paint 선택해서 이미지 그림
	- Flood Fill, Straight Line 이용해서 편하기 그리기 가능

### (예시) 글씨 입력하기
- File > New > 
	- Width/Height 지정
	- Colours: 256
	- Indexed Palette 선택
	- Undoable 체크: Export undoImage 사용시 선택
- 이미지 확대를 해서 그리기 편하게 조정
- ToolBar > Paste Text
	- 폰트, 스타일, 사이즈 선택
	- Preview에 글자 입력 > Paste Text

### (예시) 자동차 그림 생성 후 불러오기
- ![[car_64x64.bmp]]
- File > Open > 파일선택 > Ok