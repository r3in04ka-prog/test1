# Instructions for Codex

You are developing **WALLET**, a native Russian-language iOS multibanking prototype.

## Priority
Deliver a real runnable SwiftUI iOS app, not a web page or graphic. Begin with a functional Dashboard and Adaptive Bank Theme, then add remaining screens.

## Implementation
- Swift 6 / SwiftUI / iOS 17+; use platform APIs and avoid third-party packages unless essential.
- MVVM with small feature modules, central observable AppState/ThemeManager and mock repositories.
- Build reusable tokens and components; no hardcoded UI colors in feature views.
- Navigation tabs: Главная, Карты, Переводы, Аналитика, Профиль. Four required detailed visual flows: Dashboard, Cards, Transfer, Transaction Detail. Stub extra tabs gracefully until implemented.
- Use fake Russian names, fictional balances and masked card endings; never render full payment credentials.
- Support Dynamic Type, VoiceOver, light/dark contrast constraints (product uses dark palette), safe areas and loading/empty/error states.
- Animations must be discreet (~0.35s), honor Reduce Motion.
- **Never claim the app is bank-connected or can send actual money.** Confirmation creates an in-memory/mock transaction and labels its result as demo.
- Global bank theme and dashboard filter must not silently change the account selected to pay from.

## Workflow
1. Inspect existing repo before changes.
2. Scaffold a proper Xcode project (use XcodeGen only if environment has it; otherwise produce a checked-in .xcodeproj).
3. Add mock data, theme design tokens, shared components, navigation.
4. Implement Dashboard first and verify bank switching.
5. Add Cards, Transfer, Transaction Detail.
6. Add tests for theme switching, filtering, balance calculation, and demo transfers.
7. Run xcodebuild/test if macOS/Xcode available. If unavailable, explain limits and do not assert successful compilation.
8. Keep the README updated with setup and screenshots if available.

## Definition of done
- App launches without required credentials, network or backend.
- Every mock screen accessible by taps.
- Switching bank changes accent colors on all visible controls and correctly updates bank-scoped balances and transactions.
- Russian labels are legible, values consistent, demo disclaimer visible before transfer confirmation.
- Unit tests cover core logic.
