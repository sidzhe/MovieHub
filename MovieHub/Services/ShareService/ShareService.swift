//
//  ShareService.swift
//  MovieHub
//
//  Created by Igor Guryan on 13.01.2024.
//

import UIKit

final class ShareService {
    init() {
        
    }
    
    func getAvailableApps() -> [App] {
//        App.allCases.filter {
//            guard let url = $0.getUrl("Проверка связи") else {
//                return false
//            }
//            return UIApplication.shared.canOpenURL(url)
//        }
        return App.allCases
    }
}

extension ShareService {
    
    struct ShareApp {
        let type: App
        let icon: UIImage
        let shareAction: () -> Void
    }
    
    enum App: CaseIterable {
        case imessage, telegram, whatsapp, other
        
        var icon: UIImage {
            switch self {
            case .telegram:
                return .Socials.telegram
            case .whatsapp:
                return .Socials.whatsapp
            case .imessage:
                return .Socials.sms
            case .other:
                return .Socials.other.withRenderingMode(.alwaysTemplate)
            }
        }
        
        func getUrl(_ text: String) -> URL? {
            switch self {
            case .telegram:
                return URL(string: "tg://msg?text=\(text)")
            case .whatsapp:
                return URL(string: "whatsapp://send?text=\(text)")
            case .imessage:
                return URL(string: "sms:?&body=\(text)")
            default:
                return nil
            }
        }
        
        
        
    }
}
