void affiche_etoiles ()
{
  // Affichages Etoiles de fond
  for (int i=0; i<nombre; i++)
  {
    //étoiles sous formes de petites éllipses
    noStroke();//sans contour
    fill(255);
    ellipse(tabX[i], tabY[i], taille[i], taille[i]);
    
    // Déplacement des étoiles
    tabX[i]=tabX[i]-sensX[i];
    
    //reinitialisation des étoiles s'ils ne sont plus dans la fenêtre
    if (tabX[i]<=taille[i])
    {
      tabX[i]=width;
      tabY[i]=(int)random(taille[i], height-taille[i]);
    }
  }
}