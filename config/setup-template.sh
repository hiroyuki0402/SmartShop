# スクリプトに実行権限がない場合、自動で付与して再実行を促す
if [ ! -x "$0" ]; then
  chmod +x "$0"
  echo "スクリプトに実行権限を付与しました。再度以下を実行してください:"
  echo "  ./setup-template.sh"
  exit 0
fi

# テンプレートファイルのパスを取得
TEMPLATE_PATH="$(pwd)/config/commit-template.txt"

# テンプレートファイルが存在するか確認
if [ ! -f "$TEMPLATE_PATH" ]; then
  echo "エラー: テンプレートファイルが見つかりません: $TEMPLATE_PATH"
  exit 1
fi

# Gitローカル設定にテンプレートを登録
git config --local commit.template "$TEMPLATE_PATH"

# 実行結果を表示
echo "コミットメッセージテンプレートを設定しました: $TEMPLATE_PATH"