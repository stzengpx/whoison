#!/bin/bash
# Smoke tests for whoison. Run: make test
set -u
cd "$(dirname "$0")/.." || exit 1
BIN=bin/whoison
fail=0
pass() { echo "ok   - $1"; }
bad()  { echo "FAIL - $1"; fail=1; }

bash -n "$BIN" && pass "syntax" || bad "syntax"

"$BIN" --version | grep -q '^whoison [0-9]' && pass "--version" || bad "--version"
"$BIN" --help | grep -q 'Usage' && pass "--help" || bad "--help"
"$BIN" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && pass "unknown flag exits 2" || bad "unknown flag exits 2"

out=$("$BIN"); rc=$?
[ $rc -eq 0 ] && pass "exit 0" || bad "exit 0"
for h in "螢幕前" "已登入" "SSH 連線" "只剩背景程式"; do
  echo "$out" | grep -q "$h" && pass "section: $h" || bad "section: $h"
done
me=$(stat -f '%Su' /dev/console)
echo "$out" | grep -q "螢幕前：$me" && pass "console user matches /dev/console" || bad "console user"

exit $fail
