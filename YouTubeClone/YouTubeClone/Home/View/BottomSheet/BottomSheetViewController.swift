//
//  BottomSheetViewController.swift
//  YouTubeClone
//
//  Created by Reysmer Valle on 6/17/22.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var overlayView: UIView!
    
    @IBOutlet weak var optionsContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOverlay(_:)))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        optionsContainer.animateBottomSheet(show: true) {}
    }
    
    @objc func didTapOverlay(_ sender: UIGestureRecognizer) {
        optionsContainer.animateBottomSheet(show: false) {
            self.dismiss(animated: false)
        }
    }
}
