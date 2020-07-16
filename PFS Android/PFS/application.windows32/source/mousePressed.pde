int last; 
int count=0;

void mousePressed() {
  //action de la souris

  //--------------------------------------------------------------------------------------------------------
  //pour menu
  //--------------------------------------------------------------------------------------------------------
  if (menu==true) {
    //pour jouer
    if (mouseX>(width/2-90) && mouseX<(width/2+90) && mouseY>(175) && mouseY<(175+60)) {
      if (mousePressed == true) {
        println("Jouer");
        
        //lance l'accélération des stars
        accestars=true;
        
        //lance le jeu
        menu = false;
      }
    }
    //pour quitter
    if (mouseX>(width/2-120) && mouseX<(width/2+120) && mouseY>(height-120) && mouseY<(height-120+60)) {
      if (mousePressed == true) {
        println("Quitter");
        exit();
      }
    }
    
    //pour les règles
    if (mouseX>(width/2-110) && mouseX<(width/2+110) && mouseY>(height/2+50) && mouseY<(height/2+50+60)) {
      if (mousePressed == true) {
        println("règles");
        regless=true;
      }
    }
    
    //--------------------------------------------------------------------------------------------------------
    //choix fusee
    //--------------------------------------------------------------------------------------------------------
    if (mouseX>width/9-100-tailleXf/2/2  && mouseX<width/9-100+tailleXf/2/2 ) {
        if (mouseY>height/3+220-tailleYf/2/2 && mouseY<height/3+220+tailleYf/2/2) {
          if (mousePressed == true) {
            fusee_choisie = 1;
          }
        }
      }
  
      if (mouseX>width/9+100-tailleXf2/2/2  && mouseX<width/9+100+tailleXf2/2/2 ) {
        if (mouseY>height/3+220-tailleYf2/2/2 && mouseY<height/3+220+tailleYf2/2/2) {
          if (mousePressed == true) {
            fusee_choisie = 2;
          }
        }
      }
      if (mouseX>width/9-tailleXf3/2/2  && mouseX<width/9+tailleXf3/2/2 ) {
        if (mouseY>height/3+220-tailleYf3/2/2 && mouseY<height/3+220+tailleYf3/2/2) {
          if (mousePressed == true) {
            fusee_choisie = 3;
          }
        }
      }
      
    }
  
  //--------------------------------------------------------------------------------------------------------
  //retour menu dans régles
  //--------------------------------------------------------------------------------------------------------
  if (regless==true){
    if (mouseX>(width-310) && mouseX<(width-300+240) && mouseY>(height-100) && mouseY<(height-100+60)) {
      if (mousePressed == true) {
        println("retour menu");
        regless=false;
      }
    }
  }
  
  
  //--------------------------------------------------------------------------------------------------------
  //fonction double clic pour tir missiles
  //--------------------------------------------------------------------------------------------------------
  if (mousePressed == true)  // appuie souris
  {
//    if (mouseEvent.getClickCount()==2) {  // double clic
//      println("double-click");
//      doubleclick();
//    }
    count++;
    if (count==1)
      last=millis(); 
    if (count==2 && (millis()-last)<750) {//if pressed twice 
      doubleclick(); 
      //text("doubleclick",width/2, height/2);
      count=0;
    } else if ((millis()-last)>750)
      count=0;
    
  }
  
  
  //--------------------------------------------------------------------------------------------------------
  //pour game over
  //--------------------------------------------------------------------------------------------------------
  if (gameover==true) {
    //pour rejouer
    if (mouseX>(width/2-100) && mouseX<(width/2+100) && mouseY>(height/2+100) && mouseY<(height/2+150)) {
      if (mousePressed == true) {
        println("Rejouer");

        //enregistrement du score précédent
        score_tmp=score;
        compteur_asteroide_tmp=compteur_asteroide;
        initialisation ();
        
        //lance l'accélération des stars
        accestars=true;
        

        //relance le jeu
        gameover = false;
        rejouer = 1;
      }
    }
    //pour quitter
    if (mouseX>(width/2+200) && mouseX<(width/2+400) && mouseY>(height/2+100) && mouseY<(height/2+150)) {
      if (mousePressed == true) {
        println("quitter");
        exit();
      }
    }
    //pour retourner au menu
    if (mouseX>(width/2-400) && mouseX<(width/2-200) && mouseY>(height/2+100) && mouseY<(height/2+150)) {
      if (mousePressed == true) {
        println("menu");
        
        //lance l'accélération des stars
        accestars=true;
        
        //retour au menu
        menu=true;
      }
    }
  }

  //--------------------------------------------------------------------------------------------------------
  //pour pause
  //--------------------------------------------------------------------------------------------------------
  if (gameover == false && menu == false)
  {
    if (mouseX>(width-100) && mouseX<(width) && mouseY>(0) && mouseY<(100)) {
      if (mousePressed == true) {
        pause=!pause;

      }
    } else {
      pause=false;
    }
  }
  if (pause==true) 
  {
    /*
    //si on veut quitter
     if (mouseX>(width/2-100) && mouseX<(width/2+100) && mouseY>(height/2+100) && mouseY<(height/2+150)) {

     if (mousePressed == true) {
     println("Quitter");
     exit();
     }
     }*/
    noLoop();
    fill(255, 255, 255, 75);//75% d'opacité
    rect(0, 0, width, height);
    textMode(CENTER);
    fill(255);
    text("appuyer pour continuer", width/2, height/2);

    /*
     //rectangle quitter
     fill(255);
     stroke(0);
     rect(width/2-100, height/2+100, 200, 50);
     fill(0);
     textSize(40);
     text("quitter", width/2, height/2+140);*/
  } else if (pause==false)
  {
    textMode(LEFT);
    loop();
  }

}


//----------------------------------------------------------------------
//appelle de la fonction seulement si double clic
//----------------------------------------------------------------------
void doubleclick() {
  fill(255); 
  //text("doubleclick",width/2, height/2);
  //pour tir missile
  if (menu ==false && gameover==false) {
    tir=1;
  } else {
    collision_missiles=false;
  }
} 