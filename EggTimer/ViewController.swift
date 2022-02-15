//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var eggTimes: [String: Float] = ["Soft": 3 , "Medium": 420, "Hard": 720]
    var seconds: Float = 0
    var timer: Timer?
    var eggTime: Float = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar?.progress = 0
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.currentTitle else { return }
        guard let eggTime = eggTimes[hardness] else { return }
        
        self.eggTime = eggTime
        seconds = 0
        progressBar?.progress = 0
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(contagem), userInfo: nil, repeats: true)
        titleLabel.text = "How do you like your eggs?"
    }
    
    @objc func contagem() {
        seconds += 1
        progressBar?.progress = seconds / eggTime
        
        if(seconds == eggTime){
            seconds = eggTime
            timer?.invalidate()
            
            titleLabel.text = "Done!"
            playAlarm()
        }
    }
}
