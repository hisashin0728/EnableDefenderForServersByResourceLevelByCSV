# 1. 概要
このレポジトリは Microsoft Defender for Servers の新機能であるリソース単位での Defender for Servers P1 モードを有効化するためのスクリプトを提供しています。

# 2. 新機能紹介公式ガイド
Microsoft Defender for Servers をリソース単位で有効化する機能が 2023/12/23 に GA されています。詳細は以下リンクを参照下さい。

- [リリースノート](https://learn.microsoft.com/en-us/azure/defender-for-cloud/release-notes#defender-for-servers-at-the-resource-level-available-as-ga)
- [Learn：Protect your servers with Defender for Servers - Microsoft Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-the-plan-at-the-resource-level)
- [API：Pricings - REST API (Azure Defender for Cloud)](https://learn.microsoft.com/en-us/rest/api/defenderforcloud/pricings?view=rest-defenderforcloud-2024-01-01)

# 3. 提供スクリプト
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

# 4.インストール方法
## 4.1 Azure PowerShell の導入
[公式ドキュメント](https://learn.microsoft.com/ja-jp/powershell/azure/install-azps-windows?view=azps-10.4.1&tabs=powershell&pivots=windows-psgallery)を参考に Azure Powershell をインストールします。
- Powershell バージョンの確認
```
PS C:\temp> $PSVersionTable.PSVersion

Major  Minor  Patch  PreReleaseLabel BuildLabel
-----  -----  -----  --------------- ----------
7      3      9
```
- 実行ポリシーをリモート署名済みに設定
```
PS C:\temp> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
- Install-Module より、AzPowershell をインストールする
```
PS C:\temp> Install-Module -Name Az -Repository PSGallery -Force
```
- 最新モジュールにアップデートしておく
```
PS C:\temp> Update-Module -Name Az -Force
```

## 4.2 Azure テナントにログインする
``Connect-AzAccount -Subscription XXXX-XXXX-XXXX-XXXX-XXXX`` コマンドを用いて、操作をしたい対象のテナント/サブスクリプションにログインします。
```
PowerShell 7.3.9
PS C:\temp> Connect-AzAccount  -Subscription ‘xxxx-xxxx-xxxx-xxxx-xxxx’
```
![image](https://github.com/hisashin0728/EnableDefenderForServersByResourceLevelByCSV/assets/55295601/09599e19-45ec-4f8e-a965-ca26b6e82e5c)

## 4.3 target.csv ファイルの編集
スクリプト一式に含まれている ``target.csv`` を編集し、Defender for Servers P1 を有効化したいリソースを入力して下さい。
![image](https://github.com/hisashin0728/EnableDefenderForServersByResourceLevelByCSV/assets/55295601/0020b9d2-f765-4ebe-ad8a-3178a8a58f51)

## 4.4 Defender for Servers P1 有効化 / スクリプトの実行
csv ファイル記入後、リソース有効化の powershell スクリプトを実行して下さい。API 経由でフラグが立ち、Microsoft Defender for Servers P1 が有効化されます。
- ResourceLevel-DfS-Enabled-csv.ps1 (Azure VM リソース用)
- ResourceLevel-DfS-Enabled-ARC-csv.ps1 (Azure Arc リソース用)
![image](https://github.com/hisashin0728/EnableDefenderForServersByResourceLevelByCSV/assets/55295601/88eee626-217a-4a0d-ad95-18cab00186d8)


