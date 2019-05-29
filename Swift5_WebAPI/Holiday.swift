//
//  Holiday.swift
//  Swift5_WebAPI
//
//  Created by Kenan Karakecili on 28/5/19.
//  Copyright © 2019 karakecili. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
  var response: Holidays
}

struct Holidays: Decodable {
  var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
  var name: String
  var dateInfo: DateInfo
}

struct DateInfo: Decodable {
  var iso: String
}
