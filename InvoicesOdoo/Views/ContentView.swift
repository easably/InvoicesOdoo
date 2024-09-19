import SwiftUI
import PDFKit

struct ContentView: View {
    @ObservedObject var viewModel = InvoiceViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.invoices.filter {
                if case .bool(false) = $0.ref { // Filter for items where "ref" is false
                    return true
                }
                return false
            }) { invoice in
                NavigationLink(destination: InvoiceDetailView(invoice: invoice)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(invoice.invoice_partner_display_name)
                                .font(.headline)
                            Text("\(invoice.amount_total, specifier: "%.2f")")
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Image(systemName: "clock")
                                Text(invoice.date)
                            }
                            .font(.headline)
                            
                            Text(invoice.payment_state)
                                .padding(.horizontal, 6)
                                .background(invoice.payment_state == "paid" ? Color.green : Color.red)
                                .clipShape(Rectangle())
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .navigationTitle("Invoices")
            .onAppear {
                viewModel.fetchInvoices()
            }
        }
    }
}
