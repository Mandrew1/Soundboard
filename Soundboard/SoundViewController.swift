//
//  SoundViewController.swift
//  Soundboard
//
//  Created by Andrew Carras1 on 8/3/17.
//  Copyright © 2017 Andrew Carras1. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRecorder()
        // Do any additional setup after loading the view.
    }
    
    
    func setUpRecorder() {
        do {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try session.overrideOutputAudioPort(.speaker)
        try session.setActive(true)
        
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            var settings : [String : Any] = [:]
            settings[AVFormatIDKey] = kAudioFormatMPEG4AAC
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
        
        audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError {
            print(error)
        }
    }

    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            audioRecorder?.stop()
            recordButton.setTitle("Record", for: .normal)
        } else {
            audioRecorder!.record()
            recordButton.setTitle("Stop", for: .normal)
        }
        
    }
    @IBAction func playTapped(_ sender: Any) {
    }
    @IBAction func addTapped(_ sender: Any) {
    }

}
