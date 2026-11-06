# Tile Launcher dev 2.1.11 (78) 진단 시험

Option을 처음 감지한 위치로 오버레이를 여는 변경과 메뉴 누락 진단이 포함된 시험본입니다.
Numbers Help 클릭 누락의 근본 수정이 완료된 빌드는 아닙니다. 정식은2.1.10입니다.

## 전체 순서

Homebrew 업데이트 → 정상 종료 후 진단 인자로 새 실행 → Numbers 세 동작 비교 → 정상 종료 후 로그 확인.

1. brew update 와 brew upgrade --cask colah16/tap/tile-launcher@dev 를 실행합니다.
   같은 채널 upgrade는 기존 appdir와 설정을 유지합니다. --zap을 사용하지 않습니다.
2. 앱이 실행 중이면 메뉴바 오른쪽 클릭 → 종료를 사용합니다. 강제 종료는 필요하지 않습니다.
   그다음 아래와 같이 새 프로세스로 실행합니다.

    open -g "$(brew --caskroom colah16/tap/tile-launcher@dev)/2.1.11,78/Tile Launcher.app" --args --menu-capture-log

   이미 실행 중인 앱에 인자만 보내면 진단이 켜지지 않을 수 있습니다.
3. 실행 직후 Numbers에서 같은 명령을 일반 메뉴 클릭, Help 검색 결과 클릭, Help 검색 Enter로 각각 선택합니다.
   내보내기 자체를 완료할 필요는 없습니다. 이미 등록된 명령의 존재만 보지 말고 최근 순서/관찰 횟수의 변화도 확인합니다.
   Option을 누른 직후 커서를 이동해도 처음 위치를 기준으로 열리는지 별도로 확인합니다.
4. 메뉴바 오른쪽 클릭 → 종료로 로그를 마무리합니다. 최근 로그 파일 경로는 아래 명령으로 확인합니다.

    find "$(getconf DARWIN_USER_TEMP_DIR)" -maxdepth 1 -type f -name 'tile-launcher-menu-capture-*' -mmin -15 -print

   생성된 고유 로그 파일을 대화에 첨부하면 실패 단계를 분석할 수 있습니다.
   로그에는 검색어/메뉴 제목/문서·창 내용/키 문자열/원시 좌표가 없고 enum/개수/불리언/상대 시간만 있습니다.
   최대10분/1MiB/200건·pending한도로 일부 기록이 생략될 수 있으며 자동 전송하지 않습니다.
