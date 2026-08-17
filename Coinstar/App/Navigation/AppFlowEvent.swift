//
//  AppFlowEvent.swift
//  Coinstar
//
//  Created by Akshay Matre on 16/08/26.
//
import Foundation

enum AppFlowEvent {
    case onboardingCompleted
    case accountVerificationCompleted
    case registrationCompleted
    case loginCompleted
}

protocol AppFlowEventSink: AnyObject {
    func send(_ event: AppFlowEvent)
}
