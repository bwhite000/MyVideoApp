//
//  Video.swift
//  MyVideoApp
//
//  Created by Brandon White on 6/13/15.
//  Copyright (c) 2015 Rock Valley College. All rights reserved.
//

import Foundation
import CoreData

class Video: NSManagedObject {

    @NSManaged var datestamp: String
    @NSManaged var link: String
    @NSManaged var name: String

}
