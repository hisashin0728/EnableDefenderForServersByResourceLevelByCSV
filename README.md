# 概要
このレポジトリは Microsoft Defender for Servers の新機能であるリソース単位での Defender for Servers P1 モードを有効化するためのスクリプトを提供しています。

# 新機能紹介公式ガイド
Microsoft Defender for Servers をリソース単位で有効化する機能が 2023/12/23 に GA されています。詳細は以下リンクを参照下さい。

- [リリースノート](https://learn.microsoft.com/en-us/azure/defender-for-cloud/release-notes#defender-for-servers-at-the-resource-level-available-as-ga)
- [Learn：Protect your servers with Defender for Servers - Microsoft Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-the-plan-at-the-resource-level)
- [API：Pricings - REST API (Azure Defender for Cloud)](https://learn.microsoft.com/en-us/rest/api/defenderforcloud/pricings?view=rest-defenderforcloud-2024-01-01)

# 使い方
[スクリプトフォルダ](https://github.com/hisashin0728/EnableDefenderForServersByResourceLevelByCSV/tree/main/Scripts)のファイル一式をダウンロードして、Azure PowerShell で実行します。
ユーザーは ``target.csv`` ファイルに対象リソースを記入し、powershell スクリプト ``ResourceLevel-DfS-Enabled-csv.ps1`` を実行すると、対象リソースに一括適用することが出来ます。

| ファイル  |  内容  |
| ---- | ---- |
| ResourceLevel-DfS-Check-csv.ps1  | csv ファイルに記入した Azure VM リソースに対して、API の状態をチェックしてリスト出力する PowerShell スクリプトです。|
| ResourceLevel-DfS-Disabled-csv.ps1 | csv ファイルに記入した Azure VM リソースに対して、Microsoft Defender for Servers を無効化する PowerShell スクリプトです。|
| ResourceLevel-DfS-Enabled-csv.ps1 | csv ファイルに記入した Azure VM リソースに対して、Microsoft Defender for Servers P1 を有効化する PowerShell スクリプトです。|
| ResourceLevel-DfS-Check-ARC-csv.ps1  | csv ファイルに記入した Azure Arc リソースに対して、API の状態をチェックしてリスト出力する PowerShell スクリプトです。|
| ResourceLevel-DfS-Disabled-ARC-csv.ps1 | csv ファイルに記入した Azure Arc リソースに対して、Microsoft Defender for Servers を無効化する PowerShell スクリプトです。|
| ResourceLevel-DfS-Enabled-ARC-csv.ps1 | csv ファイルに記入した Azure Arc リソースに対して、Microsoft Defender for Servers P1 を有効化する PowerShell スクリプトです。|
| ResourceLevel-DfS-extension-ARC-csv.ps1 | csv ファイルに記入した Azure Arc リソースに対して、extension で ``MDE.Windows`` / ``MDE.Linux`` が適用されているかどうかを判別するスクリプトです。|
| disable.json | Powershell 実行時に用いられる json ファイル (無効化用) |
| enable.json | Powershell 実行時に用いられる json ファイル (Microsoft Defender for Servers P1 用) |
| target.csv | Defender for Servers P1 を有効化したい対象リソースを記入する csv ファイル |

