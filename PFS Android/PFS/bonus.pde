void bonus()
{
  collision_asteroide=true;

  textAlign(CENTER);//centrer texte des différentes fonctions bonus

  //affichage bonus
  fill(0, 255, 0);
  image(bonus, Xb, Yb);

  // Déplacer les bonus
  Xb=Xb-sensXb;
  Yb=height/2-tailleXYb+(int)( amplitude * cos(TWO_PI * frameCount / periode));//oscillation en Y du bonus

  if (Xb<-1000)//espace durant lequel aura lieu le bonus
  {
    //ré-initialisation du bonus
    Xb=3*width;
    Yb=height/2-tailleXYb;
    choix_bonus=(int)random(0, 100);//random pour choix du bonus
  }

  //affiche de la vitesse des astéroides
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



void bonus_immunite ()
{
  if (a==1)
  {
    collision_asteroide = false;

    //légende
    text("bonus accélération", width/2, height/2);
    text("vous êtes immunisés", width/2, height/2+50);

    //image champ magnétique au premier plan
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

    //accélération des 2 types de missiles
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


void bonus_ralenti ()
{
  if (a==1)
  {
    //légende
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

void super_missile ()
{
  if (a==1) 
  {
    //légende
    text("bonus super missile", width/2, height/2);

    if (tir==1) {
      if (tabXm<width) {
        collision_missiles=false;


        //agrandissement taille missile
        tailleXm=100;
        tailleYm=44;

        //réaffichage du missile avec agrandissement
        image(missile, tabXm-marge_m, tabYm-10, tailleXm, tailleYm);//-10 pour recentrer le missile avec le vaisseau
        
        // Déplacer le missile
        tabXm=tabXm+sensXm;
        
        //super explosion
        for (int i=0; i<nbra; i++) {
          if ((tabXm+tailleXm>tabXa[i]) && (tabXm<tabXa[i]+tailleXa) && (tabYm-10)<(tabYa[i]+tailleYa) && ((tabYm+tailleYm-10)>tabYa[i])) {

            //remise à zero du tir
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
      //remise en place du missile si en dehors de la fenêtre
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


void full_vie ()
{
  if (a==1)
  {
    //légende
    text("supplément de vie", width/2, height/2);

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