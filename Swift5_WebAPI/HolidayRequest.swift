//
//  HolidayRequest.swift
//  Swift5_WebAPI
//
//  Created by Kenan Karakecili on 28/5/19.
//  Copyright © 2019 karakecili. All rights reserved.
//

import Foundation

struct HolidayRequest {
  let resourceURL: URL
  let API_KEY = ""
  
  init(countryCode :String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    let currentYear = formatter.string(from: Date())
    let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
    guard let resourceURL = URL(string: resourceString) else { fatalError() }
    self.resourceURL = resourceURL
  }
  
//  func getHolidays(completion: @escaping (Result<[HolidayDetail], Error>)) -> Void {
//
//  }
  
}
