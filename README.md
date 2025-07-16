
# 🧱 Onchain Heritage

**Onchain Heritage** is an interactive Web3 dApp built with **Flutter Web + GetX** and deployed on the **Base chain** (Sepolia or Mainnet). Each on-chain interaction reveals a piece of a pixel art image — a tribute to preserving collective on-chain memory.

---

## 👨‍💻 Developed By

**Abedalqader Alkhatib** — [GitHub: alkhatib99](https://github.com/alkhatib99)
🛠️ Flutter • Web3 • Solidity

---

## 🚀 Live Demo

> Coming Soon (Once Deployed to Firebase or Vercel)

---

## 🎯 Project Goal

1 interaction = 1 wallet = 1 block of a large pixel-art image.
When `100,000` unique addresses interact → the **entire image is revealed**.

---

## 🔧 Tech Stack

- **Frontend:** Flutter Web + GetX + web3dart + dart:html
- **Smart Contract:** Solidity (deployed on Base Sepolia)
- **Wallet:** MetaMask (via `ethereum.request`)
- **Image Reveal Logic:** Fractional display of full image based on interaction count

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
│   │   └── full_image.png             # One single image for rendering
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
- `OnchainHeritage.abi.json` → `lib/assets/`

### 3. 🔐 Update Contract Address

In `interaction_controller.dart`:

```dart
final contractAddressHex = '0xYourContractAddressHere';
```

Replace it with your deployed contract address.

### 4. 🧪 Run Locally

```bash
flutter run -d chrome
```

---

## 🛠️ Smart Contract: OnchainHeritage.sol

```solidity
mapping(address => bool) public hasParticipated;
uint256 public totalInteractions;

function participate() public {
  require(!hasParticipated[msg.sender], "Already participated");
  hasParticipated[msg.sender] = true;
  totalInteractions += 1;
  emit Participated(msg.sender, totalInteractions);
}
```

Deployed to: **Base Sepolia**
✅ Emits `Participated(address, totalInteractions)` on each successful interaction.

---

## 🎨 Image Logic

- You only need **one image**
- The widget will cover/uncover it dynamically using `FractionallySizedBox`
- No slicing or manual editing required

---

## 💡 Roadmap

- [ ] Deploy full version on Firebase / IPFS
- [ ] Add NFT mint for contributors
- [ ] Leaderboard for early wallets
- [ ] Season-based reveals

---

## 📬 Contributions

Pull requests are welcome via [github.com/alkhatib99/onchain_heritage](https://github.com/alkhatib99/onchain_heritage)

---

## 🧠 License

MIT © alkhatib99
