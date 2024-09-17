
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = InvoiceViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.invoices) { invoice in
                VStack(alignment: .leading) {
                    Text("ID: \(invoice.id)")
                    Text("Name: \(invoice.name)")
                        .font(.headline)
                    // Uncomment these lines if you want to display more details
                    // Text("Partner ID: \(invoice.partner_id[0])")
                    // Text("Invoice Date: \(invoice.invoice_date)")
                    Text("Amount Total: \(invoice.amount_total)")
                }
            }
            .navigationTitle("Invoices") // This is where you set the title
            .onAppear {
                viewModel.fetchInvoices()
            }
        }
    }
}





//import SwiftUI
//
//struct ContentView: View {
//    @StateObject private var networkManager = InvoiceViewModel()
//    
//    var body: some View {
//        NavigationView {
//            List(networkManager.invoices) { invoice in
//                NavigationLink(destination: InvoiceDetailView(invoice: invoice)) {
//                    VStack(alignment: .leading) {
//                        Text(invoice.title)
//                            .font(.headline)
//                        Text(invoice.body)
//                            .font(.subheadline)
//                            .lineLimit(2)
//                    }
//                }
//            }
//            .navigationTitle("Invoices")
//            .onAppear {
//                networkManager.fetchPosts()
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
