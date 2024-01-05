# 概要
このレポジトリは Microsoft Defender for Servers の新機能であるリソース単位での Defender for Servers P1 モードを有効化するためのスクリプトを提供しています。

# 新機能紹介公式ガイド
Microsoft Defender for Servers をリソース単位で有効化する機能が 2023/12/23 に GA されています。詳細は以下リンクを参照下さい。

- [リリースノート](https://learn.microsoft.com/en-us/azure/defender-for-cloud/release-notes#defender-for-servers-at-the-resource-level-available-as-ga)
- [Learn：Protect your servers with Defender for Servers - Microsoft Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-the-plan-at-the-resource-level)
- [API：Pricings - REST API (Azure Defender for Cloud)](https://learn.microsoft.com/en-us/rest/api/defenderforcloud/pricings?view=rest-defenderforcloud-2024-01-01)

# 使い方
[スクリプトフォルダ](https://github.com/hisashin0728/EnableDefenderForServersByResourceLevelByCSV/tree/main/Scripts)のファイル一式をダウンロードして、Azure PowerShell で実行します。
