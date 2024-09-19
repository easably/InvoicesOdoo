import SwiftUI
import PDFKit

struct InvoiceDetailView: View {
    @ObservedObject var viewModel = InvoiceViewModel()
    let invoice: InvoiceModel

    var body: some View {
        VStack(alignment: .leading) {
            ItemDetailView(title: "Invoice:", value: invoice.name)
            ItemDetailView(title: "Customer:", value: invoice.invoice_partner_display_name)
            ItemDetailView(title: "Date:", value: invoice.date)
            ItemDetailView(title: "Amount:", value: String(format: "%.2f", invoice.amount_untaxed))
            ItemDetailView(title: "Tax:", value: String(format: "%.2f", invoice.amount_tax))
            ItemDetailView(title: "Total amount:", value: String(format: "%.2f", invoice.amount_total))
            ItemDetailView(title: "Payment State:", value: invoice.payment_state)

        
//            Text("Amount: \(invoice.amount_total, specifier: "%.2f")")
//            Text("Date: \(invoice.date)")
//            Text("Payment State: \(invoice.payment_state)")
//            
//             Uncomment if you want to display a PDF for the invoice
//            if let pdfURL = viewModel.pdfURL {
//                PDFKitView(url: viewModel.pdfURL)
//                .frame(maxHeight: .infinity)
//            } else {
//                Text("No PDF available")
//            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Invoice Details")
    }
}

// PDFKitView to display PDFs in the detail view
struct PDFKitView: UIViewRepresentable {
    let url: URL? // The URL of the PDF file
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true // Automatically adjust the scale of the PDF
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        // Load the PDF document from the provided URL
        if let url = url, let document = PDFDocument(url: url) {
            pdfView.document = document
        }
    }
}
