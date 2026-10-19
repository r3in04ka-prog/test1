import SwiftUI

// MARK: - Cards

struct CardsView: View {
    @EnvironmentObject private var state: AppState
    @State private var selectedCardID: String? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Мои карты").font(.largeTitle.bold())
                    cardsCarousel
                    Text("Операции по картам").font(.headline)
                    transactionsList
                }
                .padding(20)
            }
            .background(Color(hex: "080808"))
        }
    }

    private var cardsCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(state.visibleAccounts) { account in
                    CardFace(
                        account: account,
                        theme: BankTheme.forBank(account.bank),
                        selected: selectedCardID == account.id
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            selectedCardID = (selectedCardID == account.id ? nil : account.id)
                        }
                    }
                    .accessibilityIdentifier("card_\(account.id)")
                }
            }
        }
    }

    private var transactionsList: some View {
        VStack(spacing: 0) {
            ForEach(filteredTransactions) { tx in
                NavigationLink {
                    TransactionDetailView(transaction: tx)
                } label: {
                    TransactionRow(transaction: tx, accent: state.theme.accent)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var filteredTransactions: [Transaction] {
        guard let id = selectedCardID,
              let account = state.visibleAccounts.first(where: { $0.id == id }) else {
            return state.visibleTransactions
        }
        return state.visibleTransactions.filter { $0.maskedCard == account.maskedCard }
    }
}

struct CardFace: View {
    let account: BankAccount
    let theme: BankTheme
    let selected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack {
                Text(account.bankName).font(.headline)
                Spacer()
                Image(systemName: theme.symbol)
            }
            Spacer()
            Text(account.balance.rubles).font(.title.bold())
            Text("•••• \(account.maskedCard)").font(.subheadline.monospaced())
        }
        .padding(20)
        .frame(width: 280, height: 170, alignment: .topLeading)
        .foregroundStyle(.black)
        .background(
            LinearGradient(colors: [theme.accent, theme.secondary],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(selected ? Color.white : Color.clear, lineWidth: 2)
        )
    }
}

// MARK: - Transfer

struct TransferView: View {
    @EnvironmentObject private var state: AppState
    @State private var sourceID = "sber-main"
    @State private var amount = "1000"
    @State private var showReceipt = false
    @State private var errorText: String? = nil

    private var parsedAmount: Decimal? { Decimal(string: amount) }

    var body: some View {
        NavigationStack {
            Form {
                Section("Счёт списания") {
                    Picker("Счёт", selection: $sourceID) {
                        ForEach(state.repository.accounts) { a in
                            Text("\(a.bankName) •••• \(a.maskedCard)").tag(a.id)
                        }
                    }
                }
                Section("Получатель") {
                    Label("Иван Петров", systemImage: "person.fill")
                }
                Section("Сумма") {
                    TextField("0 ₽", text: $amount).keyboardType(.decimalPad)
                    quickAmounts
                    HStack {
                        Text("Комиссия")
                        Spacer()
                        Text("0 ₽")
                    }
                }
                if let errorText {
                    Section {
                        Text(errorText).foregroundStyle(.red).font(.footnote)
                    }
                }
                Section {
                    Button("Перевести") { submit() }
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(state.theme.accent)
                }
                Section {
                    Text("Демонстрационный режим: перевод не отправляется в банк и создаёт только локальный чек.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(hex: "080808"))
            .navigationTitle("Перевод")
            .sheet(isPresented: $showReceipt) {
                DemoReceiptView(amount: amount, recipient: "Иван Петров")
            }
        }
    }

    private var quickAmounts: some View {
        HStack {
            ForEach([Decimal(500), Decimal(1000), Decimal(5000)], id: \.self) { value in
                Button(value.rubles) { amount = "\(value)" }
                    .font(.caption)
            }
        }
    }

    private func submit() {
        guard let value = parsedAmount else {
            errorText = "Введите сумму"
            return
        }
        if state.isValidTransfer(amount: value, sourceID: sourceID) {
            errorText = nil
            showReceipt = true
        } else if value <= 0 {
            errorText = "Сумма должна быть больше нуля"
        } else {
            errorText = "Недостаточно средств на выбранном счёте"
        }
    }
}

struct DemoReceiptView: View {
    let amount: String
    let recipient: String
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)
            Text("Демонстрационный перевод").font(.title2.bold())
            Text("\(recipient) — \(amount) ₽").font(.headline)
            Text("Реальные деньги не переводились").foregroundStyle(.secondary)
        }
        .padding(30)
        .presentationDetents([.medium])
    }
}

// MARK: - Transaction detail

struct TransactionDetailView: View {
    @EnvironmentObject private var state: AppState
    let transaction: Transaction

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                statusTracker
                infoCard
            }
            .padding(20)
        }
        .background(Color(hex: "080808"))
        .navigationTitle("Операция")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(transaction.merchant).font(.title2.bold())
            Text(transaction.amount.rubles)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(transaction.amount < 0 ? Color.white : state.theme.accent)
            Text(transaction.category).foregroundStyle(.secondary)
        }
    }

    private var statusTracker: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Статус").font(.headline)
            HStack(alignment: .top, spacing: 0) {
                ForEach(0..<3, id: \.self) { index in
                    stepView(index: index)
                }
            }
        }
    }

    private func stepView(index: Int) -> some View {
        let labels = ["Отправлено", "В обработке", "Завершено"]
        let on = transaction.status.step >= index
        return VStack(spacing: 6) {
            Circle()
                .fill(on ? state.theme.accent : Color(hex: "242424"))
                .frame(width: 12, height: 12)
            Text(labels[index])
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private var infoCard: some View {
        VStack(spacing: 0) {
            infoRow("Карта", "•••• \(transaction.maskedCard)")
            infoRow("Дата", transaction.date.formatted(date: .abbreviated, time: .shortened))
            infoRow("Категория", transaction.category)
            infoRow("Банк", transaction.bank.title)
        }
        .padding(16)
        .background(Color(hex: "171717"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func infoRow(_ key: String, _ value: String) -> some View {
        HStack {
            Text(key).foregroundStyle(.secondary)
            Spacer()
            Text(value).fontWeight(.semibold)
        }
        .font(.subheadline)
        .padding(.vertical, 10)
    }
}
