import SwiftUI

struct CardsView: View {
    @EnvironmentObject private var state: AppState
    var body: some View { NavigationStack { ScrollView { VStack(alignment: .leading, spacing: 20) {
        Text("Мои карты").font(.largeTitle.bold())
        ScrollView(.horizontal, showsIndicators: false) { HStack(spacing: 14) { ForEach(state.visibleAccounts) { account in
            VStack(alignment: .leading, spacing: 22) { HStack { Text(account.bankName).font(.headline); Spacer(); Image(systemName: state.theme.symbol) }; Spacer(); Text(account.balance.rubles).font(.title.bold()); Text("•••• \(account.maskedCard)").font(.subheadline.monospaced()) }.padding(20).frame(width: 280, height: 170, alignment: .topLeading).foregroundStyle(.black).background(LinearGradient(colors: [state.theme.accent, state.theme.secondary], startPoint: .topLeading, endPoint: .bottomTrailing)).clipShape(RoundedRectangle(cornerRadius: 22))
        } } }
        Text("Операции по картам").font(.headline)
        ForEach(state.visibleTransactions) { tx in TransactionRow(transaction: tx, accent: state.theme.accent) }
    }.padding(20) }.background(Color(hex:"080808")) } }
}

struct TransferView: View {
    @EnvironmentObject private var state: AppState
    @State private var sourceID = "sber-main"
    @State private var amount = "1000"
    @State private var showReceipt = false
    var body: some View { NavigationStack { Form {
        Section("Счёт списания") { Picker("Счёт", selection: $sourceID) { ForEach(state.repository.accounts) { a in Text("\(a.bankName) •••• \(a.maskedCard)").tag(a.id) } } }
        Section("Получатель") { Label("Иван Петров", systemImage: "person.fill") }
        Section("Сумма") { TextField("0 ₽", text: $amount).keyboardType(.decimalPad); HStack { Text("Комиссия"); Spacer(); Text("0 ₽") } }
        Section { Button("Перевести") { if let value = Decimal(string: amount), value > 0 { showReceipt = true } }.frame(maxWidth: .infinity).foregroundStyle(state.theme.accent) }
        Section { Text("Демонстрационный режим: перевод не отправляется в банк и создаёт только локальный чек.").font(.footnote).foregroundStyle(.secondary) }
    }.scrollContentBackground(.hidden).background(Color(hex:"080808")).navigationTitle("Перевод").sheet(isPresented: $showReceipt) { DemoReceiptView(amount: amount) } } }
}

struct DemoReceiptView: View { let amount: String; var body: some View { VStack(spacing: 20) { Image(systemName: "checkmark.circle.fill").font(.system(size: 60)).foregroundStyle(.green); Text("Демонстрационный перевод").font(.title2.bold()); Text("Ивану Петрову отправлено \(amount) ₽"); Text("Реальные деньги не переводились").foregroundStyle(.secondary) }.padding(30).presentationDetents([.medium]) } }
