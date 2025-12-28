# Sui Move - Study Jam 2026

> 🏆 **Road to First Movers Sprint 2026** – Study Jam chương trình 4 tuần giúp các developer xây dựng nền tảng Sui & Move thông qua thực hành.

---

## 📚 Nội dung các buổi học

### Buổi 1: Giới thiệu Sui Move
- **Video demo**: [https://www.youtube.com/watch?v=l-pzZv53ywo](https://www.youtube.com/watch?v=l-pzZv53ywo)
- **Nội dung**: Hello World, cấu trúc project cơ bản
- **Thư mục**: `buoi1/`

### Buổi 2: [Đang cập nhật]
- **Nội dung**: 
- **Thư mục**: `buoi2/`

### Buổi 3: [Đang cập nhật]
- **Nội dung**: 
- **Thư mục**: `buoi3/`

### Buổi 4: [Đang cập nhật]
- **Nội dung**: 
- **Thư mục**: `buoi4/`

---

## 🚀 Cài đặt

```bash
# Cài đặt Sui CLI
curl -fsSL https://sui.io/install.sh | sh

# Verify installation
sui --version
```
**Ví dụ cấu trúc:**
```
buoi1/my_project/
├── sources/
│   └── main.move
├── tests/
│   └── main_test.move
├── Move.toml
└── README.md (giải thích project)
```

**Lưu ý:** Demo phải chạy trên **Devnet hoặc Testnet**, không phải local environment

### 3️⃣ **On-chain Proof**
- **Valid transaction hash** trên:
  - 🔗 [Sui Devnet Explorer](https://suiscan.xyz/devnet) hoặc
  - 🔗 [Sui Testnet Explorer](https://suiscan.xyz/testnet)
- Transaction hash phải **khớp với code** nộp
- Nếu deploy contract: cần tx hash của `sui client publish`
- Nếu call function: cần tx hash của `sui client call`

**Cách lấy transaction hash:**
```bash
# Khi chạy command, output sẽ có:
# Transaction Digest: 0x1234567890abcdef...
# Copy hash này vào submission
```

## 📖 Tài liệu Tham Khảo

- 📘 [Sui Official Docs](https://docs.sui.io/)
- 📕 [Move Book](https://move-book.com/)
- 💻 [Sui Examples](https://github.com/MystenLabs/sui/tree/main/examples)
- 🔍 [Sui Devnet Explorer](https://suiscan.xyz/devnet)
- 🛠️ [Sui CLI Reference](https://docs.sui.io/references/cli)

---