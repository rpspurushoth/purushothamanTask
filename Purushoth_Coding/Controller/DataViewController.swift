//
//  DataViewController.swift
//  Purushoth_Coding
//
//  Created by AEL5625 on 19/12/19.
//  Copyright © 2019 AEL5106. All rights reserved.
//

import UIKit
import SDWebImage

class DataViewController: UIViewController {
    var apiservice = APIService()
    var alertInformation = AlertInformation()
    weak var canadaCollectionView: UICollectionView!
    var rowsData : [DataModel] = []
    private let refreshControl = UIRefreshControl()

    override func loadView() {
        super.loadView()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.canadaCollectionView = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canadaCollectionView.delegate = self
        canadaCollectionView.dataSource = self
        self.canadaCollectionView.alwaysBounceVertical = true
        self.canadaCollectionView.backgroundColor = .white
        canadaCollectionView.register(DataCollectionViewCell.self,
                                      forCellWithReuseIdentifier: "DataCollectionViewCell")
        canadaCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshUpdateData(_:)),
                                 for: .valueChanged)
        webServiceCall()
    }
    
    func calculateHeight(inString: String,
                         fontSize: UIFont,
                         width: CGFloat) -> CGFloat {
        let messageString = inString
    
        let attributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : fontSize]
        let attributedString : NSAttributedString = NSAttributedString(string: messageString,
                                                                       attributes: attributes)
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: width,
                                                                       height: CGFloat.greatestFiniteMagnitude),
                                                                        options: .usesLineFragmentOrigin, context: nil)
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
    @objc private func refreshUpdateData(_ sender: Any) {
        webServiceCall()
    }
    
    func webServiceCall() {
        if(NetworkConnectivity.networkConnectionAvailable) {
            apiservice.apiCallFromServer(urlString: "") {(response,
                                                          message,
                                                          success) in
                if success {
                    if response != nil {
                        let dataArrayDict = response?.toJSON() as! NSDictionary
                        self.title = dataArrayDict.value(forKey: "title") as? String
                        let dataArray = dataArrayDict.value(forKey: "rows") as! NSArray
                        for dict in dataArray {
                            let single = DataModel(dataJSON: dict as! NSDictionary)
                            self.rowsData.append(single)
                        }
                        DispatchQueue.main.async {
                            self.refreshControl.endRefreshing()
                            self.canadaCollectionView.reloadData()
                        }
                    }
                } else {
                    self.alertInformation.displayAlertMessage(message: response!,
                                                              title: "Error",
                                                              controller: self)
                }
                
            }
        } else {
            alertInformation.displayAlertMessage(message: "Please check network connectivity",
                                                 title: "",
                                                 controller: self)
        }
    }
}

extension DataViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return rowsData.count > 0 ? rowsData.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCollectionViewCell.identifier,
                                                      for: indexPath) as! DataCollectionViewCell
        guard rowsData.count > 0 else {
            return cell
        }
        let model: DataModel = rowsData[indexPath.row]

        cell.aboutDescriptionLabel.isHidden = (model.descriptions == "") ? true : false
        cell.aboutTitleLabel.isHidden = (model.title == "") ? true : false
        
        cell.aboutTitleLabel.text = model.title
        cell.aboutDescriptionLabel.text = model.descriptions
        
        cell.aboutCanadaImageView.sd_setImage(with: URL(string: model.imageHref ?? ""),
                                              placeholderImage: UIImage(named: "noImage.png"))
        return cell
    }
}

extension DataViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model: DataModel = rowsData[indexPath.row]
        let titleHeight = self.calculateHeight(inString: model.title ?? "", fontSize: UIFont.boldSystemFont(ofSize: 14), width: collectionView.bounds.width / 2 - 10)
        let descriptionHeight = self.calculateHeight(inString: model.descriptions ?? "", fontSize: UIFont.systemFont(ofSize: 12), width: collectionView.bounds.width / 2 - 10)
        let overallHeight = titleHeight + descriptionHeight + 120
        return CGSize(width: collectionView.bounds.width / 2 - 10 , height: overallHeight )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8,
                                   allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data,
                                                 options: .mutableContainers)
    }
}
