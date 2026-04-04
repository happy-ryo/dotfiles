# dotfiles

WezTerm の設定ファイル。Windows / macOS 両対応。

## セットアップ

### 1. フォントのインストール

```powershell
# Windows
winget install DEVCOM.JetBrainsMonoNerdFont
```

winget でインストールできない場合は [Nerd Fonts Releases](https://github.com/ryanoasis/nerd-fonts/releases) から `JetBrainsMono.zip` をダウンロードして手動でインストールしてください。

```bash
# macOS
brew install --cask font-jetbrains-mono-nerd-font
```

### 2. 設定ファイルの配置

```powershell
# Windows (PowerShell - 管理者権限)
git clone https://github.com/happy-ryo/dotfiles.git $HOME\dotfiles
New-Item -ItemType SymbolicLink -Path "$HOME\.wezterm.lua" -Target "$HOME\dotfiles\.wezterm.lua"
```

```bash
# macOS
git clone https://github.com/happy-ryo/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/.wezterm.lua ~/.wezterm.lua
```

## WezTerm 設定概要

| 項目 | 設定値 |
|------|--------|
| カラースキーム | Dracula (Official) |
| フォント | JetBrainsMono Nerd Font (14pt) |
| デフォルトシェル | pwsh (Win) / zsh (Mac) |
| 背景 | Mica (Win) / Blur (Mac) |

## ショートカット一覧

`Mod` = `Ctrl` (Windows) / `Cmd` (macOS)

### タブ

| キー | 操作 |
|------|------|
| `Mod + T` | 新規タブ |
| `Alt + 1~5` | タブ切替 |

### ペイン

| キー | 操作 |
|------|------|
| `Mod + D` | 水平分割 |
| `Mod + Shift + E` | 垂直分割 |
| `Mod + W` | ペインを閉じる |
| `Alt + ←↑↓→` | ペイン移動 |
| `Alt + Shift + ←↑↓→` | ペインリサイズ |

### 検索・ランチャー

| キー | 操作 |
|------|------|
| `Alt + L` | ランチメニュー (シェル選択) |
| `Mod + Shift + P` | コマンドパレット |
| `Mod + Shift + F` | スクロールバック検索 |

### コピー・ペースト

| キー | 操作 |
|------|------|
| `Mod + C` | コピー |
| `Mod + V` | ペースト |

### フォントサイズ

| キー | 操作 |
|------|------|
| `Mod + =` | 拡大 |
| `Mod + -` | 縮小 |
| `Mod + 0` | リセット |
