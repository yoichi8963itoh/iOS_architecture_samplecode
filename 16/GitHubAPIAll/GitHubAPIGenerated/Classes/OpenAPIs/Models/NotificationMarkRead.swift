//
// NotificationMarkRead.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct NotificationMarkRead: Codable {

    public var lastReadAt: String?

    public init(lastReadAt: String?) {
        self.lastReadAt = lastReadAt
    }

    public enum CodingKeys: String, CodingKey { 
        case lastReadAt = "last_read_at"
    }


}

