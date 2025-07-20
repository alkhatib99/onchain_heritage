
# 🧱 Onchain Heritage

**Onchain Heritage** is an interactive Web3 dApp built with **Flutter Web + GetX** and deployed on the **Base chain** (Sepolia or Mainnet). Each on-chain interaction reveals a piece of a pixel art image — a tribute to preserving collective on-chain memory.

OnchainHeritage is a fully on-chain interactive Web3 experience that transforms every wallet interaction into a meaningful contribution to a collective legacy. Each time a user interacts with the smart contract, they unlock a small part of a large pixel-art image. Once the community reaches 100,000 total interactions, the complete artwork is revealed, symbolizing the power of unity and on-chain participation.

The project is built using Flutter Web with GetX for a smooth and dynamic frontend experience, and the smart contract is deployed on the Base network (Mainnet or Sepolia). It emphasizes low gas usage and easy accessibility, allowing users to leave a permanent mark on the blockchain.

OnchainHeritage is more than a dApp  it's a digital monument, built piece by piece by the community, preserved forever on the blockchain.

---

## 👨‍💻 Developed By

**Abedalqader Alkhatib** — [GitHub: alkhatib99](https://github.com/alkhatib99)
💪 Flutter • Web3 • Solidity

---

## 🚀 Live Demo

> Version 1.0.0 deployed at: [onchain-heritage.alkhatibcrypto.xyz](https://onchain-heritage.alkhatibcrypto.xyz)

---

## 🎯 Project Goal

Each wallet has multiple **levels**.

- Each **level** requires `100,000` interactions (transactions) to complete.
- When a level is completed, a **new image is revealed**.
- You can keep interacting to reach higher levels and unlock more art.

This project aims to preserve history **on-chain**, block by block.

---

## 🔧 Tech Stack

- **Frontend:** Flutter Web + GetX + web3dart + dart:html
- **Smart Contract:** Solidity (deployed on Base Sepolia)
- **Wallet:** MetaMask (via `ethereum.request`)
- **Image Reveal Logic:** Fractional display of image per interaction level

---

## 📁 Project Structure

```
lib/
├── controllers/
│   └── interaction_controller.dart     # Contract logic, wallet handling
├── views/
│   └── home_page.dart                  # Main UI
├── widgets/
│   ├── meta_mask_interaction_widget.dart
│   └── image_reveal_widget.dart       # Dynamic image reveal
├── theme/
│   └── app_theme.dart                 # Custom UI styling
├── assets/
│   ├── images/
│   │   ├── full_image.png             # Main image to reveal
│   │   └── logo.png                   # App icon (used for launcher)
│   └── OnchainHeritage.abi.json      # ABI from deployed contract
main.dart                              # App entrypoint
```

---

## 📝 Setup Instructions

### 1. 📦 Install Dependencies

```bash
flutter pub get
```

### 2. 🖼️ Add Image & ABI

Place the following:

- `full_image.png` → `lib/assets/images/`
- `logo.png` → `lib/assets/images/` (used as launcher icon)
- `OnchainHeritage.abi.json` → `lib/assets/`

### 3. 🔐 Update Contract Address

In `interaction_controller.dart`:

```dart
final contractAddressHex = '0xYourContractAddressHere';
```

Replace it with your deployed contract address.

### 4. 🧶 Run Locally

```bash
flutter run -d chrome
```

### 5. 🚀 Generate Launcher Icon

In `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_icons:
  android: true
  ios: true
  image_path: "assets/images/logo.png"
  remove_alpha_ios: true
```

Then run:

```bash
flutter pub run flutter_launcher_icons:main
```

---

## 🛠️ Smart Contract: OnchainHeritage.sol

```solidity
mapping(address => uint256) public interactions;
uint256 public totalInteractions;

event Participated(address indexed user, uint256 userTotal, uint256 total);

function participate() public {
  interactions[msg.sender] += 1;
  totalInteractions += 1;
  emit Participated(msg.sender, interactions[msg.sender], totalInteractions);
}
```

Deployed to: **Base Sepolia**
✅ Emits `Participated(address, userTotal, totalInteractions)` on each interaction.

---

## 🎨 Image Logic

- One image per level is used.
- As interaction count increases, more of the image is revealed.
- When `100k` interactions are reached for the wallet → **next level** unlocks a **new image**.

---

## 💡 Roadmap

- [X] Deploy v1.0.0 on Vercel
- [ ] Connect custom domain `onchain-heritage.alkhatibcrypto.xyz`
- [ ] Add NFT minting for contributors
- [ ] Dynamic multi-level image unlocking
- [ ] Leaderboard for early wallets
- [ ] Support for multiple Base networks (mainnet/testnet)

---

## 📬 Contributions

Pull requests are welcome via [github.com/alkhatib99/onchain_heritage](https://github.com/alkhatib99/onchain_heritage)

---

## 🧐 License

MIT © alkhatib99
