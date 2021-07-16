//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var albumsTableView: UITableView!
    private var albumViewModel = AlbumViewModel()
    
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Albums"
        self.registerTableViewCells()
        callingAlbumAPI()
        ActivityIndicatorView.sharedInstance.showActivityIndicator(targetView: self.view)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool){
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Registering Table View Cell
    private func registerTableViewCells() {
        let albumTableCell = UINib(nibName: "AlbumTableCell",
                                   bundle: nil)
        self.albumsTableView.register(albumTableCell,
                                      forCellReuseIdentifier: "AlbumTableViewCell")
    }
    
    //MARK: - Calling Album API
    func callingAlbumAPI() {
        let isInternetAvailable = self.checkingNetworkAvailability()
        if isInternetAvailable {
            albumViewModel.fetchAlbumData (urlEndPoint:AppConstants.albumsEndpoint, completion: { (isSuccess,error)  in
                DispatchQueue.main.async {
                    ActivityIndicatorView.sharedInstance.hideActivityIndicator(targetView: self.view)
                }
                if isSuccess && (error == nil || error == "") {
                    self.callingPhotosAPI()
                    
                }
                else if !isSuccess && error != "" {
                    DispatchQueue.main.async {
                        ActivityIndicatorView.sharedInstance.hideActivityIndicator(targetView: self.view)
                        AppAlertView.showAlertViewWithOKButton(vc : self, titleString : AppConstants.ALERT_TITLE, messageString: error!)
                    }
                }
            })
            
        }
        else {
            DispatchQueue.main.async {
                ActivityIndicatorView.sharedInstance.hideActivityIndicator(targetView: self.view)
                AppAlertView.showAlertViewWithOKButton(vc : self, titleString : AppConstants.NO_INTERNET_ALERT_TITLE, messageString: AppConstants.NO_INTERNET_AVAILABLE_MSG)
            }
        }
        
    }
    //MARK: - Calling Photos API
    func callingPhotosAPI() {
        let isInternetAvailable = self.checkingNetworkAvailability()
        if isInternetAvailable {
            albumViewModel.fetchAlbumData(urlEndPoint:AppConstants.photosEndpoint, completion: { (isSuccess,error)  in
                if isSuccess && (error == nil || error == "") {
                    DispatchQueue.main.async {
                        //self.albumsTableView.delegate   = self
                        self.albumsTableView.dataSource = self
                        self.albumsTableView.reloadData()
                        ActivityIndicatorView.sharedInstance.hideActivityIndicator(targetView: self.view)
                    }
                }
                else if !isSuccess && error != "" {
                    DispatchQueue.main.async {
                        ActivityIndicatorView.sharedInstance.hideActivityIndicator(targetView: self.view)
                        AppAlertView.showAlertViewWithOKButton(vc : self, titleString : AppConstants.ALERT_TITLE, messageString: error!)
                    }
                }
            })
            
        }
        else {
            DispatchQueue.main.async {
                ActivityIndicatorView.sharedInstance.hideActivityIndicator(targetView: self.view)
                AppAlertView.showAlertViewWithOKButton(vc : self, titleString : AppConstants.NO_INTERNET_ALERT_TITLE, messageString: AppConstants.NO_INTERNET_AVAILABLE_MSG)
            }
        }
    }
    func checkingNetworkAvailability() -> (Bool) {
        if ReachabilityHandler.shared.isInternetAvailable() == true {
            print("Internet is Available")
            return true
        } else {
            print("Internet is not Available")
            return false
        }
        
    }
}
//MARK: - Table View DataSource and Delegate Methods
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        albumViewModel.albums.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Display album title
        let album      = albumViewModel.albums[section]
        var albumTitle = album.title
        albumTitle = albumTitle!.replacingOccurrences(of: "e", with: "", options: [.caseInsensitive, .regularExpression])
        return albumTitle
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.groupAlbumsByAlbumId[section+1]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as? AlbumTableCell {
            
            // Display Each album photo title
            let grouppedAlbum      = albumViewModel.groupAlbumsByAlbumId[indexPath.row + 1]
            let album = grouppedAlbum![indexPath.row]
            let albumTitle = album.title
            //albumTitle = albumTitle!.replacingOccurrences(of: "e", with: "", options: [.caseInsensitive, .regularExpression])
            cell.titleLabel.text = albumTitle
            
            //Downloading album image and display
            let albumThumbnailUrl = album.thumbnailUrl
            if let url = URL(string: albumThumbnailUrl ?? "" ) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.albumImageView.image = UIImage(data: data)
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            cell.albumImageView.image = UIImage(named: "default")
                        }
                    }
                }.resume()
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
}
