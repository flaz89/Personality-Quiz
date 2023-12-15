//
//  Quedtion.swift
//  PersonalityQuiz
//
//  Created by Flavio Mammoliti on 12/12/23.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answer: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AppleProd
}

enum AppleProd: Character {
    case iphone = "📱"
    case tvOs = "📺"
    case macBook = "💻"
    case iMac = "🖥️"
    case watchOs = "⌚️"
    
    var definition: String {
        switch self {
        case .iphone:
            return "Adaptable and versatile: Like the iPhone, this personality is flexible and easily adapts to various situations. It can transition between contexts effortlessly, showcasing a wide range of interests and adaptability in social interactions."
        case .tvOs:
            return "Relaxed yet entertaining: The personality associated with tvOS is laid-back, enjoys the comfort of home, and cherishes leisure time. However, when needed, this personality can offer entertainment and engage others in social and recreational activities."
        case .macBook:
            return "Creative and organized: Similar to the MacBook, this personality leans towards creativity and innovation. It's highly organized, possessing an analytical and meticulous mind. It loves tackling creative challenges and working efficiently to achieve defined goals."
        case .iMac:
            return "Stylish and focused: The personality associated with the iMac is stylish, aesthetically aware, and detail-oriented. It's focused and goal-driven, striving to maintain impeccable style both in work and relationships."
        case .watchOs:
            return "Active and motivated: This personality is dynamic, action-oriented, and focused on maintaining a healthy and active lifestyle. It's motivated to achieve personal goals and seeks to optimize time, both in work and leisure."
        }
    }
    
}

