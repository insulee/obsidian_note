```dataview
TABLE file.link AS "파일명", file.size AS "크기 (bytes)", file.mtime AS "마지막 수정일"
FROM "10_RnD/11_Project/PRJ250601-11-DB300 Converter/5_Deliverables/Firmware"
WHERE file.ext = "bin" AND contains(file.name, "DB300")
SORT file.mtime DESC
```
```dataview
TABLE file.link AS "파일명", file.size AS "크기 (bytes)", file.mtime AS "마지막 수정일"
FROM "20. 브랜드마케팅팀/21. Project/!!TSK/doing/bin"
WHERE file.ext = "bin"
SORT file.mtime DESC
```
```dataview
TABLE file.link, file.ext
FROM "20. 브랜드마케팅팀/21. Project/!!TSK/doing/bin"
```

```dataviewjs
// Obsidian Vault API를 통해 볼트 내의 모든 파일 가져오기
let allFiles = app.vault.getFiles();

// 원하는 경로와 조건에 맞는 파일들만 필터링합니다.
// - 경로 시작: "10_RnD/11_Project/PRJ250601-11-DB300 Converter/5_Deliverables/Firmware/"
// - 확장자: "bin"
// - 파일 이름에 "DB300" 포함
let filteredFiles = allFiles.filter(file =>
    file.path.startsWith("10_RnD/11_Project/PRJ250601-11-DB300 Converter/5_Deliverables/Firmware/") &&
    file.extension === "bin" &&
    file.name.includes("DB300")
);

// 마지막 수정일 (mtime)을 기준으로 내림차순 정렬합니다.
filteredFiles.sort((a, b) => b.stat.mtime - a.stat.mtime);

// 결과 테이블 생성
dv.table(
    ["파일명", "크기 (bytes)", "마지막 수정일"], // 열 헤더
    filteredFiles.map(file => [
        dv.fileLink(file.path), // 파일 링크 (파일명)
        file.stat.size,         // 파일 크기 (bytes)
        moment(file.stat.mtime).format("YYYY-MM-DD HH:mm:ss") // 마지막 수정일 (읽기 쉬운 형식)
    ])
);
```
```dataviewjs
// Obsidian Vault API를 통해 볼트 내의 모든 파일 가져오기
let allFiles = app.vault.getFiles();

// 대상 폴더 경로 설정 (옵시디언에서 복사한 정확한 경로를 사용)
const targetFolderPath = "20. 브랜드마케팅팀/21. Project/!!TSK/doing/bin/"; 

// 경로, 확장자, 파일 이름 조건에 맞는 파일들만 필터링합니다.
let filteredFiles = allFiles.filter(file =>
    file.path.startsWith(targetFolderPath) && // 정확한 경로로 시작하는지 확인
    file.extension === "bin" &&                 // 확장자가 "bin"인지 확인
    file.name.includes("DB300")               // 파일 이름에 "DB300"이 포함되는지 확인
);

// 마지막 수정일 (mtime)을 기준으로 내림차순 정렬합니다.
filteredFiles.sort((a, b) => b.stat.mtime - a.stat.mtime);

// 결과 테이블 생성
dv.table(
    ["파일명", "크기 (bytes)", "마지막 수정일"], // 열 헤더
    filteredFiles.map(file => [
        dv.fileLink(file.path), // 파일 링크 (파일명)
        file.stat.size,         // 파일 크기 (bytes)
        moment(file.stat.mtime).format("YYYY-MM-DD HH:mm:ss") // 마지막 수정일 (읽기 쉬운 형식)
    ])
);
```

