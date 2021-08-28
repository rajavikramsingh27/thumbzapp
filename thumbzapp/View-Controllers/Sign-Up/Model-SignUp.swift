//
//  Model-SignUp.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 20/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation

final class Model_SignUp {
    static let shared = Model_SignUp()
    
    var userType = "0"
    
}



enum Enum_SignUp :String {
    case clientType = "1"
    case trainerType = "2"
}
