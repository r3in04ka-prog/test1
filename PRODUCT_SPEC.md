# WALLET — Product Specification

## Goal
An interactive, high-fidelity iOS mockup of a unified Russian multi-bank money dashboard; designed to be extended into a real product **only after** official bank integrations and compliance work.

## Personas and journey
A user opens WALLET, checks their combined money, switches to Сбер (the accent goes green and bank-scoped data appears), views cards, creates a **simulated** transfer and inspects its details.

## Bank theme mappings
All banks: lime #D7FF62 and pastel pink #F3A5DF.
Сбер: green #21A038; Альфа: pink #F36BA8; Т-Банк: yellow #FFD428; Ozon: blue #005BFF.

## Prototype dataset
Provide at least one fictional account per bank, with unique IDs, currency RUB, individual balances, masked 4-digit card suffixes and sample transactions. Ensure combined balance is the actual sum of example account balances (do not display 42 300 ₽ as total if account fixtures sum to a different value). Sample operations: «Пятёрочка» −1 240 ₽ (Продукты), «Зарплата» +95 000 ₽ (Доход), «Яндекс Такси» −420 ₽ (Транспорт), «App Store» −520 ₽. Dates may be clearly mock.
Recommended source cards: Сбер •••• 1234, Т-Банк •••• 5678, Альфа •••• 9012, Ozon •••• 3456.

## Screen behavior
### Dashboard
Avatar, greeting, bank segmented chips/dropdown, scoped balance with income/outflow pills, chart, four actions, recent transactions and tab navigation.
### Cards
Accessible swipe carousel with card balance, name, masked suffix and bank theme; selecting a card scopes card transaction list.
### Transfer (DEMO)
Pick source *account* explicitly, recipient, amount, fee, review, confirm. Validate amount > 0 and not above mock available balance. Confirmation updates mock repository optionally and presents unmistakable «Демонстрационный перевод» receipt; never send network payment requests.
### Transaction detail
Show merchant/recipient, signed amount, status tracker, timestamp, masked card and safe fictional details. Do not display fabricated real-looking BIK or correspondent account numbers as if validated routing data.
### Analytics / Profile
Scaffold useful navigation destinations, then enhance in later milestones.

## Non-goals for MVP
No OAuth bank login, actual account linking, СБП API, NFC tap-to-pay, Apple Pay, QR-triggered real payments, storage of card credentials, or server.

## Technical acceptance criteria
- No sign-in required to explore demo.
- All screens respond to taps/selection.
- Theme change is smooth and global.
- Bank filtering is deterministic; combined balance has correct math.
- Transfer source remains explicit if global filter changes.
- Tests cover critical state transitions and transfer validation.
- UI has functional accessibility identifiers for navigation and core actions.
