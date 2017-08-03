//
//  Cancion.swift
//  IOSReproductorSonido
//
//  Created by Carlos on 31/07/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import AVKit
import Foundation
import AVFoundation

class Cancion{

    var titulo: String = ""
    var imagen: UIImage = UIImage()
    var reproductor: AVAudioPlayer!
    
    init(titulo: String, imagen: UIImage, reproductor: AVAudioPlayer) {
        self.titulo = titulo
        self.imagen = imagen
        self.reproductor = reproductor
    
    }
    
    init(){
        
    }
    
    func play() {
        if(!reproductor.isPlaying){
            reproductor.play()
        }
    }
    
    func pause() {
        if(reproductor.isPlaying){
            reproductor.pause()
        }
    }
    
    func stop() {
        if(reproductor.isPlaying){
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }
    
    func replay() {
        reproductor.stop()
        reproductor.currentTime = 0.0
        reproductor.play()
    }
}
