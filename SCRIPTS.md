# Container Management Scripts

便利なコンテナ管理スクリプト集

## スクリプト一覧

### ビルド関連
- `build-user-image.sh` - ユーザイメージをビルド（パスワード設定あり）
- `files/build-base-image.sh` - ベースイメージのみビルド（メンテナ用）

### コンテナ操作
- `start-container.sh` - コンテナを起動
- `stop-container.sh` - コンテナを停止（自動的に削除されます）
- `restart-container.sh` - コンテナを再起動

### その他
- `delete-image.sh` - ユーザイメージを削除
- `commit-container.sh` - コンテナの変更を新しいイメージとして保存
- `logs-container.sh` - コンテナのログを表示
- `shell-container.sh` - コンテナのシェルにアクセス

## ビルドの仕組み

このプロジェクトは2段階ビルドシステムを採用しています：

1. **ベースイメージ** (プルまたは `files/build-base-image.sh`)
   - システムパッケージとアプリケーションをインストール
   - ユーザ設定なし、rootで実行
   - 全ユーザで共有可能
   - ビルド時間: 30-60分
   - 通常は事前ビルドされたものをプル

2. **ユーザイメージ** (`build-user-image.sh`)
   - ベースイメージから派生
   - ホストのUID/GIDに合わせたユーザを作成
   - パスワードを対話的に設定（入力は非表示）
   - 各ユーザごとに個別
   - ビルド時間: 1-2分

通常は `build-user-image.sh` を実行するだけです。

## 使用方法

### 1. ビルド

**基本的なビルド:**
```bash
# ユーザイメージをビルド（パスワード入力あり）
./build-user-image.sh

# キャッシュなしでビルド
NO_CACHE=true ./build-user-image.sh

# パスワードを環境変数で指定（自動化用）
USER_PASSWORD=mysecurepass ./build-user-image.sh

# 特定のベースイメージを使用
BASE_IMAGE_TAG=v1.0 ./build-user-image.sh
```

**ベースイメージのビルド（メンテナ用）:**
```bash
# ベースイメージをビルド
cd files
./build-base-image.sh

# Ubuntu 22.04でビルド
DISTRIB_RELEASE=22.04 ./build-base-image.sh
```

### 2. コンテナの起動

```bash
# デフォルト設定で起動（HTTP）
./start-container.sh

# HTTPSで起動
ENABLE_HTTPS=true ./start-container.sh

# カスタム証明書でHTTPSを起動
ENABLE_HTTPS=true CERT_PATH=/path/to/cert.pem KEY_PATH=/path/to/key.pem ./start-container.sh

# GPUなしで起動（AMD/Intel/ソフトウェアレンダリング）
ENABLE_GPU=false ./start-container.sh

# カスタムポートで起動
HTTPS_PORT=9090 ./start-container.sh

# フォアグラウンドで起動（ログを直接表示）
DETACHED=false ./start-container.sh

# 高解像度で起動
DISPLAY_WIDTH=2560 DISPLAY_HEIGHT=1440 ./start-container.sh
```

### 3. コンテナの操作

```bash
# コンテナを停止（--rmフラグで自動削除されます）
./stop-container.sh

# コンテナを再起動
./restart-container.sh

# ユーザイメージを削除
./delete-image.sh

# イメージを強制削除（使用中のコンテナも削除）
FORCE=true ./delete-image.sh
```

### 4. ログとシェル

```bash
# ログを表示（最新100行）
./logs-container.sh

# ログをリアルタイムで表示
FOLLOW=true ./logs-container.sh

# コンテナのシェルにアクセス
./shell-container.sh

# rootユーザでシェルにアクセス
AS_ROOT=true ./shell-container.sh
```

### 5. コンテナの変更を保存

```bash
# 現在の状態を新しいイメージとして保存
./commit-container.sh

# カスタムタグで保存
COMMIT_TAG=my-custom-setup ./commit-container.sh

# 保存したイメージを使用
IMAGE_NAME=devcontainer-ubuntu24.04-egl-desktop-base:my-custom-setup ./start-container.sh
```

## 環境変数リファレンス

### start-container.sh

| 環境変数 | デフォルト値 | 説明 |
|---------|------------|------|
| `CONTAINER_NAME` | `devcontainer-egl-desktop-$(whoami)` | コンテナ名 |
| `IMAGE_NAME` | `devcontainer-ubuntu24.04-egl-desktop-base:$(whoami)` | 使用するイメージ |
| `ENABLE_HTTPS` | `false` | HTTPSを有効化 |
| `HTTPS_PORT` | `8080` | ホスト側のポート |
| `ENABLE_GPU` | `true` | GPUサポートを有効化 |
| `DETACHED` | `true` | バックグラウンドで実行 |
| `DISPLAY_WIDTH` | `1920` | 画面幅 |
| `DISPLAY_HEIGHT` | `1080` | 画面高さ |
| `DISPLAY_REFRESH` | `60` | リフレッシュレート |
| `VIDEO_ENCODER` | `nvh264enc` | ビデオエンコーダー |
| `VIDEO_BITRATE` | `8000` | ビデオビットレート (kbps) |
| `FRAMERATE` | `60` | フレームレート |
| `AUDIO_BITRATE` | `128000` | オーディオビットレート (bps) |
| `CERT_PATH` | `` | SSL証明書のパス |
| `KEY_PATH` | `` | SSL秘密鍵のパス |

