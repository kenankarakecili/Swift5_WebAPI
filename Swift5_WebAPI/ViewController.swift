//
//  ViewController.swift
//  Swift5_WebAPI
//
//  Created by Kenan Karakecili on 28/5/19.
//  Copyright © 2019 karakecili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	
	var listOfHolidays: [HolidayDetail] = [] {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.navigationItem.title = "\(self.listOfHolidays.count) holidays found"
			}
		}
	}
	
}

extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listOfHolidays.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
		let holiday = listOfHolidays[indexPath.row]
		cell.lbTitle.text = holiday.name
		cell.lbSubtitle.text = holiday.date.iso
		return cell
	}
	
}

extension ViewController: UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text else { return }
		let holidayRequest = HolidayRequest(countryCode: searchText)
		holidayRequest.getHolidays { [weak self] result in
			switch result {
			case .failure(let error):
				print(error)
			case .success(let holidays):
				self?.listOfHolidays = holidays
			}
		}
	}
	
}
