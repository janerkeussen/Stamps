//
//  ViewController.swift
//  Stamps
//
//  Created by Zhanerke Ussen on 06/08/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var buttons: [UIButton]!
    private var selectedColor: UIColor = .black

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction private func buttonTapped(_ sender: UIButton) {
       guard
        let selectedColor = sender.backgroundColor else { return }
        self.selectedColor = selectedColor
        updateButton(sender)
    }
    
    private func updateButton(_ button: UIButton) {
        buttons.forEach {  $0.alpha = 1 }
        button.alpha = 0.8
    }

}

