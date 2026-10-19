import SwiftUI

struct RootView: View {
    @EnvironmentObject private var state: AppState
    var body: some View {
        TabView(selection: $state.selectedTab) {
            DashboardView().tabItem { Label("Главная", systemImage: "house.fill") }.tag(0)
            CardsView().tabItem { Label("Карты", systemImage: "creditcard.fill") }.tag(1)
            TransferView().tabItem { Label("Переводы", systemImage: "arrow.left.arrow.right") }.tag(2)
            PlaceholderView(title: "Аналитика", icon: "chart.bar.fill").tabItem { Label("Аналитика", systemImage: "chart.bar.fill") }.tag(3)
            PlaceholderView(title: "Профиль", icon: "person.fill").tabItem { Label("Профиль", systemImage: "person.fill") }.tag(4)
        }.tint(state.theme.accent).preferredColorScheme(.dark)
    }
}

struct DashboardView: View {
    @EnvironmentObject private var state: AppState
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    balanceCard
                    bankSelector
                    quickActions
                    recentTransactions
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
            .background(Color(hex: "080808"))
            .navigationBarHidden(true)
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Привет, Иван").font(.title2.bold())
                Text("Ваши деньги в одном месте").foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 38))
                .foregroundStyle(state.theme.accent)
        }
    }

    private var balanceCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Общий баланс").foregroundStyle(.secondary)
            Text(state.totalBalance.rubles)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .contentTransition(.numericText())
            HStack {
                Label("Доходы 95 000 ₽", systemImage: "arrow.down.left")
                    .foregroundStyle(state.theme.accent)
                Spacer()
                Label("Расходы 2 180 ₽", systemImage: "arrow.up.right")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
        }
        .padding(20)
        .background(Color(hex: "171717"))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var bankSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Банк").font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(BankID.allCases) { bank in
                        Button { state.select(bank) } label: {
                            Text(bank.title)
                                .font(.subheadline.weight(.semibold))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(state.selectedBank == bank ? state.theme.accent : Color(hex: "242424"))
                                .foregroundStyle(state.selectedBank == bank ? Color.black : Color.white)
                                .clipShape(Capsule())
                        }
                        .accessibilityIdentifier("bank_\(bank.rawValue)")
                    }
                }
            }
        }
    }

    private var quickActions: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            QuickAction(title: "История", icon: "clock.fill", color: state.theme.accent)
            QuickAction(title: "Переводы", icon: "arrow.left.arrow.right", color: state.theme.secondary)
            QuickAction(title: "Билеты", icon: "ticket.fill", color: state.theme.accent)
            QuickAction(title: "Аналитика", icon: "chart.bar.fill", color: state.theme.secondary)
        }
    }

    private var recentTransactions: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Последние операции").font(.headline)
                Spacer()
                Text("Все").foregroundStyle(state.theme.accent).font(.subheadline)
            }
            ForEach(state.visibleTransactions) { tx in
                NavigationLink {
                    TransactionDetailView(transaction: tx)
                } label: {
                    TransactionRow(transaction: tx, accent: state.theme.accent)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct QuickAction: View {
    let title: String
    let icon: String
    let color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: icon).foregroundStyle(color).font(.title3)
            Text(title).font(.subheadline.weight(.semibold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(hex: "171717"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    let accent: Color
    var body: some View {
        HStack {
            Image(systemName: "bag.fill")
                .frame(width: 42, height: 42)
                .background(Color(hex: "242424"))
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(transaction.merchant).font(.subheadline.weight(.semibold))
                Text(transaction.category).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Text(transaction.amount.rubles)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(transaction.amount < 0 ? Color.white : accent)
        }
    }
}

struct PlaceholderView: View {
    let title: String
    let icon: String
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon).font(.system(size: 44))
            Text(title).font(.title.bold())
            Text("Раздел будет доступен в следующем этапе").foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "080808"))
    }
}
