void affiche_asteroide ()
{
  // Affichage des astéroides
  for (int i=0; i<nbra; i++)
  {
    image(asteroide, tabXa[i], tabYa[i],tailleXa,tailleYa);
    
    // Déplacement des astéroïdes en X
    tabXa[i]=tabXa[i]-sensXa[i];
    
    //reinitialisation des astéroides s'ils ne sont plus dans la fenêtre
    if (tabXa[i]<(-tailleXf-fuseeX))
    {
      tabXa[i]=(int)random(width, 2*width);
      tabYa[i]=(int)random(0, height-tailleYa);
    }
  }

  // Affichage des astéroides indestructibles
  for (int i=0; i<nbra_indestructible; i++)
  {
    image(asteroide_indestructible, tabXa_indestructible[i], tabYa_indestructible[i],tailleXa_indestructible,tailleYa_indestructible);
    
    // Déplacer les astéroïdes indestructibles en X
    tabXa_indestructible[i]=tabXa_indestructible[i]-sensXa_indestructible[i];
    
    //reinitialisation des astéroides s'ils ne sont plus dans la fenêtre
    if (tabXa_indestructible[i]<(-tailleXf-fuseeX))
    {
      tabXa_indestructible[i]=(int)random(width, 4*width);
      tabYa_indestructible[i]=(int)random(0, height-tailleYa_indestructible);
    }
  }
}