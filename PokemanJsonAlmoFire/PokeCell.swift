//
//  PokeCell.swift
//  PokemanJsonAlmoFire
//
//  Created by MiciH on 6/14/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    //create a pokemon object to pass all atrubuites
    var pokemon : Pokemon!
    
     func initialize(){
        self.layer.cornerRadius = 20.0

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }

    
    func confgCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokemonId)")
        
    }
    
    
}
