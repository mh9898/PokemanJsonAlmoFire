//
//  ViewController.swift
//  PokemanJsonAlmoFire
//
//  Created by MiciH on 6/14/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var sreachBar: UISearchBar!
    var inSreachMode = false
    var filterPokemon = [Pokemon]()
    
    var pokemon = [Pokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        sreachBar.delegate = self
        sreachBar.returnKeyType = .Done
        
        parseCSV()
    }
    
    func parseCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!

        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokemonId: pokeId)
                
                pokemon.append(poke)
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSreachMode{
            return filterPokemon.count
        }
             return pokemon.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            
            let poke : Pokemon!
            
            if inSreachMode{
               poke = filterPokemon[indexPath.row]
            }
            else{
                poke = pokemon[indexPath.row]
            }
            cell.confgCell(poke)
            return cell
            
        }
        return UICollectionViewCell()
  
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke : Pokemon!
        if inSreachMode{
            poke = filterPokemon[indexPath.row]
        }
        else{
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("DetailVC", sender: poke)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailVC"{
            
            if let detailVC = segue.destinationViewController as? DetailVC {
                if let poke = sender as? Pokemon{
                    //this will happen before Detail viewDidLoad
                    detailVC.pokemon = poke
                }
            }
        }
        
    }


    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if sreachBar.text == nil || searchBar.text == ""{
         inSreachMode = false
             view.endEditing(true)
            //load the pokemon array
            collectionView.reloadData()
        }
        else{
           inSreachMode = true
            let wordToSreach = sreachBar.text!.lowercaseString
            //filter the main array to a filter array
            //and find the searched word in the filter array
            filterPokemon = pokemon.filter({$0.name.rangeOfString(wordToSreach) != nil})
            collectionView.reloadData()
        }
        
    }

}

