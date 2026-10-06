# whoison

> Show who is **actually** using a shared macOS workstation — not the stale list `who` gives you.

在多人快速切換帳號（Fast User Switching）的 Mac 上，`who` / `w` / `last` 讀的是 utmpx 紀錄，
帳號被強制登出或程式當掉時紀錄不會被清掉，所以常常列出早就不在的人。
`whoison` 改看即時的程式狀態，告訴你現在真正的情況。

## Example

```
$ whoison
🖥  螢幕前：alice
👥 已登入（GUI）：
   - alice
🔌 SSH 連線：
   - bob@ttys010
⚙️  只剩背景程式（未登入）：
   - carol（15 個程式）
   - bob（43 個程式）
```

## How it works

| Section | Source | Why it's reliable |
|---|---|---|
| 螢幕前 (console user) | `stat -f '%Su' /dev/console` | Owner of the console device = whoever has the screen |
| 已登入 (GUI sessions) | live `loginwindow` processes | macOS runs one per logged-in GUI user; it exits on logout |
| SSH 連線 | live `sshd-session: user@tty` processes | Exists only while the session is open |
| 只剩背景程式 | `ps -U <user>` for local users (UID ≥ 500) without a `loginwindow` | Shows leftover daemons/agents of logged-out users |

No root required.

## Install

```bash
git clone https://github.com/stzengpx/whoison.git
cd whoison
make install            # copies bin/whoison to ~/bin (override: make install PREFIX=/usr/local)
```

Make sure `~/bin` is on your `PATH`:

```bash
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
```

## Usage

```
whoison             # show status
whoison --help
whoison --version
```

## Development

```bash
make lint     # shellcheck (brew install shellcheck)
make test     # smoke tests
```

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Requirements

- macOS (uses `dscl`, BSD `stat`, and `loginwindow`; tested on macOS 26)
- bash 3.2+

## License

[MIT](LICENSE)
