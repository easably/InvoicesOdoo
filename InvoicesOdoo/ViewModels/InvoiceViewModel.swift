

import Foundation
import PDFKit
import SwiftUI
class InvoiceViewModel: ObservableObject {
    @Published var invoices: [InvoiceModel] = []
    @Published var pdfURL: URL? = nil

    func fetchInvoices() {
        // Define the URL and the JSON-RPC request body
        guard let url = URL(string: "http://164.92.166.52:8069/jsonrpc?download=true") else { return }

        // Create the request body
        let requestBody: [String: Any] = [
            "jsonrpc": "2.0",
            "method": "call",
            "params": [
                "service": "object",
                "method": "execute_kw",
                "args": [
                    "odoo_17",  // db
                    2,  // user_id
                    "just4Taqtile",  // password
                    "account.move",  // model
                    "search_read",  // method
                    [],  // search conditions
                    [
//                        "fields": ["name", "partner_id", "invoice_date", "amount_total"],
//                    "limit": 10,
                    ]
                ]
            ],
            "id": 2
        ]

        // Convert request body to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
            print("Error: Cannot serialize request body to JSON")
            return
        }

        // Create the URLRequest object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        

        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
           
            guard let data = data else {
                print("Error: No data received")
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                      print("Response JSON: \(jsonString)")
                  }
            // Parse the JSON response
            do {
                let invoiceResponse = try JSONDecoder().decode(InvoiceResponse.self, from: data)
                DispatchQueue.main.async {
                    self.invoices = invoiceResponse.result
                    
                    // Now get the PDF for the first invoice in the result
                                        if let firstInvoice = invoiceResponse.result.first {
                                            self.downloadInvoicePDF(invoiceID: firstInvoice.id)
                                        }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }
    func downloadInvoicePDF(invoiceID: Int) {
        // Define the URL for downloading the invoice PDF
        guard let pdfURL = URL(string: "http://164.92.166.52:8069/jsonrpc/report/pdf/account.report_invoice/\(invoiceID)?download=true") else {
            print("Invalid URL")
            return
        }
        
        // Create the URLRequest object for the PDF request
        var request = URLRequest(url: pdfURL)
        request.httpMethod = "GET"
        
        // Perform the network request to download the PDF
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error downloading PDF: \(error)")
                return
            }
            
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            // Save the PDF data locally, or display it as needed
            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let pdfFileURL = documentsURL.appendingPathComponent("invoice_\(invoiceID).pdf")
            
            do {
                try data.write(to: pdfFileURL)
                print("Invoice PDF saved to: \(pdfFileURL)")
                DispatchQueue.main.async {
                                    self.pdfURL = pdfFileURL
                                }
            } catch {
                print("Error saving PDF: \(error)")
            }
        }
        
        task.resume()
    }
    struct PDFKitView: UIViewRepresentable {
        let url: URL
        
        func makeUIView(context: Context) -> PDFView {
            let pdfView = PDFView()
            if let document = PDFDocument(url: url) {
                pdfView.document = document
                pdfView.autoScales = true
            }
            return pdfView
        }
        
        func updateUIView(_ uiView: PDFView, context: Context) {
            // No need to update view in this case
        }
    }

}


//
//import Foundation
//
//class InvoiceViewModel: ObservableObject {
//    @Published var invoices: [InvoiceModel] = []
//
//    func fetchPosts() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                DispatchQueue.main.async {
//                    do {
//                        self.invoices = try JSONDecoder().decode([InvoiceModel].self, from: data)
//                    } catch {
//                        print("Error decoding JSON: \(error)")
//                    }
//                }
//            }
//        }
//
//        task.resume()
//    }
//}
//
//
