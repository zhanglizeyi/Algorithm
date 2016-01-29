//
//  Game.swift
//  Snake
//
//  Created by ze li on 11/23/15.
//  Copyright © 2015 ze li. All rights reserved.
//
import UIKit
import Foundation

class Game: UIViewController{
  
  @IBOutlet weak var snakeBody: UIImageView!
  @IBOutlet weak var downButtonDisplay: UIButton!
  @IBOutlet weak var leftButtonDisplay: UIButton!
  @IBOutlet weak var upButtonDisplay: UIButton!
  @IBOutlet weak var rightButtonDisplay: UIButton!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var sScoreLabel: UILabel!
  @IBOutlet weak var sHead: UIImageView!
  @IBOutlet weak var gameBackGround: UIImageView!
  
  //var snakeTimer = NSTimer();
  //var binaryCount = 0b0000;
  //boolean for checkDirection
  var upDirection = false;
  var downDirection = false;
  var rightDirection = false;
  var leftDirection = false;
  //snake array
  var snake: [UIImageView] = [];
  //point
  var point = 0;
  //location5
  var cgfloat = CGFloat(20);
  //rect 
  var Rect = UIView(frame: CGRectMake(20,20,520,280));
  var sBodayImage = UIImageView();
  let SNAKEWITH = CGFloat(20);
  let SNAKEHEIGHT = CGFloat(20);
  //timer
  var snakeTimer = NSTimer();
  

  struct Variable{
  }

  @IBAction func leftButton(sender: AnyObject){
    if(startButton.hidden){
      print("left");
      sHead.frame.origin.x -= cgfloat;
      checkBoundary(Rect);
      
      upDirection = false;
      downDirection = false;
      rightDirection = false;
      leftDirection = true;
      growth(snakeBody);
    }
  }
  
  @IBAction func rightButton(sender: AnyObject){
    if(startButton.hidden){
      print("right");
      sHead.frame.origin.x += cgfloat;
      checkBoundary(Rect);
      
      upDirection = false;
      downDirection = false;
      rightDirection = true;
      leftDirection = false;
      growth(snakeBody);
    }
  }
  
  @IBAction func upButton(sender: AnyObject){
    if(startButton.hidden){
      print("up");
      sHead.frame.origin.y -= cgfloat;
      checkBoundary(Rect);
      
      upDirection = true;
      downDirection = false;
      rightDirection = false;
      leftDirection = false;
    }
  }
  
  @IBAction func downButton(sender: AnyObject){
    if(startButton.hidden){
      print("down");
      sHead.frame.origin.y += cgfloat;
      checkBoundary(Rect);

      upDirection = false;
      downDirection = true;
      rightDirection = false;
      leftDirection = false;
     
    }
  }
  
  @IBAction func sGameStratingButton(sender: AnyObject) {
    //startingButton has be hidden and snake move around
    if(startButton.hidden == false){
      startButton.hidden = true;
      print("startButton is hidden");
      //point in game
      
      snakeTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "snakeMoving", userInfo: nil, repeats: true);
      
      checkBoundary(Rect);
    }
  }
  
  //function of score update
  func scoreUpdate(){
    let sPoint = String(point);
    self.sScoreLabel.text = "Score:  \(sPoint)";
  }
  
  
  //function of snake growth
  func growth(x: UIImageView){
    if(rightDirection){
      if(sHead.frame.origin.x == (x.frame.origin.x + 20.0) &&
          sHead.frame.origin.y == x.frame.origin.y ){
            //snakeBody.hidden = true;
            snake.append(snakeBody);
            snakeBody.hidden = true;
            //add animation
            }
          //RandomSnakeBody();
    }
    if(leftDirection){
      if(sHead.frame.origin.x == (x.frame.origin.x - 20.0) &&
        sHead.frame.origin.y == x.frame.origin.y){
        RandomSnakeBody();
      }
    }
    if(upDirection){}
    if(downDirection){}
  }
  
  //checkBoundary
  func checkBoundary(x: UIView){
      if(snake[0].frame.origin.x < x.frame.origin.x ||
        snake[0].frame.origin.x > x.frame.width){ reset(); }
      else if(snake[0].frame.origin.y < x.frame.origin.y ||
        snake[0].frame.origin.y > x.frame.height){ reset(); }
  }
  
  //snake Movement
  func snakeMoving(){
    let sX = self.sHead.frame.origin.x;
    let sY = self.sHead.frame.origin.y;
  
    sHead.frame = CGRectMake(sX+30, sY, SNAKEWITH, SNAKEHEIGHT);
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //    let image = UIImage(named: "sStartingPage.png");
    //    let imageview = UIImageView(image: image);
    //    self.view.addSubview(imageview);
    
    startButton.hidden = false;
    snake += [sHead];
    Rect.layer.borderWidth = 1.0;
    Rect.layer.borderColor = UIColor.blackColor().CGColor;
    
    self.view.addSubview(gameBackGround);
    self.view.addSubview(Rect);
    self.view.addSubview(rightButtonDisplay);
    self.view.addSubview(leftButtonDisplay);
    self.view.addSubview(upButtonDisplay);
    self.view.addSubview(downButtonDisplay);
    self.view.addSubview(sScoreLabel);
    self.view.addSubview(startButton);
    self.view.addSubview(snakeBody);
    self.view.addSubview(sBodayImage);
    self.view.addSubview(sHead);
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning();
    // Dispose of any resources that can be recreated.
  }
  
  func RandomSnakeBody(){
    let tempX = [20,40,60,80,100,120,140,160,180,200,220,
      240,260,280,300,320,340,360,380,400,420,440,460,480,500,520];
    let tempY = [20,40,60,80,100,120,140,160,180,200,220,240,260,280,300,320];
    var X = arc4random_uniform(520);
    var Y = arc4random_uniform(280);
    
    while(!(tempX.contains(Int(X)))){
      X = arc4random_uniform(520);
    }
    
    while(!(tempY.contains(Int(Y)))){
      Y = arc4random_uniform(280);
    }
    
    let rX = CGFloat(X);
    let rY = CGFloat(Y);
    
    sBodayImage.frame = CGRectMake(rX,rY,SNAKEWITH,SNAKEHEIGHT);
    sBodayImage.layer.backgroundColor = UIColor.greenColor().CGColor;
  }
  
  func reset(){
    //restart game
    startButton.hidden = false;
    viewDidLoad();
  }
  

}