import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PFS extends PApplet {

/*Structure de donn\u00e9es
 
 Kath:
 M\u00e9t\u00e9roites random ET qui vont vers la gauche OK
 Vaisseau dessin OK
 Elimination m\u00e9t\u00e9orit\u00e9 (colision) OK
 Points vie OK
 Menu / Niveau OK
 
 Antoine :
 D\u00e9placements fl\u00e8ches (key code pour processing)
 Fond "qui d\u00e9file" OK
 Pause OK
 Acc\u00e9l\u00e9ration ~OK
 Score OK
 Bonus OK
 */


//---------------------------------------------------------------------------------
// setup : initialisations
//---------------------------------------------------------------------------------
public void setup()
{
  //taille fen\u00eatre
  
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
  
  //importation des sons \u00e0 partir du dossier data
  missile_tir= new SoundFile(this, "laser.mp3"); //this sert \u00e0 indiquer \u00e0 Processing que nos instructions s'appliquent \u00e0 ce programme
  crash= new SoundFile(this, "crash.mp3");
  bonuss= new SoundFile(this, "shield.mp3");
  
  //toutes les principales initialisations (reprises pour rejouer)
  initialisation ();

  //pour les \u00e9toiles de gameover 
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  
  //image de d\u00e9part
  image_depart=0;
}
//---------------------------------------------------------------------------------
// draw : instructions ex\u00e9cut\u00e9es 60 fois par seconde
//---------------------------------------------------------------------------------
public void draw()
{
  //affichage de l'image de d\u00e9part
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
    //enleve l'image de d\u00e9part
    if (mousePressed) {
      image_depart=1;
      menu=true;
    }
  } else {
    
    //acceleration des stars quand appuie sur touche
    if (accestars==true){
      acceleration_stars();
    }else {
    
      //d\u00e9part menu
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
public void stop() {
  missile_tir.stop();
  crash.stop();
  bonuss.stop();
  
}
int tempsacc;
public void acceleration_stars ()
{
  tempsacc++;
  if (tempsacc>0 && tempsacc<=150)
  {
    speed=speed+2;
    stars_fin();
  }
  else{
    speed=3;
    accestars=false;
    tempsacc=0;
  } 
}
public void affiche_asteroide ()
{
  // Affichage des ast\u00e9roides
  for (int i=0; i<nbra; i++)
  {
    image(asteroide, tabXa[i], tabYa[i],tailleXa,tailleYa);
    
    // D\u00e9placement des ast\u00e9ro\u00efdes en X
    tabXa[i]=tabXa[i]-sensXa[i];
    
    //reinitialisation des ast\u00e9roides s'ils ne sont plus dans la fen\u00eatre
    if (tabXa[i]<(-tailleXf-fuseeX))
    {
      tabXa[i]=(int)random(width, 2*width);
      tabYa[i]=(int)random(0, height-tailleYa);
    }
  }

  // Affichage des ast\u00e9roides indestructibles
  for (int i=0; i<nbra_indestructible; i++)
  {
    image(asteroide_indestructible, tabXa_indestructible[i], tabYa_indestructible[i],tailleXa_indestructible,tailleYa_indestructible);
    
    // D\u00e9placer les ast\u00e9ro\u00efdes indestructibles en X
    tabXa_indestructible[i]=tabXa_indestructible[i]-sensXa_indestructible[i];
    
    //reinitialisation des ast\u00e9roides s'ils ne sont plus dans la fen\u00eatre
    if (tabXa_indestructible[i]<(-tailleXf-fuseeX))
    {
      tabXa_indestructible[i]=(int)random(width, 4*width);
      tabYa_indestructible[i]=(int)random(0, height-tailleYa_indestructible);
    }
  }
}
public void affiche_etoiles ()
{
  // Affichages Etoiles de fond
  for (int i=0; i<nombre; i++)
  {
    //\u00e9toiles sous formes de petites \u00e9llipses
    noStroke();//sans contour
    fill(255);
    ellipse(tabX[i], tabY[i], taille[i], taille[i]);
    
    // D\u00e9placement des \u00e9toiles
    tabX[i]=tabX[i]-sensX[i];
    
    //reinitialisation des \u00e9toiles s'ils ne sont plus dans la fen\u00eatre
    if (tabX[i]<=taille[i])
    {
      tabX[i]=width;
      tabY[i]=(int)random(taille[i], height-taille[i]);
    }
  }
}
public void affiche_fusee ()
{
  //conditions pour que la fusee reste dans la fen\u00eatre m\u00eame si la souris n'y est pas
  if (mouseY<tailleYf/2)
  {
    mouseY=tailleYf/2;
  }
  if (mouseY>(height-tailleYf/2))
  {
    mouseY=(height-tailleYf/2);
  }
  
  //fusee (centr\u00e9 en Y sur le milieux de la fusee)
  if (fusee_choisie == 1) {
    image(fusee, fuseeX, mouseY-tailleYf/2,tailleXf,tailleYf);
  }
  if (fusee_choisie == 2) {
    image(fusee2, fuseeX, mouseY-tailleYf2/2,tailleXf2,tailleYf2);
  }
  if (fusee_choisie == 3) {
    image(fusee3, fuseeX, mouseY-tailleYf3/2,tailleXf3,tailleYf3);
  }
}
int c=0;

public void affiche_gameover ()
{
  //pour changement de la couleurs des commentaires
  c=c+2;
  if (c > 1250) c = 0;

  //fond noir avec animation \u00e9toiles
  background(0);
  stars_fin();

  //l\u00e9gende de fin
  textAlign(LEFT);//allignement du texte \u00e0 gauche
  fill(255);
  textSize(40);
  text("votre score : "+score+" points", 20, 50);
  text("vous avez detruit : "+compteur_asteroide+" ast\u00e9ro\u00efdes", 20, 100);
  //image(asteroide, 550, 50, 70, 60);

  //changement de couleur automatique
  colorMode(HSB);
  fill(c/5, 1000, 1000);

  //Commentaires adapt\u00e9s en fonction du score
  if (score<200) {
    text("you can do it !!!", 20, 150);
  }
  if ((score>200) && (score<500)) {
    text("keep practicing !", 20, 150);
  }
  if ((score>500) && (score<2000)) {
    text("good game", 20, 150);
  }
  if ((score>2000) && (score<4000)) {
    text("almost great", 20, 150);
  }
  if (score>4000) {
    text("you're so great !", 20, 150);
  }

  //affichage du score pr\u00e9cedent 
  if (rejouer ==1) {
    fill(255);
    text("score pr\u00e9c\u00e9dent :           /  "+score_tmp+" points", 20, 250);
    text(compteur_asteroide_tmp, 490, 250);
    image(asteroide, 600, 200, 70, 60);

    //changement de couleur automatique
    colorMode(HSB);
    fill(c/4, 1000, 1000);

    //commentaire progression avec le pr\u00e9c\u00e9dent score
    if (score_tmp<score) {
      text("tu progresses, bravo !", 20, 300);
    } else if (score_tmp>score) {
      text("tu as d\u00e9j\u00e0 fait mieux, dommage", 20, 300);
    }
  }
  colorMode(RGB);//remise en place du bon mode de couleur RGB
  fill(255);//remise de la couleur en blanc


  textAlign(CENTER);
  fill(255, 0, 0);
  textSize(70);
  text("game over", width/2, height/2);

  mousePressed();

  //rectangle "rejouer"
  fill(255);
  rect(width/2-100, height/2+100, 200, 50);
  fill(0);
  textSize(40);
  text("rejouer", width/2, height/2+140);
  
  //rectangle "menu"
  fill(255);
  rect ((width/2)-400,height/2+100,200,50);
  fill(0);
  textSize(40);
  text("menu",(width/2-300), height/2+140);
  
  //rectangle "quitter"
  fill(255);
  rect ((width/2)+200,height/2+100,200,50);
  fill(0);
  textSize(40);
  text("quitter",(width/2+300), height/2+140);
}
public void affiche_legende ()
{
  //center la l\u00e9gende et le score
  textAlign(CENTER);

  /*
  //trait blanc de s\u00e9paration pour la l\u00e9gende
   stroke(255);
   line(0, height-legende, width, height-legende);
   
   //l\u00e9gende
   fill(255);
   textSize(17);
   text("espace : pause           clic souris : tirer           souris : d\u00e9placement fus\u00e9e", width/2, height-4);
   */

  //affiche logo pause
  stroke(255, 255, 255);
  strokeWeight(1);
  fill(255, 255, 255);
  rect(width-85, 20, 20, 60);
  rect(width-45, 20, 20, 60);

  //affichage score (rappel: +1 toutes les demis secondes
  fill(255);
  textSize(50);
  text(score, width/2, 60);

  //centrer \u00e0 gauche pour niveau, niveau pr\u00e9c\u00e9dent, nombre ast\u00e9roides d\u00e9truits
  textAlign(LEFT);

  //affichage niveau
  fill(255);
  textSize(40);
  text("niveau : "+niveau, 35, 50);

  //affichage du score pr\u00e9cedent apr\u00e8s avoir fait au moins une partie
  if (rejouer ==1) {
    textSize(36);
    text("score pr\u00e9c\u00e9dent : ", 35, 100);
    text("  "+compteur_asteroide_tmp, width/3, 100);
    textAlign(CENTER);
    text(score_tmp, width/2, 100);
    textAlign(LEFT);
  }

  //affichage nb d'asteroide d\u00e9truit \u00e0 cot\u00e9 de l'image ast\u00e9roide explos\u00e9
  image(asteroide, width/3-70, 10, 60, 50);
  image(explosion, width/3-90, 10, 60, 50);
  text(": "+compteur_asteroide, width/3, 50);

  /*
  //touche tire
   mousePressed ();
   fill(255,0,0);
   rect(width-300, height-150,180,90);
   */
}

int tir=0;

public void affiche_missiles ()
{
  //en fonction des actions de la souris
  if (tir==1){
    if (tabXm<width) {
      //rappel taille d'origine missile
      tailleXm=50;
      tailleYm=22;

      collision_missiles=true;

      image(missile, tabXm-marge_m, tabYm, tailleXm, tailleYm);

      // D\u00e9placer le missile
      tabXm=tabXm+sensXm;
    }
    //remise en place du missile si en dehors de la fen\u00eatre
    if (tabXm>=width)
{
      tabXm=tailleXf+fuseeX;
      tabYm=mouseY-10;
      collision_missiles=false;
      tir=0;
    }
  }
  else if (tir==0){
    collision_missiles=false;

    //remise en place du missile
    tabXm=tailleXf+fuseeX;
    tabYm=mouseY-10;
    
    tir=0;
  }
}
public void affiche_vies()
{
  // taille jauge 400*77 ndlr
  fill(255, 0, 0);
  noStroke();
  rect(width-496, 21, vie, 75);
  image(jauge, width-505, 20,400,77); //afficher la jauge de vie

  //vie max
  if (vie>=390)
  {
    vie = 390;
  }
  //fin de vie (game over)
  if (vie <=0)
  {
    vie=0;
    gameover=true;
    println("vous avez perdu");
  }
} 
public void aides_affiche ()
{ 
  //ligne centree sur souris (soit milieu de l'image de la fusee)
  stroke(255);
  strokeWeight(1);
  line(0, mouseY, 500, mouseY);

  //rectangle d\u00e9limite fusee
  noFill();
  rect(10, mouseY-tailleYf/2, tailleXf, tailleYf);

  for (int i=0; i<nbra; i++)
  {
    // cercles \u00e0 l'avant (haut et bas) de chaque ast\u00e9roide
    fill(255);
    ellipse(tabXa[i], tabYa[i], 10, 10);
    fill(0, 255, 0);
    ellipse(tabXa[i], tabYa[i]+tailleYa, 10, 10);
    //rectangle d\u00e9limite chaque ast\u00e9roide
    noFill();
    stroke(255, 0, 0);
    rect(tabXa[i], tabYa[i], tailleXa, tailleYa);
  }

  for (int i=0; i<nbra_indestructible; i++)
  {
    //rectangle d\u00e9limite chaque ast\u00e9roides indestructibles
    rect(tabXa_indestructible[i], tabYa_indestructible[i], tailleXa_indestructible, tailleYa_indestructible);
  }

  //lignes pour se r\u00e9p\u00e9rer en haut en en bas du carr\u00e9 bonus
  stroke(0, 255, 0);
  line(0, Yb, width, Yb);
  line(0, Yb+tailleXYb, width, Yb+tailleXYb);
  rect(Xb, Yb, tailleXYb, tailleXYb);
}
public void bonus()
{
  collision_asteroide=true;

  textAlign(CENTER);//centrer texte des diff\u00e9rentes fonctions bonus

  //affichage bonus
  fill(0, 255, 0);
  image(bonus, Xb, Yb);

  // D\u00e9placer les bonus
  Xb=Xb-sensXb;
  Yb=height/2-tailleXYb+(int)( amplitude * cos(TWO_PI * frameCount / periode));//oscillation en Y du bonus

  if (Xb<-1000)//espace durant lequel aura lieu le bonus
  {
    //r\u00e9-initialisation du bonus
    Xb=3*width;
    Yb=height/2-tailleXYb;
    choix_bonus=(int)random(0, 100);//random pour choix du bonus
  }

  //affiche de la vitesse des ast\u00e9roides
//  for (int i=0; i<nbra; i++)
//  {
//    println(sensXa[i], choix_bonus);
//  }

  //condition pour avoir le bonus
  if (Xb<=(fuseeX+tailleXf) && (Xb+tailleXYb)>=fuseeX && Yb<(mouseY+tailleYf/2) && (Yb+tailleXYb)>=(mouseY-tailleYf/2))//bonus pris
  {
    timer=timer+1;//lancement du chrono (duree du bonus)
  } else if (Xb>=(fuseeX+tailleXf) && (Xb<=3*width)) {//pas de bonus
    timer=0;
    a=0;
  }

  if (timer>0) {//si bonus pris et chrono en route
    a=1;
    //choix du bonus suite au random (1 chance sur 4 pour chaque)
    if (choix_bonus>=0 && choix_bonus<= 25)
    {
      bonus_immunite ();
    } else if (choix_bonus>25 && choix_bonus <=50)
    {
      full_vie ();
    } else if (choix_bonus>50 && choix_bonus <=75)
    {
      bonus_ralenti ();
    } else if (choix_bonus>75 && choix_bonus <=100)
    {
      super_missile ();
    }
  }
}



public void bonus_immunite ()
{
  if (a==1)
  {
    collision_asteroide = false;

    //l\u00e9gende
    text("bonus acc\u00e9l\u00e9ration", width/2, height/2);
    text("vous \u00eates immunis\u00e9s", width/2, height/2+50);

    //image champ magn\u00e9tique au premier plan
    if (fusee_choisie == 1) {
      image(fusee, fuseeX, mouseY-tailleYf/2,tailleXf,tailleYf);
    }
    if (fusee_choisie == 2) {
      image(fusee2, fuseeX, mouseY-tailleYf2/2,tailleXf2,tailleYf2);
    }
    if (fusee_choisie == 3) {
      image(fusee3, fuseeX, mouseY-tailleYf3/2,tailleXf3,tailleYf3);
    }
    image(bouclier, fuseeX-65, mouseY-180);
    
    //lancement son
    bonuss.play();

    //bonus score
    score=score+2;

    //acc\u00e9l\u00e9ration des 2 types de missiles
    for (int i=0; i<nbra; i++)
    {
      sensXa[i]=sensXa[i]+50;
    }
    for (int j=0; j<nbra_indestructible; j++)
    {
      sensXa_indestructible[j]=sensXa_indestructible[j]+50;
    }
  } else {
    a=0;
    collision_asteroide=true;
  }
}


public void bonus_ralenti ()
{
  if (a==1)
  {
    //l\u00e9gende
    text("bonus ralenti", width/2, height/2);

    //ralentissement des 2 types de missiles
    for (int i=0; i<nbra; i++) {
      sensXa[i]=sensXa[i]-3*niveau;
    }
    for (int j=0; j<nbra_indestructible; j++) {
      sensXa_indestructible[j]=sensXa_indestructible[j]-3*niveau;
    }
  } else {
    niveaux();//remise de la vitesse en fonction du niveau
    a=0;
  }
}

public void super_missile ()
{
  if (a==1) 
  {
    //l\u00e9gende
    text("bonus super missile", width/2, height/2);

    if (tir==1) {
      if (tabXm<width) {
        collision_missiles=false;


        //agrandissement taille missile
        tailleXm=100;
        tailleYm=44;

        //r\u00e9affichage du missile avec agrandissement
        image(missile, tabXm-marge_m, tabYm-10, tailleXm, tailleYm);//-10 pour recentrer le missile avec le vaisseau
        
        // D\u00e9placer le missile
        tabXm=tabXm+sensXm;
        
        //super explosion
        for (int i=0; i<nbra; i++) {
          if ((tabXm+tailleXm>tabXa[i]) && (tabXm<tabXa[i]+tailleXa) && (tabYm-10)<(tabYa[i]+tailleYa) && ((tabYm+tailleYm-10)>tabYa[i])) {

            //remise \u00e0 zero du tir
            //tir=0;
            
            //lancement du son
            missile_tir.play();

            //image explosion
            image(explosion, tabXa[i]-50, tabYa[i], 200, 200);

            //remise des asteroides au point de depart (mais pas le missile)
            tabXa[i]=(int)random(width, 2*width);
            tabYa[i]=(int)random(0, height-tailleYa-legende);
          }
        }
      }
      //remise en place du missile si en dehors de la fen\u00eatre
      if (tabXm>=width)
      {
        tabXm=tailleXf+fuseeX;
        tabYm=mouseY-10;
        collision_missiles=false;
        tir=0;
      }
    } else if (tir==0) {
      collision_missiles=false;

      //remise en place du missile
      tabXm=tailleXf+fuseeX;
      tabYm=mouseY-10;

      tir=0;
    }
  }
}


public void full_vie ()
{
  if (a==1)
  {
    //l\u00e9gende
    text("suppl\u00e9ment de vie", width/2, height/2);

    //lancement de condition de la vie
    affiche_vies();

    //rajout de vie
    vie=vie+1;

    //reaffichage de la vie avec clignotement rouge seulement si elle n'est pas au maximum
    if (vie<390) {
      noStroke();
      fill((int) random(0, 255), 0, 0);//clignotement rouge
      rect(width-496, 21, vie, 75);
      image(jauge, width-505, 20); //affichage jauge de vie
    }
  } else {
    fill(255);
  }
}
public void collision_asteroides () {
  // collision avec ast\u00e9roides
  for (int i=0; i<nbra; i++) 
  {
    if ((tabXa[i]<(tailleXf+fuseeX)) && ( tabXa[i]+tailleXa>fuseeX) && (tabYa[i])<(mouseY+tailleYf/2) && ((tabYa[i]+tailleYa)>(mouseY-tailleYf/2))) 
    {
      //lancement du son
      crash.play();

      //ast\u00e9roide en fonction du score
      println("asteroide "+score);

      //fusee centr\u00e9e en Y avec explosion
      if (fusee_choisie == 1) {
        image(fusee, fuseeX, mouseY-tailleYf/2,tailleXf,tailleYf);
      }
      if (fusee_choisie == 2) {
        image(fusee2, fuseeX, mouseY-tailleYf2/2,tailleXf2,tailleYf2);
      }
      /*if (fusee_choisie == 3) {                                  // SELON LE CHOIX DE LA FUSEE :
        image(fusee3, fuseeX, mouseY-tailleYf3/2,tailleXf3,tailleYf3);                  // AFFICHAGE DES FUSEES EN FONCTION DES COORDONNEES DE LA SOURIS
      }*/
      image(explosion, fuseeX+tailleXf-64, mouseY-64, 130, 130);

      //points de vie r\u00e9duit
      vie=vie-3;
    }
  }

  // collision avec ast\u00e9roides indestructibles
  for (int i=0; i<nbra_indestructible; i++)
  {
    if ((tabXa_indestructible[i]<(tailleXf+fuseeX)) && ( tabXa_indestructible[i]+tailleXa_indestructible>0) && (tabYa_indestructible[i])<(mouseY+tailleYf/2) && ((tabYa_indestructible[i]+tailleYa_indestructible)>(mouseY-tailleYf/2))) 
    {
      //lancement du son
      crash.play();

      //ast\u00e9roide en fonction du score
      println("asteroide indestructible "+score);

      //fusee centr\u00e9e en Y avec explosion
      if (fusee_choisie == 1) {
        image(fusee, fuseeX, mouseY-tailleYf/2,tailleXf,tailleYf);
      }
      if (fusee_choisie == 2) {
        image(fusee2, fuseeX, mouseY-tailleYf2/2,tailleXf2,tailleYf2);
      }
      /*if (fusee_choisie == 3) {                                  // SELON LE CHOIX DE LA FUSEE :
        image(fusee3, fuseeX, mouseY-tailleYf3/2,tailleXf3,tailleYf3);                  // AFFICHAGE DES FUSEES EN FONCTION DES COORDONNEES DE LA SOURIS
      }*/
      image(explosion, fuseeX+tailleXf-64, mouseY-64, 130, 130);

      //points de vie r\u00e9duit
      vie=vie-6;
    }
  }
}
public void collision_missiles ()
{
  for (int i=0; i<nbra; i++)
  {
    if ((tabXm+tailleXm>tabXa[i]) && (tabXm<tabXa[i]+tailleXa) && (tabYm)<(tabYa[i]+tailleYa) && ((tabYm+tailleYm)>tabYa[i])) 
    {
      //remise \u00e0 zero du tir
      tir=0;
      
      //lancement du son
      missile_tir.play();

      //image explosion
      image(explosion, tabXa[i]-50, tabYa[i], 200, 200);

      collision_missiles=false;
      
      //remise du missile au point de d\u00e9part
      tabXm=tailleXf+fuseeX;
      tabYm=mouseY-10;

      //remise des asteroides au point de depart
      tabXa[i]=(int)random(width, 2*width);
      tabYa[i]=(int)random(0, height-tailleYa);

      //incrementation du nombre d'ast\u00e9roides d\u00e9truits
      compteur_asteroide+=1;
    }
  }
}
//---------------------------------------------------------------------------------
// D\u00e9claration de variables globales
//---------------------------------------------------------------------------------
//Importation de la fonction son de processing

//import cassette.audiofiles.*;
//import cassette.audiofiles.SoundFile;


//Initialisation des images
PImage fondecran;
PImage fusee,fusee2,fusee3;
PImage asteroide;
PImage asteroide_indestructible;
PImage missile;
PImage explosion;
PImage jauge;
PImage bonus;
PImage bouclier;
PImage icone_jeu;
PImage demarrage;

//Initialisation des sons
SoundFile missile_tir;
SoundFile crash;
SoundFile bonuss;


// Initialisation \u00e9toiles fond d'\u00e9cran
int nombre = 400;
int []tabX = new int[nombre];
int []tabY = new int[nombre];
int []sensX = new int[nombre];
int [] taille=new int[nombre];

// Initialisation fus\u00e9e
//coordonn\u00e9es
int fuseeX=50;
//taille fusee1
int tailleXf=176;
int tailleYf=130;
//taille fusee2
int tailleXf2=157;
int tailleYf2=130;
//taille fusee3
int tailleXf3=139;
int tailleYf3=130;
//choix fusee
int fusee_choisie=1;

//entiers pour les tableaux
int i, j;

// Initialisation Ast\u00e9roides (a pour ast\u00e9roide)
int nbra = 8;
int []tabXa=new int[nbra];
int []tabYa=new int[nbra];
int []sensXa=new int[nbra];
int tailleXa=164;
int tailleYa=128;

//Intialisation asteroides indestructibles (a_indestructible pour diff\u00e9rencer)
int nbra_indestructible=5;
int []tabXa_indestructible=new int[nbra_indestructible];
int []tabYa_indestructible=new int[nbra_indestructible];
int []sensXa_indestructible=new int[nbra_indestructible];
int tailleXa_indestructible=100;
int tailleYa_indestructible=100;

// Initialisation missile (m pour missile)
int tabXm;
int tabYm;
int sensXm;
int tailleXm=50;
int tailleYm=22;
int missileX=tailleXf+fuseeX;
int marge_m;

//Initialiasation bonus
int Xb;
int Yb;
//pour oscillation
float periode;
float amplitude;
int tailleXYb=100;//largeur/longueur bonus identique
int sensXb=10;

//variable pour les ponits de vie
int vie;

//bonus
int choix_bonus;
int a;//variable de condition
int timer;//temps du bonus

//taille de la l\u00e9gende en bas de l'\u00e9cran
int legende=20;

//condition de jeu
boolean collision_asteroide;
boolean collision_missiles;
boolean gameover;
boolean menu;
boolean pause;

//score en fonction de t
int t=0;
int score;

//variable pour lancer le score pr\u00e9cedent apr\u00e8s rejouer
int rejouer;
//compteurs temporaire si rejouer
int score_tmp;
int compteur_asteroide;
int compteur_asteroide_tmp;

int image_depart;


boolean accestars;
public void initialisation ()
{
  // Etoiles
  for (i=0; i<nombre; i++)
  {
    taille[i]=(int)random(1, 5);
    tabX[i]=(int)random(taille[i], width-taille[i]);
    tabY[i]=(int)random(taille[i], height-taille[i]);
    sensX[i]=(int)random(1, 5);
  }

  // Ast\u00e9roides
  for (i=0; i<nbra; i++)
  {
    tabXa[i]=(int)random(width, 2*width);
    tabYa[i]=(int)random(0, height-tailleYa);
    sensXa[i]=(int)random(8, 13);
  }
  compteur_asteroide=0;

  // Ast\u00e9roides indestructible
  for (i=0; i<nbra_indestructible; i++)
  {
    tabXa_indestructible[i]=(int)random(width, 4*width);
    tabYa_indestructible[i]=(int)random(0, height-tailleYa_indestructible);
    sensXa_indestructible[i]=(int)random(8, 13);
  }

  // missiles
  tabXm=tailleXf+fuseeX;
  tabYm=mouseY-10;
  sensXm=70;

  //bonus
  Xb=3*width;
  Yb=(int)random(amplitude+tailleXYb, height-amplitude-tailleXYb);
  choix_bonus=(int)random(0, 100);//random pour choix du bonus
  periode = 200;//vitesse des oscillations (+ grande=vitesse-)
  amplitude = 200;

  vie = 390;//valeur max = 390
  score = 0;
  
  //vitesse etoiles de fin
  speed=3;
  accestars=false;
}
public void jouer()
{
  // couleur de fond avec image
  background(0);
  //image(fondecran,0,0, width, height);

  //temps (60 fois par seconde)
  t=t+1;
  //score
  if ( (t % 10) == 0 )//reduction \u00e0 toute les demies secondes
  {
    score = score + 1;//1 point toutes les quarts de secondes
  }

  //lancement de touts les focntions suivant les conditions
  affiche_vies();
  affiche_legende ();
  //aides_affiche();//affichage pour tester
  affiche_etoiles ();
  affiche_fusee ();
  niveaux ();
  bonus ();

  if ( collision_asteroide == true)
  {
    if (collision_missiles==true)
    {
      affiche_asteroide ();
      affiche_missiles ();
      collision_asteroides ();
      collision_missiles ();
    } else if (collision_missiles==false)
    {
      affiche_asteroide ();
      affiche_missiles ();
      collision_asteroides ();
    }
  } else if (collision_asteroide == false)
  {
    if (collision_missiles==true)
    {
      affiche_asteroide ();
      affiche_missiles ();
      collision_missiles ();
    } else if (collision_missiles==false)
    {
      affiche_asteroide ();
      affiche_missiles ();
    }
  }
}
int regles;
boolean regless;

public void affiche_menu()
{
  mousePressed();
  
  //fond noir avec image
  background(0);
  //image(fondecran, 0, 0,width,height);
  
  //lancement fonction \u00e9toiles fin 
  stars_fin();
  
  //formes de mise en page
  stroke(255);
  fill(0);
  rect((width/2)-490, 2*height/3, 980, 120);//rectangle "important"
  rect((width/2)-90, 175, 180, 60);//rectangle "jouer"
  rect ((width/2)-120,height-120,240,60);//rectangle "quitter"
  rect ((width/2)-110,height/2+50,220,60);//rectangle "r\u00e8gles"

  //texte centr\u00e9
  fill(255);
  textAlign(CENTER);
  textSize(80);
  text("Menu", width/2, 100);

  textSize(50);
  text("jouer", width/2, 220);
  text("quitter",(width/2),height-70);
  text("r\u00e9gles",width/2,height/2+100);

  textSize(30);
  text("important", (width/2)-385, 2*height/3+30);

  textSize(21);
  text("pour votre bien-\u00eatre ne pas jouer avec des \u00e9couteurs", width/2, 2*height/3+60);
  text("ou les hauts-parleurs \u00e0 plus de 25.", width/2, 2*height/3+85);


  //l\u00e9gende images
  textSize(25);
  text("votre ", width/9, height/3-30);
  text("vaisseau :", width/9, height/3);
  text("ast\u00e9ro\u00efdes \u00e0 ", width/3+50, height/3-30);
  text("d\u00e9truire :", width/3+50, height/3);
  text("ast\u00e9ro\u00efdes  ", 2*width/3-50, height/3-30);
  text("indestructibles :", 2*width/3-50, height/3);
  text("4 bonus ", 8*width/9, height/3-30);
  text("al\u00e9atoire :", 8*width/9, height/3);

  //images centr\u00e9
  imageMode(CENTER);//positionnement au centre de l'image
  image(fusee, width/9-100, height/3+220,tailleXf/2,tailleYf/2);
  image(fusee2, width/9+100, height/3+220,tailleXf2/2,tailleYf2/2);
  image(fusee3, width/9, height/3+220,tailleXf3/2,tailleYf3/2);
  image(asteroide, width/3+50, height/3+100);
  image(asteroide_indestructible, 2*width/3-50, height/3+100);
  image(bonus, 8*width/9, height/3+100);
  
  
  // entoure la fusee choisie et la selectionne dans le jeu
  if (fusee_choisie == 1) {
    marge_m=40;//espace \u00e0 enlever pour le d\u00e9part du missile
    image(fusee, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9-100-tailleXf/2/2-10, height/3+220-tailleYf/2/2-10,tailleXf/2+20,tailleYf/2+20);
    strokeWeight(1);
  }
  else if (fusee_choisie == 2) {
    marge_m=75;//espace \u00e0 enlever pour le d\u00e9part du missile
    image(fusee2, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9+100-tailleXf2/2/2-10, height/3+220-tailleYf2/2/2-10,tailleXf2/2+20,tailleYf2/2+20);
    strokeWeight(1);
  }
  if (fusee_choisie == 3) {
    marge_m=40;//espace \u00e0 enlever pour le d\u00e9part du missile
    image(fusee3, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9-tailleXf3/2/2-10, height/3+220-tailleYf3/2/2-10,tailleXf3/2+20,tailleYf3/2+20);
    strokeWeight(1);
  }
  
  
  imageMode(CORNER);//repositionnement en au \u00e0 gauche de l'image
  
  if (regless==true){
    regles();
  }
}

//-----------------------------------------------------------------------------------------
//affichage regles
//-----------------------------------------------------------------------------------------
public void regles()
{
  background (0);
  textSize(48);
  fill(255);
  textAlign(CENTER);
  text("R\u00c9GLES", width/2, 60); 
  stroke(255);
  strokeWeight(4);
  line(width/2-100, 68, width/2+100, 68);
  strokeWeight(1);//remise de la taille des contours au minimum
  textSize(23*(width/height));//26-1080/1920
  text("vous contr\u00f4lez votre fus\u00e9e sur la hauteur (avec votre doigt), le but est d'\u00e9viter les ast\u00e9ro\u00efdes ou de ", width/2, 150);
  text("leur tirer dessus (avec un double tap).", width/2, 190);
  text("vous allez rencontrer des cases myst\u00e8res, elles vous permettront d'obtenir des bonus (vitesse ralenti,", width/2, 270);
  text("un super missile, une fus\u00e9e invincible et de la vie suppl\u00e9mentaire).", width/2, 310);

  text("la plupart de ces bonus ont une dur\u00e9e limit\u00e9e de 6 secondes.", width/2, 350 );
  //text("au fur et \u00e0 mesure du jeu, vous pourrez d\u00e9bloquer 2 fus\u00e9es.", width/2, 350);
  //text("vous gagnez des pi\u00e8ces durant le jeu, si vous avez 5 pi\u00e8ces au moment de votre mort, vous pouvez", width/2, 390);
  //text("reprendre la partie en \u00e9change de ces pi\u00e8ces.", width/2, 430);
  text("les ast\u00e9ro\u00efdes gris sont \u00e0 d\u00e9truire tandis que les rouges sont indestructible et donc \u00e0 \u00e9viter", width/2, 430);
  text("appuyer sur le bouton pause pour mettre en pause", width/2, 510);
  
  //rectangle "retour menu"
  fill(0);
  rect (width-310,height-100,240,60);
  fill(255);
  textSize(50);
  text("retour",width-190,height-50);
  
  textAlign(LEFT);
  
  mousePressed ();
}

//-----------------------------------------------------------------------------------------
//affichage skin
//-----------------------------------------------------------------------------------------
int last; 
int count=0;

public void mousePressed() {
  //action de la souris

  //--------------------------------------------------------------------------------------------------------
  //pour menu
  //--------------------------------------------------------------------------------------------------------
  if (menu==true) {
    //pour jouer
    if (mouseX>(width/2-90) && mouseX<(width/2+90) && mouseY>(175) && mouseY<(175+60)) {
      if (mousePressed == true) {
        println("Jouer");
        
        //lance l'acc\u00e9l\u00e9ration des stars
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
    
    //pour les r\u00e8gles
    if (mouseX>(width/2-110) && mouseX<(width/2+110) && mouseY>(height/2+50) && mouseY<(height/2+50+60)) {
      if (mousePressed == true) {
        println("r\u00e8gles");
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
  //retour menu dans r\u00e9gles
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

        //enregistrement du score pr\u00e9c\u00e9dent
        score_tmp=score;
        compteur_asteroide_tmp=compteur_asteroide;
        initialisation ();
        
        //lance l'acc\u00e9l\u00e9ration des stars
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
        
        //lance l'acc\u00e9l\u00e9ration des stars
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
    fill(255, 255, 255, 75);//75% d'opacit\u00e9
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
public void doubleclick() {
  fill(255); 
  //text("doubleclick",width/2, height/2);
  //pour tir missile
  if (menu ==false && gameover==false) {
    tir=1;
  } else {
    collision_missiles=false;
  }
} 
int niveau;
public void niveaux ()
{
  //augmentation de la vitesse des types d'ast\u00e9ro\u00efdes en focntion du score
  for (int i=0; i<nbra; i++)
  {
    for (int j=0; j<nbra_indestructible; j++)
    {
      if (score<=150)
      {
        sensXa[i]=(int)random(25, 40);
        sensXa_indestructible[j]=(int)random(25, 40);
        niveau=1;
      }
      if (score > 150 && score <= 350)
      {
        sensXa[i]=(int)random(35, 50);
        sensXa_indestructible[j]=(int)random(35, 50);
        niveau=2;
      } else if (score > 350 && score <= 600)
      {
        sensXa[i]=(int)random(45,60);
        sensXa_indestructible[j]=(int)random(45, 60);
        niveau=3;
      } else if (score > 600 && score <=1000)
      {
        sensXa[i]=(int)random(55, 70);
        sensXa_indestructible[j]=(int)random(55, 70);
        niveau=4;
      } else if (score >= 1000)
      {
        sensXa[i]=(int)random(65, 80);
        sensXa_indestructible[j]=(int)random(65, 80);
        niveau=5;
      }
    }
  }
}
//initialisation etoiles de fin
Star[] stars = new Star[800];
float speed;

//fonction \u00e9toiles de fin
public void stars_fin ()
{
  //vitesse des \u00e9toiles
  //speed = 3;

  //centrage de la fenetre
  translate(width/2, height/2);

  //lancement des actions sur la classe \u00e9toile
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }

  //remise \u00e0 0 de la fenetre
  translate(-width/2, -height/2);
}

//initialisation des \u00e9toiles 
class Star {
  float x;
  float y;
  float z;

  float pz;

  Star() {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
    pz = z;
  }

  //reintialisation des \u00e9toiles si plus dans la fen\u00eatre/cube
  public void update() {
    z = z - speed;
    if (z < 1) {
      z = random(3*width/4);
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      pz = z;
    }
  }

  //d\u00e9placement des \u00e9toiles avec train\u00e9
  public void show() {
    fill(255);
    noStroke();

    //\u00e9toiles
    float sx = map(x / z, 0, 1, 0, width/2);
    float sy = map(y / z, 0, 1, 0, height/2);
    float r = map(z, 0, width/2, 16, 0);
    ellipse(sx, sy, r, r);

    //lignes d\u00e9ri\u00e8res \u00e9toiles
    float px = map(x / pz, 0, 1, 0, width/2);
    float py = map(y / pz, 0, 1, 0, height/2);
    pz = z;
    stroke(255);
    line(px, py, sx, sy);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PFS" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
