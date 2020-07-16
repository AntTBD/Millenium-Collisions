/*Structure de données
 
 Kath:
 Météroites random ET qui vont vers la gauche OK
 Vaisseau dessin OK
 Elimination météorité (colision) OK
 Points vie OK
 Menu / Niveau OK
 
 Antoine :
 Déplacements flèches (key code pour processing)
 Fond "qui défile" OK
 Pause OK
 Accélération ~OK
 Score OK
 Bonus OK
 */


//---------------------------------------------------------------------------------
// setup : initialisations
//---------------------------------------------------------------------------------
void setup()
{
  //taille fenêtre
  fullScreen();
  orientation (LANDSCAPE);

  //initialisation police
  PFont police;
  police = createFont("Starjedi.ttf", 20);
  textFont(police);

  //initialisation images
  fondecran = loadImage("Fond.png");
  fusee = loadImage("fusee.png");
  fusee2 = loadImage("tie fighter.png");
  fusee3 = loadImage("x-wing.png");
  asteroide = loadImage("asteroid.png");
  asteroide_indestructible =loadImage("asteroide_indestructible.png");
  missile = loadImage("missile.png");
  explosion = loadImage("explosion.png");
  jauge = loadImage("jauge.png");
  bonus= loadImage("bonus.png");
  bouclier = loadImage("bouclierbeta3.png");
  icone_jeu = loadImage("icone_jeu.png");
  demarrage = loadImage("demarrage2.png");
  
  //importation des sons à partir du dossier data
  missile_tir= new SoundFile(this, "laser.mp3"); //this sert à indiquer à Processing que nos instructions s'appliquent à ce programme
  crash= new SoundFile(this, "crash.mp3");
  bonuss= new SoundFile(this, "shield.mp3");
  
  //toutes les principales initialisations (reprises pour rejouer)
  initialisation ();

  //pour les étoiles de gameover 
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  
  //image de départ
  image_depart=0;
}
//---------------------------------------------------------------------------------
// draw : instructions exécutées 60 fois par seconde
//---------------------------------------------------------------------------------
void draw()
{
  //affichage de l'image de départ
  if (image_depart==0){
    imageMode(CENTER);
    background (0);
    image (demarrage,width/2, height/2,height*1556/1135,height);
    textAlign(CENTER);
    if (second()%2==0){
      textSize(50);
      fill(255);
      text("appuyer pour commencer",width/2, height-100);
      textAlign(LEFT);
      imageMode(CORNER);
    }
    //enleve l'image de départ
    if (mousePressed) {
      image_depart=1;
      menu=true;
    }
  } else {
    
    //acceleration des stars quand appuie sur touche
    if (accestars==true){
      acceleration_stars();
    }else {
    
      //départ menu
      if (menu==true)
      {
        affiche_menu();
      } else if (menu==false)
      {
        //lance les fonctions...
        if (gameover==false)//...de jeu
        {
          jouer();
        } else if (gameover==true)//...de fin
        {
          affiche_gameover ();
        }
      }
    }
  }
}


//arret du son
void stop() {
  missile_tir.stop();
  crash.stop();
  bonuss.stop();
  
}