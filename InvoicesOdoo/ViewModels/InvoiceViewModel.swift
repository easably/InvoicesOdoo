

import Foundation

class InvoiceViewModel: ObservableObject {
    @Published var invoices: [InvoiceModel] = []

    func fetchInvoices() {
        // Define the URL and the JSON-RPC request body
        guard let url = URL(string: "http://164.92.166.52:8069/jsonrpc") else { return }

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
                        "fields": ["name", "partner_id", "invoice_date", "amount_total"],
                        "limit": 10
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
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
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
