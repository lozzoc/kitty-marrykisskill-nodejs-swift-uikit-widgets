//
//  ZeusToggles.swift
//  Mkk-iOS
//
//  Created by Conner M on 11/14/21.
//

import Foundation


class ZeusToggles {
    
    static let shared: ZeusToggles = ZeusToggles()
    private var hasReadTutorial: Bool
    private var hasReadListTutorial: Bool

    var didLoad: Bool
    var toggles: ZeusFeatureToggles
    
    private init() {
        self.didLoad = false
        self.toggles = ZeusFeatureToggles(instantPushKitty: false)
        self.hasReadTutorial = UserDefaults.standard.bool(forKey: "hasReadTutorial")
        self.hasReadListTutorial = UserDefaults.standard.bool(forKey: "hasReadListTutorial")
    }
    
    func hasReadTutorialCheck() -> Bool {
        return hasReadTutorial
    }
    func setHasReadTutorial() {
        hasReadTutorial = true
        UserDefaults.standard.set(true, forKey: "hasReadTutorial")
    }
    func hasReadListTutorialCheck() -> Bool {
        return hasReadListTutorial
    }
    func setHasReadListTutorial() {
        hasReadListTutorial = true
        UserDefaults.standard.set(true, forKey: "hasReadListTutorial")
    }
}
