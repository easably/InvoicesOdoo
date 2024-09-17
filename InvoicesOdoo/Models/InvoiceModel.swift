//
//  Invoices.swift
//  InvoicesOdoo
//
//  Created by taqtile on 17.09.24.
//

import Foundation
struct InvoiceResponse: Codable {
    let jsonrpc: String
    let id: Int
    let result: [InvoiceModel]
}
struct InvoiceModel: Codable, Identifiable {
    var id: Int
    var name: String
//    var partner_id: [(Int, String)]
//    var invoice_date: String
    var amount_total: Double
}

