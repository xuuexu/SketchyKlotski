//
//  ViewController.swift
//  klotskiMenu
//
//  Created by Shawn Xu on 6/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import CoreData

class MenuVC: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource{
    

    @IBOutlet weak var levelSelector: VerticalCardSwiper!
    
    private var levelsData: [Level] = [
        Level("Level 0"),
        Level("Level 1"),
        Level("Level 2"),
        Level("Level 3"),
        Level("Level 4"),
        Level("Level 5"),
        Level("Level 6"),
        Level("Level 7"),
        Level("Level 8"),
        Level("Level 9"),
    ]
    
//    var levelsDetail = [LevelDetail](repeatElement(LevelDetail(context: PersistenceService.context), count: 10))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        print("Logging Init Data:....")
//
//        // save and load
//        for i in 0..<10 {
//            levelsDetail[i].name = String(i)
//            levelsDetail[i].pass = false
//            print("\(levelsDetail[i].name) + \(levelsDetail[i].pass)")
//        }
        
        
    
//        PersistenceService.saveContext()
        
        
        print("Logging Core Data:....")
//        levelsDetail = fetchCoreData()
        
        // Do any additional setup after loading the view.
        levelSelector.delegate = self
        levelSelector.datasource = self
        
        levelSelector.register(nib: UINib(nibName: "LevelCard", bundle: nil), forCellWithReuseIdentifier: "LevelCard")
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        
        return levelsData.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        if let levelCard = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "LevelCard", for: index) as? LevelCard {
            
            
//            levelsDetail = fetchCoreData()
            let level = levelsData[index]
            
            levelCard.setRandomBackgroundColor()
            levelCard.levelIndex.text = level.name
            levelCard.playButton.setTitle(String(level.pass), for: .normal)
            return levelCard
        }
        
        return LevelCard()
        
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
//        levelsData.remove(at: index)
        levelsData.remove(at: index)
//        print(index)
    }
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called when a card has animated off screen entirely.
    }
    
    func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
        
        // Tells the delegate when the user taps a card (optional).
        
        print("You tapped ", String(index))
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let gameVC = mainStoryboard.instantiateViewController(withIdentifier: "gamegame") as?
            GameVC else {
                print("Opps, couldn't find it")
                return
        }
        
//        print(gameVC.levelSelected.text)
//        gameVC.levelInfo = String(index)
        
        // TEST for
        
//        levelsDetail = fetchCoreData()
        levelsData[index].pass = true
        
        levelSelector.reloadData()
        
//        PersistenceService.saveContext()
        
        
        navigationController?.pushViewController(gameVC, animated: true)
        
        
    }


}

