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
    var invoice_partner_display_name: String
    var date: String
    var create_date: String
    var amount_total: Double
    var payment_state: String
    var write_date: String
    var ref: StringOrBool
    var amount_tax: Double
    var amount_untaxed: Double
}

enum StringOrBool: Codable {
    case string(String)
    case bool(Bool)
    
    // Custom decoding based on the value's type
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let boolValue = try? container.decode(Bool.self) {
            self = .bool(boolValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(StringOrBool.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected String or Bool"))
        }
    }
    
    // Custom encoding based on the enum case
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        }
    }
}
