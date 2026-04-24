# NASA Cosmos Messenger

一款以聊天介面與 NASA APOD API 互動的 Flutter 應用程式。  
輸入日期，Nova 就會帶你探索那一天宇宙的樣子。

---

## 架構說明

採用 **Clean Architecture** 分層，依職責劃分三個主要層次：

```
lib/
├── core/
│   ├── database/       # SQLite 初始化（SqliteHelper）
│   └── utils/          # DateParser、ShareManager 等工具
├── data/
│   ├── models/         # 資料模型（ApodModel、ChatMessage）
│   └── repositories/   # API 存取（ApiService）、資料庫操作（ChatRepository、FavoriteRepository）
├── logic/
│   └── cubit/          # 狀態管理（ApodCubit / ApodState、FavoriteCubit / FavoriteState）
└── ui/
    ├── screens/        # 頁面（NovaChatScreen、FavoriteScreen、HomeScreen）
    └── widgets/        # 元件（ChatBubble、ShareCardLayout）
```

---

## 框架選擇：Flutter

- 熟悉且開發快速，能專注在功能實作與系統架構設計
- 跨平台支援，一份程式碼同時支援 iOS 與 Android
- 豐富的 Widget 生態，快速搭建聊天介面

---

## 狀態管理：Cubit（flutter_bloc）

- Event 與 State 嚴格分離，邏輯清晰易讀
- 比 BLoC 輕量，避免為簡單場景過度設計
- State 為 immutable data class，搭配 `copyWith` 方便更新，也容易撰寫單元測試

---

## 支援的日期格式

| 格式 | 範例 |
|------|------|
| `yyyy-MM-dd` | `1969-07-20` |
| `yyyy/MM/dd` | `1969/07/20` |

> 輸入日期可夾在自然語言中，例如「幫我看 2024-06-01 的太空圖」

---

## 分支策略

- 每個功能獨立開一個 branch（`feat/xxx`）
- PR 審查通過後使用 **Squash Merge**，保持 `main` 的 commit 歷史整潔

---

## Bonus 功能說明

### 離線快取

使用 **SQLite**（sqflite）持久化兩種資料：

- **聊天記錄**：每則對話（用戶訊息與 Nova 回覆）都寫入 `chat_history` 表，下次開啟 App 自動還原歷史訊息，離線時仍可瀏覽所有曾載入的 APOD 內容
- **收藏庫**：長按含有 APOD 的 Nova 訊息可加入收藏，資料存入 `favorites` 表，離線也能查看

### 分享星空卡

點擊含有 APOD 圖片的 Nova 訊息，App 會：

1. 將 APOD 圖片、標題、日期合成為一張「生日星空卡」（1080×1440px）
2. 透過系統 Share Sheet 分享圖片與預設文字

### 其他使用體驗優化

| 功能 | 說明 |
|------|------|
| isTyping 輸入鎖定 | Nova 回覆期間，輸入框、發送按鈕與日曆按鈕全部 disabled，避免重複送出 |
| 訊息文字可複製 | 氣泡內文字使用 `SelectableText`，長按即可複製 |
| NavigationBar 無閃爍 | 採用 Material 3 `NavigationBar`，切換頁面無 ripple 閃爍 |
| 收藏庫去重 | 同一日期的 APOD 已在收藏時，會提示「已在收藏庫」而非重複寫入 |
| 影片支援 | APOD 為影片時顯示縮圖並附上影片連結，避免破版 |