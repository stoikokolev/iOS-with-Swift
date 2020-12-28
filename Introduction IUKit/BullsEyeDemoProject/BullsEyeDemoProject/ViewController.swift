//
//  ViewController.swift
//  BullsEyeDemoProject
//
//  Created by Stoyko Kolev on 28.12.20.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hitMeButton: UIButton! {
        didSet {
            hitMeButton.layer.cornerRadius = 4.0
        }
    }
    
    // MARK: - Properties
    var currentSliderValue: Int = 0
    var targetValue = 0
    var round: Int = 0
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlider()
        startNewGame()
    }
    
    // MARK: - IBActions
    @IBAction func hitMe() {
        let currentScore = calcuateScore()
        score += calcuateScore()
        
        let title: String
        if currentScore == 100 {
            title = "Perfect!"
            score += 100
        } else if currentScore >= 95 {
            title = "You almost had it!"
            score = currentScore == 99 ? score + 50 : score
        } else if currentScore >= 90 {
            title = "Pretty good!"
        } else {
            title = "Not even close!"
        }
        
        let alert = UIAlertController(title: title, message:
                                        """
                                        You hit \(currentSliderValue),
                                        You scored \(currentScore)!
                                        """
                                      ,preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) {
            //to update scores and slider after close the alert
            [weak self] _ in
            self?.startNewRound()
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentSliderValue = Int(sender.value.rounded())
    }
    
    // MARK: - Private methods
    private func startNewRound() {
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        targetValue = Int.random(in: 1...100)
        round += 1
        updateValue()
    }
    
    private func updateValue() {
        targetValueLabel.text = "\(targetValue)"
        roundLabel.text = "\(round)"
        scoreLabel.text = "\(score)"
    }
    
    private func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    private func calcuateScore() -> Int {
        let difference = abs(currentSliderValue - targetValue)
        return 100 - difference
    }
    
    private func setupSlider() {
        let thumbImageNormal = UIImage(named: "ic_slider_normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageSelected = UIImage(named: "ic_slider_selected")
        slider.setThumbImage(thumbImageSelected, for: .highlighted)
    }
}

