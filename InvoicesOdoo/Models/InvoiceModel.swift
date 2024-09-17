//
//  Invoices.swift
//  InvoicesOdoo
//
//  Created by taqtile on 17.09.24.
//

import Foundation

struct InvoiceModel: Identifiable, Codable {
    let id: Int
    let title: String
    let body: String
}
