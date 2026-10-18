# WALLET Design System — Neon Minimal / Quiet Luxury

## Visual rule
Inspired by a matte, near-black premium finance UI. No stones, holographic objects, excessive reflections, thick neon borders or futuristic set dressing. Use clean spatial rhythm, modest glow only for selected accents.

## Colors (hex)
| Token | Hex |
| --- | --- |
| background | #080808 |
| surface | #242424 |
| secondarySurface | #171717 |
| primaryText | #FFFFFF |
| secondaryText | #969696 |
| divider | #333333 |
| neutralAccent | #D7FF62 |
| neutralSecondary | #F3A5DF |
| sberAccent | #21A038 |
| sberSecondary | #B8F28B |
| alfaAccent | #F36BA8 |
| alfaSecondary | #FFB4D3 |
| tbankAccent | #FFD428 |
| tbankSecondary | #FFE99A |
| ozonAccent | #005BFF |
| ozonSecondary | #8AB8FF |

Keep background graphite/black for **all** banks. Change accent/button selection/chart colors, not every surface. Do not rely on hue alone for important statuses (income/expense/success).

## Layout
- iPhone portrait, safe-area-aware; 16–24pt horizontal margins.
- 20–24pt card radius; 12–16pt control radius.
- SF system font: large bold balances with tabular digits, compact captions and clear hierarchy.
- Touch targets >= 44x44pt.
- One prominent action per flow.
- Apple SF Symbols; avoid unlicensed banking marks, use typographic bank labels on fictional card renders.

## Motion
Theme transition ~350ms easeInOut. Respect accessibility Reduce Motion; no gratuitous particles or 3D transitions.

## Screens
**Dashboard:** greeting «Привет, Иван», «Общий баланс» 42 300 ₽ (All Banks demo), bank selector, 2x2 quick actions «История», «Переводы», «Билеты», «Аналитика», recent operations.
**Cards:** bank cards as a horizontal carousel, masked card endings, card-specific transactions.
**Transfer:** source bank/account selector, recipient «Иван Петров», amount 1 000 ₽, quick amounts, fee 0 ₽, demo «Перевести» button, review/confirmation.
**Transaction Detail:** status progress «Отправлено / В обработке / Завершено», App Store transaction 520 ₽, date, masked card, mock bank metadata and contextual actions.

## Adaptive theme behavior
Use a single BankID enum and BankTheme map; derive selected theme rather than copying colors into each screen. Persist preference locally if reasonable. Filter dashboard accounts/transactions by selectedBank (nil means All). Keep transferSourceAccountID independent.
