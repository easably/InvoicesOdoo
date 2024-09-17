import SwiftUI

struct ContentView: View {
    @StateObject private var networkManager = InvoiceViewModel()
    
    var body: some View {
        NavigationView {
            List(networkManager.invoices) { invoice in
                NavigationLink(destination: InvoiceDetailView(invoice: invoice)) {
                    VStack(alignment: .leading) {
                        Text(invoice.title)
                            .font(.headline)
                        Text(invoice.body)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }
            }
            .navigationTitle("Invoices")
            .onAppear {
                networkManager.fetchPosts()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
