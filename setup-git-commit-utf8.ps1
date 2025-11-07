# Git UTF-8 커밋 편의 기능 설정 스크립트
# 이 스크립트는 Git alias와 PowerShell 함수를 설정합니다

Write-Host "Git UTF-8 커밋 편의 기능 설정 중..." -ForegroundColor Cyan

# 1. Git alias 설정 (git commit-utf8 명령어)
$gitAliasScript = @"
#!/bin/sh
# Git alias for UTF-8 commit message
commit_msg_file=`$(mktemp)
echo `"`$@`" > `"`$commit_msg_file`"
git commit -F `"`$commit_msg_file`"
rm `"`$commit_msg_file`"
"@

# Windows에서는 Git alias가 복잡하므로 PowerShell 함수 사용 권장
Write-Host "`n방법 1: PowerShell 함수 사용 (권장)" -ForegroundColor Yellow
Write-Host "프로필에 다음 함수를 추가합니다..." -ForegroundColor Gray

$functionCode = @'

# Git UTF-8 커밋 함수 (간단 버전)
function git-commit-utf8 {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [switch]$Amend
    )
    
    $commitMsgFile = Join-Path $env:TEMP "git_commit_msg_$(Get-Date -Format 'yyyyMMddHHmmss').txt"
    try {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($commitMsgFile, $Message, $utf8NoBom)
        
        if ($Amend) {
            git commit --amend -F $commitMsgFile
        } else {
            git commit -F $commitMsgFile
        }
    }
    finally {
        if (Test-Path $commitMsgFile) {
            Remove-Item $commitMsgFile -Force -ErrorAction SilentlyContinue
        }
    }
}

# 짧은 별칭 (선택사항)
Set-Alias -Name gcm -Value git-commit-utf8 -Scope Global -ErrorAction SilentlyContinue

'@

# 프로필에 함수 추가
$profilePath = $profile
$profileDir = Split-Path $profilePath -Parent

if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

$existingContent = ""
if (Test-Path $profilePath) {
    $existingContent = Get-Content $profilePath -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
}

if ($existingContent -match "function git-commit-utf8") {
    Write-Host "⚠ 이미 git-commit-utf8 함수가 프로필에 있습니다." -ForegroundColor Yellow
    Write-Host "수동으로 업데이트하시겠습니까? (y/n): " -NoNewline -ForegroundColor Yellow
    $response = Read-Host
    if ($response -eq 'y') {
        # 기존 함수 제거하고 새로 추가
        $lines = Get-Content $profilePath -Encoding UTF8
        $newLines = @()
        $skip = $false
        foreach ($line in $lines) {
            if ($line -match "function git-commit-utf8") {
                $skip = $true
            }
            if ($skip -and $line -match "^}$" -and $newLines[-1] -match "Remove-Item") {
                $skip = $false
                continue
            }
            if (-not $skip) {
                $newLines += $line
            }
        }
        $newLines += ($functionCode -split "`n")
        $newLines | Out-File -FilePath $profilePath -Encoding UTF8 -Force
        Write-Host "✓ 프로필 업데이트 완료" -ForegroundColor Green
    }
} else {
    if ($existingContent) {
        Add-Content -Path $profilePath -Value "`n`n$functionCode" -Encoding UTF8
    } else {
        $functionCode | Out-File -FilePath $profilePath -Encoding UTF8 -Force
    }
    Write-Host "✓ 프로필에 함수 추가 완료" -ForegroundColor Green
}

Write-Host "`n방법 2: 스크립트 파일 사용" -ForegroundColor Yellow
Write-Host "현재 디렉토리의 git-commit-utf8.ps1 스크립트를 사용할 수 있습니다." -ForegroundColor Gray
Write-Host "  .\git-commit-utf8.ps1 -Message `"커밋 메시지`"" -ForegroundColor Gray

Write-Host "`n사용 방법:" -ForegroundColor Cyan
Write-Host "  1. git-commit-utf8 `"커밋 메시지`"" -ForegroundColor White
Write-Host "  2. gcm `"커밋 메시지`"  (짧은 별칭)" -ForegroundColor White
Write-Host "  3. git-commit-utf8 `"커밋 메시지`" -Amend  (수정)" -ForegroundColor White

Write-Host "`n⚠ PowerShell을 재시작하거나 다음 명령어를 실행하세요:" -ForegroundColor Yellow
Write-Host "  . `$profile" -ForegroundColor White

Write-Host "`n✓ 설정 완료!" -ForegroundColor Green

