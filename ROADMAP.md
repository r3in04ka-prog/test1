# WALLET development roadmap

## Milestone 1 — App shell + adaptive dashboard
- [ ] Native Xcode SwiftUI project targeting iOS 17+
- [ ] Design tokens, BankID, BankTheme and observable selection state
- [ ] Stable mock BankAccount and Transaction fixtures
- [ ] Bottom navigation and working Dashboard
- [ ] Bank switching animates accent changes and filters balances/operations
- [ ] Unit tests for balance aggregation, bank filtering, theme mapping

## Milestone 2 — Cards
- [ ] Horizontal card carousel with Сбер, Т-Банк, Альфа, Ozon
- [ ] Bank-themed card surfaces, masked numbers and balances
- [ ] Selecting cards filters transaction list
- [ ] VoiceOver and swipe accessibility

## Milestone 3 — Demo transfers + details
- [ ] Explicit source account and recipient selection
- [ ] Amount input, quick amounts, fee, validation
- [ ] Mock confirmation + unmistakable demo receipt
- [ ] Transaction detail with progress indicator and information card
- [ ] Tests for invalid amount and insufficient mock funds

## Milestone 4 — Analytics + polish
- [ ] Swift Charts category and period filtering
- [ ] Profile/settings and preference persistence
- [ ] Loading/empty/error views
- [ ] Dynamic Type, Reduce Motion, VoiceOver, UI tests
- [ ] Real-device validation, screenshots, README setup

## Later, separate project — Real bank integrations
Validate bank/СБП API access and contracts, threat model, consent and token handling, backend design, security and compliance **before** implementing any payment functionality.
