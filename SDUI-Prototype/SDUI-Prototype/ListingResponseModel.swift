//
//  GenericListResponseModel.swift
//  Practo
//
//  Created by Mohana Chaudhury on 31/07/21.
//  Copyright © 2021 Practo. All rights reserved.
//

import Foundation

// MARK: - Listing Response
struct ListData: Codable {
    let id: String?
    let version: Int?
    let layout: Layout?
    let sections: [SectionElement]?
}

// MARK: - Layout
struct Layout: Codable {
    let nav: LayoutTypes?
    let body: LayoutTypes?
    let footer: LayoutTypes?
}

// MARK: - LayoutTypes
struct LayoutTypes {
    let type: LayoutTypesEnum?
    var sectionDetails: SectionDetail?
    var sectionDetailsArr: [SectionDetail]?

    enum CodingKeys: String, CodingKey {
        case type
        case additionalSectionInfo
    }
    
    enum AdditionalSectionInfoKeys: String, CodingKey {
        case sectionDetails = "section_details"
        case sectionDetailsArr
    }
}

extension LayoutTypes: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let typeRawVal = try values.decode(String.self, forKey: .type)
        type = LayoutTypesEnum(rawValue: typeRawVal)
        
        sectionDetails = nil
        sectionDetailsArr = nil
        
        let additionalSectionInfo = try values.nestedContainer(keyedBy: AdditionalSectionInfoKeys.self, forKey: .additionalSectionInfo)
        switch type {
        case .single:
            sectionDetails = try additionalSectionInfo.decode(SectionDetail.self, forKey: .sectionDetails)
            
        case .multiple:
            sectionDetailsArr = try additionalSectionInfo.decode([SectionDetail].self, forKey: .sectionDetails)
            
        case .none:
            print("Error in decoding section details")
        }
    }
}

extension LayoutTypes: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type?.rawValue, forKey: .type)
        
        var additionalSectionInfo = container.nestedContainer(keyedBy: AdditionalSectionInfoKeys.self, forKey: .additionalSectionInfo)
        
        switch type {
        case .single:
            try additionalSectionInfo.encode(sectionDetails, forKey: .sectionDetails)
            
        case .multiple:
            try additionalSectionInfo.encode(sectionDetailsArr, forKey: .sectionDetailsArr)
            
        case .none:
            print("Error in decoding section details")
        }
    }
}

enum LayoutTypesEnum: String {
    case single = "single_section"
    case multiple = "multi_section"
}

// MARK: - SectionDetail
struct SectionDetail: Codable {
    let sectionID: String?

    enum CodingKeys: String, CodingKey {
        case sectionID = "section_id"
    }
}

// MARK: - SectionDetails
struct EventData: Codable {
}

// MARK: - SectionElement
struct SectionElement: Codable {
    let id: String?
    let section: SectionDisplayData?
}

// MARK: - SectionSection
struct SectionDisplayData: Codable {
    let id: String?
    let version: Version?
    let content: ContentData?
    let interactions: Interactions?
    let modifiers: Modifiers?
}

// MARK: - Content
struct ContentData: Codable {
    let title, firstCtaText, secondCtaText, imageURL: String?
    let subtitle, headerLine1, headerLine2: String?
    let headerLine2_Icon: String?
    let bodyLine1: String?
    let bodyLine1_Icon: String?
    let bodyLine2: String?
    let bodyLine2_Icon: String?
    let bodyLine3: String?
    let bodyLine3_Icon: String?
    let primaryCtaText: String?

    enum CodingKeys: String, CodingKey {
        case title
        case firstCtaText = "first_cta_text"
        case secondCtaText = "second_cta_text"
        case imageURL = "image_url"
        case subtitle
        case headerLine1 = "header_line_1"
        case headerLine2 = "header_line_2"
        case headerLine2_Icon = "header_line_2_icon"
        case bodyLine1 = "body_line_1"
        case bodyLine1_Icon = "body_line_1_icon"
        case bodyLine2 = "body_line_2"
        case bodyLine2_Icon = "body_line_2_icon"
        case bodyLine3 = "body_line_3"
        case bodyLine3_Icon = "body_line_3_icon"
        case primaryCtaText = "primary_cta_text"
    }
}

// MARK: - Interactions
struct Interactions: Codable {
    let onPress: InteractionData?
    let onView: InteractionData?

    enum CodingKeys: String, CodingKey {
        case onPress = "on_press"
        case onView = "on_view"
    }
}

// MARK: - OnPress
struct InteractionData: Codable {
    let actions: [ActionObject]?
    let events: [Event]?
}

// MARK: - ActionObject
struct ActionObject: Codable {
    let element, type: String?
    let data: ActionableData?
}

// MARK: - DataClass
struct ActionableData: Codable {
    let bottomSheetID: BottomSheetTypeEnum?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case bottomSheetID = "bottom_sheet_id"
        case url
    }
}

enum BottomSheetTypeEnum: String, Codable {
    case availability
    case language
}

// MARK: - Event
struct Event: Codable {
    let element: String?
    let type: TypeEnum?
    let data: EventData?
}

enum TypeEnum: String, Codable {
    case pel
}

// MARK: - Modifiers
struct Modifiers: Codable {
    let bold: [ModifierType]?
}

// MARK: - Bold
struct ModifierType: Codable {
    let element: String?
    let identifier: String?
    let displayText: String?

    enum CodingKeys: String, CodingKey {
        case element
        case identifier
        case displayText = "display_text"
    }
}

// MARK: - Version
enum Version: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Version.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Version"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
