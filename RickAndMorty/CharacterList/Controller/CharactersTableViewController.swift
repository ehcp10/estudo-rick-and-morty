//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by Evandro de Paula on 24/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    //MARK: - Properties
    var characters: [Character] = []

    //MARK: - Super methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RestHandler.loadCharacters(onComplete: { (characters) in
            self.characters = characters
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
            
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let characterDetailViewController = segue.destination as? CharacterDetailViewController
        
        if let characterIndex = tableView.indexPathForSelectedRow?.row {
            characterDetailViewController?.character = characters[characterIndex]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let char = characters[indexPath.row]
        cell.textLabel?.text = char.name
        cell.detailTextLabel?.text = char.species
        

        return cell
    }

}
