//
//  ViewController.swift
//  Stamps
//
//  Created by Zhanerke Ussen on 06/08/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var buttons: [UIButton]!
    @IBOutlet private weak var undoButton: UIBarButtonItem!
    @IBOutlet private weak var redoButton: UIBarButtonItem!
    
    private var selectedColor: UIColor = .white
    private var colorCount: [UIColor:Int] = [:]
    private var undoStamps: [UILabel] = []
    private var redoStamps: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
        updateUndoButtonState()
        updateRedoButtonState()
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
        undoStamps.append(stamp)
        view.addSubview(stamp)
        updateUndoButtonState()
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton) {
        guard
            let selectedColor = sender.backgroundColor else { return }
        self.selectedColor = selectedColor
        updateButton(sender)
    }
    
    
    @IBAction func undoTapped(_ sender: Any) {
        guard let stamp = undoStamps.popLast(), let color = stamp.backgroundColor, let count = colorCount[color] else {
            return
        }
        
        colorCount[color] = count - 1
        redoStamps.append(stamp)
        stamp.removeFromSuperview()
        updateUndoButtonState()
        updateRedoButtonState()
    }
    
    @IBAction func redoTapped(_ sender: Any) {
        guard let stamp = redoStamps.popLast(), let color = stamp.backgroundColor, let count = colorCount[color] else {
            return
        }
        
        colorCount[color] = count + 1
        undoStamps.append(stamp)
        view.addSubview(stamp)
        updateUndoButtonState()
        updateRedoButtonState()
    }
    
    private func updateButton(_ button: UIButton) {
        buttons.forEach {  $0.alpha = 1 }
        button.alpha = 0.8
    }
    
    func updateUndoButtonState() {
        if undoStamps.isEmpty, undoButton.isEnabled {
            undoButton.isEnabled = false
        } else if !undoStamps.isEmpty, !undoButton.isEnabled {
            undoButton.isEnabled = true
        }
    }
    
    func updateRedoButtonState() {
        if redoStamps.isEmpty, redoButton.isEnabled {
            redoButton.isEnabled = false
        } else if !redoStamps.isEmpty, !redoButton.isEnabled {
            redoButton.isEnabled = true
        }
    }
}

