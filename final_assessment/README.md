# Final Assessment - Sui Study Jam 2026

Đây là dự án đánh giá cuối khóa cho First Movers - Sui Study Jam 2026, bao gồm 2 smart contracts và 1 Web3 UI.

By: Trần Vũ Khánh Hưng \
Email: tvkhhung03@gmail.com \
Telegram: johntran33

Video demo link: https://www.youtube.com/watch?v=eUZ89QpLkLA

Các tx thành công và fail:
1. OPTION 2: Soulbound NFT \
tx Hash thành công: 63DX3SLJBdNKKodUUj5NCWcjUnqVze476jCHsVFqu4Fm \
Suiscan Link: https://suiscan.xyz/testnet/tx/63DX3SLJBdNKKodUUj5NCWcjUnqVze476jCHsVFqu4Fm \

tx Abort: GoaACZjdnjUahMAwXEAZe2qd36RErcziA3k4zme6cuMB \
Suiscan Link: https://suiscan.xyz/testnet/tx/GoaACZjdnjUahMAwXEAZe2qd36RErcziA3k4zme6cuMB

2. OPTION 3: Voting basic \
tx Hash thành công: 3YDCjiPUavCo85Vvk6DZS4hHw8UToG4ykK7wfc9L3Xti \
Suiscan Link: https://suiscan.xyz/testnet/tx/3YDCjiPUavCo85Vvk6DZS4hHw8UToG4ykK7wfc9L3Xti \

tx Abort: G7otxAb9rJJZAeR9TjhLAJangZYEHpsyRqweVPLNx9WJ \
Suiscan Link: https://suiscan.xyz/testnet/tx/G7otxAb9rJJZAeR9TjhLAJangZYEHpsyRqweVPLNx9WJ

---

## 📦 Cấu trúc dự án

```
final_assessment/
├── sources/
│   ├── pass.move         # Soulbound Pass NFT (mint 1 lần/địa chỉ) - OPTION 2
│   └── voting.move       # On-chain voting system - OPTION 3
├── tests/
│   └── *.move           # Unit tests
├── voting-ui/           # React + Sui dApp UI
│   ├── src/
│   │   ├── App.tsx      # Voting interface
│   │   └── main.tsx     # Provider setup
│   └── package.json
├── Move.toml            # Move package config
├── Published.toml       # On-chain deployment info
└── scripts.txt          # CLI commands
```

---

## 🧩 Smart Contracts

### 1. **pass.move** - Soulbound Pass NFT

**Mục đích:** Mint một NFT "vé thành viên" không thể chuyển nhượng, mỗi địa chỉ chỉ mint được 1 lần.

**Tính năng:**
- ✅ Mỗi địa chỉ chỉ mint được 1 Pass
- ✅ Pass được gắn với owner (soulbound pattern)
- ✅ Registry theo dõi địa chỉ đã mint

**Struct chính:**
```move
public struct Pass has key, store {
    id: UID,
    owner: address,
}

public struct Registry has key {
    id: UID,
    minted: Table<address, bool>,
}
```

**Functions:**
- `init()`: Tự động tạo Registry khi publish
- `mint_pass(registry, ctx)`: Mint Pass (1 lần/địa chỉ)
- `has_pass(registry, user)`: Kiểm tra địa chỉ đã mint chưa

---

### 2. **voting.move** - On-chain Voting

**Mục đích:** Hệ thống bỏ phiếu on-chain đơn giản, mỗi địa chỉ vote 1 lần cho Option A hoặc B.

**Tính năng:**
- ✅ 2 lựa chọn: Option A / Option B
- ✅ Mỗi địa chỉ chỉ vote 1 lần
- ✅ Kết quả lưu on-chain, công khai minh bạch

**Struct chính:**
```move
public struct Voting has key {
    id: UID,
    option_a: u64,      // Số vote cho A
    option_b: u64,      // Số vote cho B
    voted: Table<address, bool>,
}
```

**Functions:**
- `init()`: Tạo Voting object (shared) khi publish
- `vote(voting, choice, ctx)`: Vote (true = A, false = B)
- `get_results(voting)`: Xem kết quả (option_a, option_b)

---

## 🚀 Build & Deploy

### 1. Build smart contracts

```bash
cd final_assessment
sui move build
```

### 2. Deploy lên Testnet

```bash
sui client publish --gas-budget 100000000
```

**Lưu lại thông tin sau khi publish:**
- `PACKAGE_ID`: Địa chỉ package vừa deploy
- `REGISTRY_ID`: Object ID của `pass::Registry` (từ Created Objects)
- `VOTING_ID`: Object ID của `voting::Voting` (từ Created Objects)

**Ví dụ output:**
```
Created Objects:
  - ID: 0xb818a66e... (Registry - pass module)
  - ID: 0x16e405d3... (Voting - voting module)

Published Objects:
  - ID: 0x180111b5... (Package ID)
```

---

## 🎯 CLI Usage

### Mint Pass NFT

```bash
# Dùng PTB (Programmable Transaction Block)
sui client ptb \
  --move-call $PACKAGE_ID::pass::mint_pass @$REGISTRY_ID \
  --gas-budget 10000000
```

### Vote on-chain

```bash
# Vote cho Option A (true)
sui client ptb \
  --move-call $PACKAGE_ID::voting::vote @$VOTING_ID @true \
  --gas-budget 10000000

# Vote cho Option B (false)
sui client ptb \
  --move-call $PACKAGE_ID::voting::vote @$VOTING_ID @false \
  --gas-budget 10000000
```

### Xem kết quả voting

```bash
sui client object $VOTING_ID --json | jq '.data.content.fields'
```

---

## 🌐 Web3 UI (voting-ui)

### Setup & Run

```bash
cd voting-ui

# Cài dependencies
npm install

# Chạy dev server
npm run dev
```

Truy cập: `http://localhost:5173`

### Cấu hình

Mở `src/App.tsx` và cập nhật:

```tsx
const PACKAGE_ID = "0xYOUR_PACKAGE_ID";      // Từ bước publish
const VOTING_ID = "0xYOUR_VOTING_OBJECT_ID"; // Object ID của Voting
```

### Tính năng UI

- ✅ Kết nối ví Sui (Sui Wallet, Suiet, Ethos, ...)
- ✅ Hiển thị kết quả vote real-time
- ✅ Vote cho Option A hoặc B
- ✅ Tự động refresh sau khi vote
- ✅ Validation (mỗi địa chỉ vote 1 lần)

---

## 📋 Checklist đánh giá

  ✅ Build thành công không có lỗi
  ✅ Deploy lên Testnet
  ✅ Mint Pass NFT được (1 lần/địa chỉ)
  ✅ Vote được và kết quả cập nhật on-chain
  ✅ UI chạy và kết nối ví được
  ✅ UI hiển thị kết quả chính xác
  ✅ Transaction hash hợp lệ trên Explorer

---

## 🔗 Resources

- **Sui Testnet Explorer:** [https://suiscan.xyz/testnet](https://suiscan.xyz/testnet)
- **Sui Wallet:** [https://chromewebstore.google.com/sui-wallet](https://chromewebstore.google.com/detail/sui-wallet)
- **Sui Docs:** [https://docs.sui.io](https://docs.sui.io)
- **@mysten/dapp-kit:** [https://sdk.mystenlabs.com/dapp-kit](https://sdk.mystenlabs.com/dapp-kit)

## 👨‍💻 Author

**Sui Study Jam 2026 - Final Assessment**  
Johntran33
---
