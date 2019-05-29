//
//  HolidayRequest.swift
//  Swift5_WebAPI
//
//  Created by Kenan Karakecili on 28/5/19.
//  Copyright © 2019 karakecili. All rights reserved.
//

import Foundation

enum HolidayError: Error {
	case noDataAVailable
	case cannotProcessData
}

struct HolidayRequest {
	let resourceURL: URL
	let API_KEY = "151c7d2b0f2fb2e9905ef1738ce455875dec226c"
	
	init(countryCode :String) {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy"
		let currentYear = formatter.string(from: Date())
		let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
		guard let resourceURL = URL(string: resourceString) else { fatalError() }
		self.resourceURL = resourceURL
	}
	
	func getHolidays(completion: @escaping (Result<[HolidayDetail], HolidayError>) -> Void) {
		let dataTask = URLSession.shared.dataTask(with: resourceURL) { (data, _, _) in
			guard let jsonData = data else { completion(.failure(.noDataAVailable)); return }
			do {
				let decoder = JSONDecoder()
				let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
				let holidayDetails = holidayResponse.response.holidays
				completion(.success(holidayDetails))
			} catch {
				completion(.failure(.cannotProcessData))
			}
		}
		dataTask.resume()
	}
	
}
