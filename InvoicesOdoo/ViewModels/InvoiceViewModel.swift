//
//  InvoiceViewModel.swift
//  InvoicesOdoo
//
//  Created by taqtile on 17.09.24.
//

import Foundation

class InvoiceViewModel: ObservableObject {
    @Published var invoices: [InvoiceModel] = []

    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        self.invoices = try JSONDecoder().decode([InvoiceModel].self, from: data)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
        }

        task.resume()
    }
}
