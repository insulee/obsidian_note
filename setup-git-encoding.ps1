# Git 한글 인코딩 설정 스크립트

# Git 저장소 확인
if (-not (Test-Path ".git")) {
    Write-Host "오류: 현재 디렉토리가 Git 저장소가 아닙니다." -ForegroundColor Red
    exit 1
}

# Git 인코딩 설정 (전역)
git config --global i18n.commitEncoding utf-8
git config --global i18n.logOutputEncoding utf-8
git config --global core.quotepath false

# Git 인코딩 설정 (저장소별)
git config --local i18n.commitEncoding utf-8
git config --local i18n.logOutputEncoding utf-8
git config --local core.quotepath false
git config --local gui.encoding utf-8

# PowerShell 인코딩 설정 (현재 세션)
# 전문가 분석: $OutputEncoding이 git commit -m에 문자열을 전달할 때 사용됨 (핵심!)
$utf8 = New-Object System.Text.UTF8Encoding
[Console]::InputEncoding = $utf8  # PowerShell이 입력을 받을 때
[Console]::OutputEncoding = $utf8  # 콘솔에 출력할 때
$OutputEncoding = $utf8  # 외부 프로그램(git)에 데이터를 전달할 때 (가장 중요!)
chcp 65001 | Out-Null
$env:LC_ALL = 'C.UTF-8'
$env:LESSCHARSET = 'UTF-8'

# PowerShell 프로필 영구 설정
$profilePath = $profile
$profileContent = @'
# Git 한글 인코딩 설정
# 전문가 분석: $OutputEncoding이 git commit -m에 문자열을 전달할 때 사용됨 (핵심!)
$utf8 = New-Object System.Text.UTF8Encoding
[Console]::InputEncoding = $utf8
[Console]::OutputEncoding = $utf8
$OutputEncoding = $utf8
chcp 65001 | Out-Null
$env:LC_ALL = 'C.UTF-8'
$env:LESSCHARSET = 'UTF-8'
'@

if (Test-Path $profilePath) {
    $existingContent = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue
    if ($existingContent -match 'Git 한글 인코딩 설정') {
        # 기존 설정을 새로운 설정으로 교체
        $lines = Get-Content $profilePath
        $startIndex = -1
        $endIndex = -1
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -match '# Git 한글 인코딩 설정') {
                $startIndex = $i
            }
            if ($startIndex -ge 0 -and $lines[$i] -match "^'@") {
                $endIndex = $i
                break
            }
        }
        if ($startIndex -ge 0 -and $endIndex -ge 0) {
            $before = if ($startIndex -gt 0) { $lines[0..($startIndex-1)] } else { @() }
            $after = if ($endIndex -lt ($lines.Count - 1)) { $lines[($endIndex+1)..($lines.Count-1)] } else { @() }
            $newContent = $before + ($profileContent -split "`n") + $after
            $newContent | Out-File -FilePath $profilePath -Encoding UTF8 -Force
        }
    } else {
        Add-Content -Path $profilePath -Value "`n`n$profileContent" -Encoding UTF8
    }
} else {
    $profileDir = Split-Path $profilePath -Parent
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    $profileContent | Out-File -FilePath $profilePath -Encoding UTF8 -Force
}

Write-Host "✓ Git 한글 인코딩 설정 완료" -ForegroundColor Green
