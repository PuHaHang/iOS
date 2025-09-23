//
//  ErrorHandling.swift
//  Presentation
//
//  Created by PuHaHang on 1/20/25.
//

import Foundation

// MARK: - 에러 표시 방식 정의

enum ErrorDisplayType: Equatable {
    case toast(message: String, duration: TimeInterval = 3.0)
    case dialog(title: String, message: String, showBackButton: Bool = true)
    
    var message: String {
        switch self {
        case .toast(let message, _):
            return message
        case .dialog(_, let message, _):
            return message
        }
    }
    
    var title: String? {
        switch self {
        case .toast(_, _):
            return nil
        case .dialog(let title, _, _):
            return title
        }
    }
}

// MARK: - 에러 상태 관리

struct ErrorHandlingState: Equatable {
    var showToast: Bool = false
    var toastMessage: String = ""
    var toastDuration: TimeInterval = 3.0
    
    var showDialog: Bool = false
    var dialogTitle: String = ""
    var dialogMessage: String = ""
    var showBackButton: Bool = true
    
    var currentErrorType: ErrorDisplayType?
    
    mutating func clearError() {
        showToast = false
        showDialog = false
        toastMessage = ""
        dialogTitle = ""
        dialogMessage = ""
        showBackButton = true
        currentErrorType = nil
        toastDuration = 3.0
    }
    
    mutating func showError(_ errorType: ErrorDisplayType) {
        clearError()
        currentErrorType = errorType
        
        switch errorType {
        case .toast(let message, let duration):
            toastMessage = message
            toastDuration = duration
            showToast = true
            
        case .dialog(let title, let message, let showBackButton):
            dialogTitle = title
            dialogMessage = message
            self.showBackButton = showBackButton
            showDialog = true
        }
    }
}