### build-container.sh

| 環境変数 | デフォルト値 | 説明 |
|---------|------------|------|
| `DISTRIB_RELEASE` | `24.04` | Ubuntuバージョン |
| `BASE_IMAGE_NAME` | `devcontainer-ubuntu24.04-egl-desktop-base` | ベースイメージ名 |
| `REBUILD_BASE` | `false` | ベースイメージを再ビルド |
| `NO_CACHE` | `false` | キャッシュを使わずにビルド |

### build-base-image.sh

| 環境変数 | デフォルト値 | 説明 |
|---------|------------|------|
| `DISTRIB_RELEASE` | `24.04` | Ubuntuバージョン |
| `BASE_IMAGE_NAME` | `devcontainer-ubuntu24.04-egl-desktop-base` | ベースイメージ名 |
| `NO_CACHE` | `false` | キャッシュを使わずにビルド |

### build-user-image.sh

| 環境変数 | デフォルト値 | 説明 |
|---------|------------|------|
| `BASE_IMAGE_NAME` | `devcontainer-ubuntu24.04-egl-desktop-base` | ベースイメージ名 |
| `BASE_IMAGE_TAG` | `latest` | ベースイメージのタグ |
| `USER_IMAGE_NAME` | `${BASE_IMAGE_NAME}` | ユーザイメージ名 |
| `USER_IMAGE_TAG` | `$(whoami)` | ユーザイメージのタグ |
| `USER_PASSWORD` | 対話入力 | ユーザのパスワード（環境変数で指定しない場合は対話入力） |
| `NO_CACHE` | `false` | キャッシュを使わずにビルド |

### commit-container.sh

| 環境変数 | デフォルト値 | 説明 |
|---------|------------|------|
| `CONTAINER_NAME` | `devcontainer-egl-desktop-$(whoami)` | コミットするコンテナ名 |
| `COMMIT_TAG` | `$(whoami)-$(date +%Y%m%d-%H%M%S)` | 新しいイメージのタグ |
| `BASE_IMAGE_NAME` | `devcontainer-ubuntu24.04-egl-desktop-base` | ベースイメージ名 |

## 実行例

### 基本的なワークフロー

```bash
# 1. イメージをビルド
./build-container.sh

# 2. コンテナを起動
./start-container.sh

# 3. ブラウザでアクセス: http://localhost:8080

# 4. ログを確認
./logs-container.sh

# 5. シェルにアクセス
./shell-container.sh

# 6. 停止
./stop-container.sh
```

### HTTPSで起動

```bash
# 自己署名証明書でHTTPS
ENABLE_HTTPS=true ./start-container.sh

# カスタム証明書でHTTPS
ENABLE_HTTPS=true \
  CERT_PATH=/path/to/cert.pem \
  KEY_PATH=/path/to/key.pem \
  ./start-container.sh
```

### カスタム設定で起動

```bash
# 4K解像度、ポート9090、高ビットレート
DISPLAY_WIDTH=3840 \
  DISPLAY_HEIGHT=2160 \
  HTTPS_PORT=9090 \
  VIDEO_BITRATE=15000 \
  ./start-container.sh
```

### 変更を保存して再利用

```bash
# 1. コンテナを起動
./start-container.sh

# 2. シェルで設定変更
./shell-container.sh
# （コンテナ内で設定やアプリをインストール）

# 3. 変更を保存
COMMIT_TAG=my-setup ./commit-container.sh

# 4. 保存したイメージで新しいコンテナを起動
IMAGE_NAME=devcontainer-ubuntu24.04-egl-desktop-base:my-setup \
  CONTAINER_NAME=egl-desktop-2 \
  HTTPS_PORT=8081 \
  ./start-container.sh
```

## トラブルシューティング

### コンテナが起動しない

```bash
# ログを確認
./logs-container.sh

# シェルでデバッグ（rootで）
AS_ROOT=true ./shell-container.sh
```

### ポートが使用中

```bash
# 別のポートを使用
HTTPS_PORT=8081 ./start-container.sh
```

### GPU が認識されない

```bash
# GPU サポートを無効化してソフトウェアレンダリング
ENABLE_GPU=false ./start-container.sh
```

### イメージを再ビルド

```bash
# キャッシュなしで完全再ビルド
NO_CACHE=true REBUILD_BASE=true ./build-container.sh
```
