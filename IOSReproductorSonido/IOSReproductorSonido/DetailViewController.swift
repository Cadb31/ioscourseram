//
//  DetailViewController.swift
//  IOSReproductorSonido
//
//  Created by Carlos on 31/07/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var cancionDetalle:Cancion!
    
    @IBOutlet weak var volumen: UISlider!
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        if(cancionDetalle != nil){
            detailDescriptionLabel.text = cancionDetalle.titulo
            imageSong.image = cancionDetalle.imagen
            cancionDetalle.play()
        }        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cancionDetalle.stop()
    }
    
    @IBAction func play() {
        cancionDetalle.play()
    }

    @IBAction func pause() {
        cancionDetalle.pause()
    }
    
    @IBAction func stop() {
        cancionDetalle.stop()
    }
    
    @IBAction func controllerVolumen(_ sender: UISlider) {
        cancionDetalle.reproductor.volume = volumen.value
    }
    
}

