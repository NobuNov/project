#!/bin/bash

# WSL2をデフォルトに設定
if command -v wsl > /dev/null; then
    wsl --set-default-version 2
else
    echo "WSL環境外で実行されているため、WSL関連コマンドをスキップします。"
fi

# 既存のディストリビューションをWSL2にアップグレード
echo "既存のWSL 1ディストリビューションを確認中..."

# WSLのリストを行ごとに処理し、ディストリビューションのバージョンを確認
if command -v wsl > /dev/null; then
    wsl --list --verbose | tail -n +1 | while read -r line; do
        distro=$(echo $line | awk '{print $1}')
        version=$(echo $line | awk '{print $4}')
        
        if [ "$version" = "1" ]; then
            echo "アップグレード中: $distro をWSL 1からWSL 2に変換します..."
            wsl --set-version "$distro" 2
        else
            echo "$distro はすでにWSL 2です。"
        fi
    done
else
    echo "WSL関連の処理をスキップします。"
fi

# 必要なパッケージがインストールされているか確認
if dpkg -l | grep -q "ca-certificates"; then
    echo "ca-certificates は既にインストールされています。"
else
    echo "ca-certificates をインストールします。"
    sudo apt-get update
    sudo apt-get install -y ca-certificates
fi

if dpkg -l | grep -q "curl"; then
    echo "curl は既にインストールされています。"
else
    echo "curl をインストールします。"
    sudo apt-get install -y curl
fi

if dpkg -l | grep -q "gnupg"; then
    echo "gnupg は既にインストールされています。"
else
    echo "gnupg をインストールします。"
    sudo apt-get install -y gnupg
fi

# DockerのGPGキーが存在するか確認
if [ -f /etc/apt/keyrings/docker.gpg ]; then
    echo "DockerのGPGキーは既に存在しています。"
else
    echo "DockerのGPGキーをインストールします。"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

# Dockerリポジトリが既に追加されているか確認
if [ -f /etc/apt/sources.list.d/docker.list ]; then
    echo "Dockerリポジトリは既に追加されています。"
else
    echo "Dockerリポジトリを追加します。"
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

# Dockerがインストールされているか確認
if dpkg -l | grep -q "docker-ce"; then
    echo "Dockerは既にインストールされています。"
else
    echo "Dockerをインストールします。"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# Dockerサービスの起動
sudo service docker start

# 'docker' グループが存在するか確認し、存在しなければ作成
if getent group docker > /dev/null; then
    echo "docker グループは既に存在します。"
else
    sudo groupadd docker
fi

# 現在のユーザーを'docker'グループに追加
if groups $USER | grep -q "\bdocker\b"; then
    echo "ユーザーは既に docker グループに属しています。"
else
    sudo usermod -aG docker $USER
    echo "ユーザーを docker グループに追加しました。"
fi

# 再ログインの必要性を通知
echo "Dockerのインストールが完了しました。Dockerグループの変更を反映するために、再ログインしてください。"

# 終了メッセージとキー押下待ち
echo "終了しました。何かキーを押すとWSLが終了します..."
read -n 1 -s -r -p "Press any key to exit"

# WSLセッションの終了
exit
