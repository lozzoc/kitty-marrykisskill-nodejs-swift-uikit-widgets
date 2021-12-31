//
//  Data.swift
//  TodoLocalStorage
//
//  Created by Conner M on 1/14/21.
//

import Foundation
import RealmSwift

class KPhotoRealm: Object {
    @objc dynamic var  img: Data? = nil;
    @objc dynamic var imgurl: String = ""


}

class KittyRealm: Object {
    @objc dynamic var uid:String = UUID().uuidString
    @objc dynamic var birthday: Double = Date().timeIntervalSince1970
    @objc dynamic var name: String = ""
    @objc dynamic var photoLink: KPhotoRealm?
    @objc dynamic var statsLink: KStatsRealm?


}

/*javascript redux action creator similar

func createKittyActionCreator(kitty) {
    return {
        type,
        value: {
            @objc dynamic var uid:String = UUID().uuidString
            @objc dynamic var birthday: Double = Date().timeIntervalSince1970
            @objc dynamic var name: String = ""
            @objc dynamic var photoLink: KPhotoRealm?
            @objc dynamic var statsLink: KStatsRealm?

        }
    }
}
 */


class KStatsRealm: Object {
    @objc dynamic  var breedid: String = ""
    @objc dynamic  var name: String = ""
    @objc dynamic  var temperament: String = ""
    @objc dynamic  var kitty_description: String = ""
    @objc dynamic  var life_span: String = ""
    @objc dynamic  var dog_friendly: Int = 0
    @objc dynamic  var intelligence: Int = 0
    @objc dynamic  var energy_level: Int = 0
    @objc dynamic var shedding_level: Int = 0
    @objc dynamic  var stranger_friendly: Int = 0
    @objc dynamic  var origin: String = ""
    
}

class WanderingKittyRealm: Object {
    @objc dynamic var breedid: String = ""
    @objc dynamic var toysInteracted: String = "" //comma seperated list of enums.. friggen rediculous array of strings is not supported. i guess i will ahve to find the equvilent
    @objc dynamic var statsLink: KStatsRealm?
}
