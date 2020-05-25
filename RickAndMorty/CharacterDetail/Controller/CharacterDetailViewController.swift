//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Evandro de Paula on 24/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelSpecie: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelOrigin: UILabel!
    
    //MARK: - Properties
    var character: Character?
    
    //MARK: - Super methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = character?.name {
            navigationItem.title = name
        }
        
        if let character = character {
            characterImageView.downloaded(from: character.image)
            labelName.text = character.name
            labelStatus.text = character.status
            labelSpecie.text = character.species
            labelGender.text = character.gender
            labelLocation.text = character.location.name
            labelOrigin.text = character.origin.name
        }

    }

}

//Extension obtida em fórum na internet
extension UIImageView {
   func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
