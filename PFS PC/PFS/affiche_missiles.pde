
int tir=0;

void affiche_missiles ()
{
  //en fonction des actions de la souris
  if (tir==1) {
    if (tabXm<width) {
      //rappel taille d'origine missile
      tailleXm=50;
      tailleYm=22;

      collision_missiles=true;

      image(missile, tabXm-marge_m, tabYm, tailleXm, tailleYm);

      // Déplacer le missile
      tabXm=tabXm+sensXm;
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