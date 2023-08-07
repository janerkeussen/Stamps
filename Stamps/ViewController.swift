//
//  ViewController.swift
//  Stamps
//
//  Created by Zhanerke Ussen on 06/08/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var buttons: [UIButton]!
    private var selectedColor: UIColor = .white
    private var colorCount: [UIColor:Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func tapped(_ tap: UITapGestureRecognizer) {
        let loc = tap.location(in: self.view)
        addStamp(at: loc)
    }
    
    private func addStamp(at loc: CGPoint) {
        let stamp = UILabel(frame: CGRect(x: loc.x, y: loc.y, width: 50, height: 50))
        stamp.backgroundColor = selectedColor
        stamp.textColor = .white
        stamp.textAlignment = .center
        
        if let count = colorCount[selectedColor] {
            colorCount[selectedColor] = count + 1
            stamp.text = "\(count + 1)"
        } else {
            colorCount[selectedColor] = 1
            stamp.text = "1"
        }
        
        view.addSubview(stamp)
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

