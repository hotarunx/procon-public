set templete_code_ext '.cpp' # 開くファイルのパス
set interval 60 # インターバル

set download_history ~/.cache/online-judge-tools/download-history.jsonl # oj 履歴ファイルのパス
set histories (tail -n100 $download_history) # 履歴ファイルのレコード集 # 最新100個のみ

set last_time (echo $histories[-1] | jq -r '.timestamp') # 最後の履歴のタイムスタンプ

# 各履歴を処理
for row in $histories
    # この履歴のタイムスタンプ
    set this_time (echo $row | jq -r '.timestamp')

    # この履歴から最後の履歴までの間隔が60 s 以下ならVSCodeで開く
    if test (math $last_time - $this_time) -le $interval
        find (echo $row | jq -r '.directory') -name '*'$templete_code_ext | xargs code
        open (echo $row | jq -r '.url')
    end
end
