import Foundation
import SwiftUI

enum TaskPriority : String, CaseIterable {
    case urgent, normal, optional
    
    var title : String {
        switch self{
        case .urgent:
            return "Urgent"
        case .normal:
            return "Normal"
        case .optional:
            return "Optional"

        }
    }
    
    var color : Color {
        switch self{
        case .urgent:
            return Color.urgent
        case .normal:
            return Color.normal
        case .optional:
            return Color.optional
        }
    }
}
