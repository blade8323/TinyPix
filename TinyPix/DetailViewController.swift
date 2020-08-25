//
//  DetailViewController.swift
//  TinyPix
//
//  Created by Admin on 20.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pixView: TinyPixView!
    

    deinit {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let doc = detailItem as? UIDocument {
            doc.close(completionHandler: nil)
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if detailItem != nil && isViewLoaded {
            pixView.document = detailItem! as! TinyPixDocument
            pixView.setNeedsDisplay()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        updateTintColor()
        NotificationCenter.default.addObserver(self, selector: #selector(onSettingsChanged(notification:)), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    @objc func onSettingsChanged(notification: Notification) {
        updateTintColor()
    }

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    private func updateTintColor() {
        let prefs = UserDefaults.standard
        let selectedColorIndex = prefs.integer(forKey: "selectedColorIndex")
        let tintColor = TinyPixUtils.getTintColorForIndex(index: selectedColorIndex)
        pixView.tintColor = tintColor
        pixView.setNeedsDisplay()
    }
}

