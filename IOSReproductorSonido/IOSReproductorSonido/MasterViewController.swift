//
//  MasterViewController.swift
//  IOSReproductorSonido
//
//  Created by Carlos on 31/07/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import AVFoundation

class MasterViewController: UITableViewController {

    var objects = [Cancion]()
    var detailViewController: DetailViewController? = nil
    
    let titulos = ["song1", "song2", "song3", "song4", "song5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadSongs()

    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadSongs(){
        for titulo in titulos{
            let soundURL = Bundle.main.url(forResource: titulo, withExtension: "mp3")
            do{
                let imagen = UIImage(named: titulo + ".jpg")
                let reproductor = try AVAudioPlayer(contentsOf: soundURL!)
                let cancion = Cancion(titulo: titulo, imagen: imagen!, reproductor: reproductor)
                insertNewObject(song: cancion)
            }catch{
                print("Excepcion en el metodo viewDidLoad")
            }
        }
    }
    
    func insertNewObject(song: Cancion) {
        objects.insert(song, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.cancionDetalle = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else if (segue.identifier == "showDetailShuffle") {
            let indice = Int(arc4random_uniform(5))
            print("indice", indice)
            let object = objects[indice]
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.cancionDetalle = object
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.titulo
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}

