//
//  PlaceViewController.swift
//  SveaApps
//
//  Created by Ansal Antony on 13/02/23.
//

import UIKit

class PlaceViewController: UIViewController {
    
    @IBOutlet weak var tableViewPlaceList: UITableView!
    
    let placeViewModel = PlaceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNib()
        takePlaceList()
    }
    
    private func setupView(){
        navigationItem.title = Constants.appTitle
    }
    private func setupNib(){
        
        tableViewPlaceList.register(UINib(nibName: Constants.nibId.placeListTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.nibId.placeListTableViewCell)
    }
    
    func takePlaceList (){
        // show loader loader
        placeViewModel.fetchPlaceList { [weak self] (result: Result<PlaceListModel, Error>) in
            switch result {
            case .success(let places):
                // Hide loader
                DispatchQueue.main.async {
                    print(places)
                    self?.tableViewPlaceList.reloadData()
                }
            case .failure(let error):
                // Hide loader
                DispatchQueue.main.async {
                    self?.alertPresent(title: "", message: error.localizedDescription)
                    print(error)
                }
            }
        }
        
    }
    
}


// MARK: Table view Data source

extension PlaceViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeViewModel.placeList?.place.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewPlaceList.dequeueReusableCell(withIdentifier: Constants.nibId.placeListTableViewCell, for: indexPath) as! PlaceListTableViewCell
         let placeModel = placeViewModel.placeList?.place[indexPath.row]
        if let place = placeModel{
            cell.configureCell(placeVal: place)
        }
        cell.buttonInfo.addTarget(self, action: #selector(moreInfo(sender:)), for: .touchUpInside)
        cell.buttonInfo.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
   
    @objc func moreInfo(sender: UIButton){
        let buttonTag = sender.tag
        let viewController = PlaceDetailViewController.make()
        viewController.placeDetails = placeViewModel.placeList?.place[buttonTag]
        navigationController?.present(viewController, animated: true)
    }
    
}
