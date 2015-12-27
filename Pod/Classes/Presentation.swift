//
//  Presentation.swift
//  CRToastSwift
//
//  Copyright (c) 2015 Masahiko Tsujita <tsujitamasahiko.dev@icloud.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import CRToast

public typealias InteractionType = CRToastInteractionType

public final class Presentation<T: NotificationType> {
    
    init(notification: T) {
        
    }
    
    let dismissalEvent = Event<T>()
    
    public func onDismissal(handler: (T) -> Void) -> Self {
        self.dismissalEvent.addHandler(handler)
        return self
    }
    
    let interactionEvent = Event<(InteractionType, T, NotificationDismisser)>()
    
    public func onInteraction(handler: (InteractionType, T, NotificationDismisser) -> Void) -> Self {
        self.interactionEvent.addHandler(handler)
        return self
    }
    
    private func onInteractionOfType(type: InteractionType, handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteraction {
            if !$0.intersect(type).isEmpty {
                handler($1, $2)
            }
        }
    }
    
    public func onTapOnce(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.TapOnce, handler: handler)
    }
    
    public func onTapTwice(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.TapTwice, handler: handler)
    }
    
    public func onTwoFingerTapOnce(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.TwoFingerTapOnce, handler: handler)
    }
    
    public func onTwoFinderTapTwice(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.TwoFingerTapTwice, handler: handler)
    }
    
    public func onSwipeUp(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.SwipeUp, handler: handler)
    }
    
    public func onSwipeLeft(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.SwipeLeft, handler: handler)
    }
    
    public func onSwipeDown(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.SwipeDown, handler: handler)
    }
    
    public func onSwipeRight(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.SwipeRight, handler: handler)
    }
    
    public func onAnyTap(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.Tap, handler: handler)
    }
    
    public func onAnySwipe(handler: (T, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.Swipe, handler: handler)
    }
    
}

public struct NotificationDismisser {
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    let identifier: String
    
    public func dismiss(animated animated: Bool = true) {
        CRToastManager.dismissAllNotificationsWithIdentifier(identifier, animated: animated)
    }
    
}
