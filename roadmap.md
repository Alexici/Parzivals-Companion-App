# D&D 5e Custom Companion App

## 📱 Core Tech Stack

- Frontend: Flutter (Web/Mobile optimized)
- Backend/Database: Firebase (Firestore for database, Firebase Auth for login)
- State Management: Riverpod
- Hosting: Firebase Hosting or Vercel

## ✨ Feature List

### 1. Authentication & Navigation

- User Login / Register (Email/Password or Google Auth).
- Main Dashboard showing all user's created characters.
- "Create New Character" flow.
- Image support: Upload from device or select from default Race/Class/Sex combinations.

### 2. Character Sheet (Player View)

- Manual "Level Up" / Edit mode (players manually adjust stats to avoid 5e engine bloat).
- Tabs / Pages:
  - Main: AC, HP, Initiative, Heroic Insp, Abilities, Saves, Senses.
  - Skills: Proficiency, Modifier, Name, Bonus.
  - Actions: Weapons, Attacks.
  - Spells: Slots, Save DCs, Spell details.
  - Features: Class/Race/Homebrew abilities.
  - Character Info: Background, languages, notes.
  - Inventory: Gear, equipped items, gold.

### 3. Campaign & DM Tools (Admin View)

- Campaign Hub: DMs create a campaign; players join with a specific character.
- DM Dashboard: View all joined player health/passive stats at a glance.
- DM Admin Powers:
  - Directly drop items/gold into player inventories.
  - Send custom pop-up alerts/messages to specific players in real-time.

### 4. The Real-Time Shop System

- DM controls the shop database (categorized by Type + City Size).
- DM presses "Open Shop" -> Shop tab appears on player screens.
- Shop inventories are randomized via a DM "Refresh" button.
- Automated Charisma discounts applied to display prices.
- 1-click buy button (deducts gold, adds to inventory).

---

## 🗺️ Development Roadmap

### Phase 1: Foundation (The Boring but Necessary Stuff)

1. Initialize Flutter project. **DONE**
2. Connect to Firebase project. **DONE**
3. Set up Riverpod for state management. **DONE**
4. Build Login/Register screens and Auth logic. **DONE**

### Phase 2: The Data Layer

1. Define Firestore schemas (Collections: Users, Characters, Campaigns).
2. Create Riverpod providers to fetch and stream character data.

### Phase 3: The "Dumb" UI (Character Sheet)

1. Build the character selection screen.
2. Build the tabbed character sheet layout.
3. Create the data-entry forms (Edit Stats, Add Spell, Add Item).
4. Connect UI to Firebase to enable saving/editing.

### Phase 4: Campaign & Admin Logic

1. Build Campaign creation and "Join Campaign" flow.
2. Build DM dashboard to view player stats.
3. Implement real-time DM-to-Player notifications/item drops.

### Phase 5: The Shop System

1. Build DM shop inventory management.
2. Build the Player shop UI.
3. Implement purchase logic (Gold validation -> Deduction -> Inventory addition).

### Phase 6: Polish

1. Add character image uploading (Firebase Storage).
2. Clean up UI for both mobile and desktop views.
3. Playtest with fake data!

## Design Choices: 1. The Arcane Hologram

1. Gradients: Midnight Blue -> Royal Purple, Forest Green -> Charcoal, Dark Amber -> Crimson, Dark Teal -> Slate Grey, Crimson Red -> Black (Admin)
2. Glassmorphism containers

## Design Choices: 2. The Authentic Tavern

1. Background: Dark worn leather texture / Rotten dark wood planks
2. Dark-stained parchment container design

## Things to update in the future

1. Registering via email + pass will have more fields: username, confirm password **DONE**
2. Registering via google will bring a pop up to chose a username

### FEEDBACK FROM THE BOYS

1. Wiki
2. Oredict (crafting recipes)
3. Full levelup
