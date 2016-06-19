//
//  Pokemon.swift
//  PokemanJsonAlmoFire
//
//  Created by MiciH on 6/14/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokemonId : Int!
    
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt : String!
    private var _nextEvolutionId : String!
    private var _nextEvolutionLevel : String!
    private var _pokemonUrl: String!
    
    var name : String{
        return _name
    }
    
    var pokemonId : Int{
        return _pokemonId
    }
    
    var description: String{
        get{
            if _description == nil{
              _description = ""
            }
        return _description
        }
    }
    
    var type : String{
        get{
           if _type == nil{
              _type = ""
            }
        return _type
        }
    }
    
    var defense: String{
        get{
            if _defense == nil{
                _defense = ""
            }
        return _defense
        }
    }
    
    var height: String{
        get{
            if _height == nil{
                _height = ""
            }
        return _height
        }
    }
    
    var weight: String{
        get{
            if _weight == nil{
                _weight = ""
            }
        return _weight
        }
    }
    
    var attack: String{
        get{
            if _attack == nil{
                _attack = ""
            }
        return _attack
        }
    }
    
    var nextEvolutionTxt : String{
        get{
            if _nextEvolutionTxt == nil{
                _nextEvolutionTxt == ""
            }
        return _nextEvolutionTxt
        }
    }
    
    var nextEvolutionId : String{
        get {
            if _nextEvolutionId == nil{
                _nextEvolutionId = ""
            }
        return _nextEvolutionId
        }
    }
    
    var nextEvolutionLevel : String{
        get{
            if _nextEvolutionLevel == nil{
                _nextEvolutionLevel = ""
            }
        return _nextEvolutionLevel
        }
    }
    
    
    
    init(name: String, pokemonId: Int){
        self._name = name
        self._pokemonId = pokemonId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokemonId)/"
    }
    
    //unSynchronizated // we dont konw when this function will finsih
    func downloadPokemonDetalis(completed: DownloadComplete){
        
        let url = NSURL(string: _pokemonUrl)!
        
        //requesting to get data form pokemon api
        //if there is data/ responde = result
        Alamofire.request(.GET, url).responseJSON{ response in
            let result = response.result
//            print(result.value.debugDescription)
            
            //start parsing the data
            //convert the data to a Dictionary
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0{
                    
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1{
                        
                        for i in 1...types.count - 1{
                            if let name = types[i]["name"]{
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }

                else{
                    self._type = ""
                }
                
                print(self._type)
                
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] where descriptions.count > 0 {
                    
                    if let resource_uri = descriptions[0]["resource_uri"]{
                        let uri = NSURL(string: "\(URL_BASE)\(resource_uri)")!
                        //download form api
                                    //request
                                            //get
                                                //respond
                        Alamofire.request(.GET,uri).responseJSON { response in
                            
                            let result = response.result
                            if let dict = result.value as? Dictionary<String,AnyObject>{
                                
                                if let description = dict["description"] as? String{
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                        
                    }
                    else{
                        self._description = ""
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0 {
                        if let to = evolutions[0]["to"] as? String{
                            
                            if to.rangeOfString("mega") == nil{
                                
                                if let resource_uri = evolutions[0]["resource_uri"] as? String{
                                    
                                    let newString = resource_uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    let uriId = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._nextEvolutionId = uriId
                                    self._nextEvolutionTxt = to
                                }
                                if let level = evolutions[0]["level"] as? Int{
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                
                                print(self._nextEvolutionId)
                                print(self._nextEvolutionTxt)
                                print(self._nextEvolutionLevel)
                            }
                            
                            
                            
                        }
                        
                    }
                }
            }
            
        }
    
    }
    
}
