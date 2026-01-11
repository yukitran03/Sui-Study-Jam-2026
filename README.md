# Sui Move - Study Jam 2026

> 🏆 **Road to First Movers Sprint 2026** – A 4-week Study Jam program helping developers build a strong foundation in Sui & Move through hands-on practice.

---

## 📚 Session Contents

### Session 1: Introduction to Sui Move
- **Video demo**: [https://www.youtube.com/watch?v=l-pzZv53ywo](https://www.youtube.com/watch?v=l-pzZv53ywo)
- **Content**: Hello World, basic project structure
- **Directory**: `buoi1/`

### Session 2: Object-Centric & Ownership
- Examples in Counter folder

### Final Session: Final assessment : cd final_assessment/README.md

---

## 🚀 Installation

```bash
# Install Sui CLI
curl -fsSL https://sui.io/install.sh | sh

# Verify installation
sui --version
```
**Example structure:**
```
buoi1/my_project/
├── sources/
│   └── main.move
├── tests/
│   └── main_test.move
├── Move.toml
└── README.md (project explanation)
```

**Note:** Demos must run on **Devnet or Testnet**, not local environment

### 3️⃣ **On-chain Proof**
- **Valid transaction hash** on:
  - 🔗 [Sui Devnet Explorer](https://suiscan.xyz/devnet) or
  - 🔗 [Sui Testnet Explorer](https://suiscan.xyz/testnet)
- Transaction hash must **match the submitted code**
- For contract deployment: need tx hash from `sui client publish`
- For function call: need tx hash from `sui client call`

**How to get transaction hash:**
```bash
# When running commands, the output will show:
# Transaction Digest: 0x1234567890abcdef...
# Copy this hash into submission
```

## 📖 Reference Documentation

- 📘 [Sui Official Docs](https://docs.sui.io/)
- 📕 [Move Book](https://move-book.com/)
- 💻 [Sui Examples](https://github.com/MystenLabs/sui/tree/main/examples)
- 🔍 [Sui Devnet Explorer](https://suiscan.xyz/devnet)
- 🛠️ [Sui CLI Reference](https://docs.sui.io/references/cli)

---