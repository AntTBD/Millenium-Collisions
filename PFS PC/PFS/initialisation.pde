void initialisation ()
{
  // Etoiles
  for (i=0; i<nombre; i++)
  {
    taille[i]=(int)random(1, 5);
    tabX[i]=(int)random(taille[i], width-taille[i]);
    tabY[i]=(int)random(taille[i], height-taille[i]);
    sensX[i]=(int)random(1, 5);
  }

  // Astéroides
  for (i=0; i<nbra; i++)
  {
    tabXa[i]=(int)random(width, 2*width);
    tabYa[i]=(int)random(0, height-tailleYa);
    sensXa[i]=(int)random(8, 13);
  }
  compteur_asteroide=0;

  // Astéroides indestructible
  for (i=0; i<nbra_indestructible; i++)
  {
    tabXa_indestructible[i]=(int)random(width, 4*width);
    tabYa_indestructible[i]=(int)random(0, height-tailleYa_indestructible);
    sensXa_indestructible[i]=(int)random(8, 13);
  }

  // missiles
  tabXm=tailleXf+fuseeX;
  tabYm=mouseY-10;
  sensXm=40;
  collision_missiles=false;

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