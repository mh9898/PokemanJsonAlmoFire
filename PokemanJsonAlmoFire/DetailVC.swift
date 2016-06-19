//
//  DetailVC.swift
//  PokemanJsonAlmoFire
//
//  Created by MiciH on 6/15/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokeIdLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    //this will happen before viewDidLoad if not conncet form view controller
    var pokemon : Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokemonId)")
        
        pokemon.downloadPokemonDetalis { 
            
        }
       
    }

    @IBAction func backAction(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
