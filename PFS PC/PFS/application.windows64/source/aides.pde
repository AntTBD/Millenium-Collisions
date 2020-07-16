void aides_affiche ()
{ 
  //ligne centree sur souris (soit milieu de l'image de la fusee)
  stroke(255);
  strokeWeight(1);
  line(0, mouseY, 500, mouseY);

  //rectangle délimite fusee
  noFill();
  rect(10, mouseY-tailleYf/2, tailleXf, tailleYf);

  for (int i=0; i<nbra; i++)
  {
    // cercles à l'avant (haut et bas) de chaque astéroide
    fill(255);
    ellipse(tabXa[i], tabYa[i], 10, 10);
    fill(0, 255, 0);
    ellipse(tabXa[i], tabYa[i]+tailleYa, 10, 10);
    //rectangle délimite chaque astéroide
    noFill();
    stroke(255, 0, 0);
    rect(tabXa[i], tabYa[i], tailleXa, tailleYa);
  }

  for (int i=0; i<nbra_indestructible; i++)
  {
    //rectangle délimite chaque astéroides indestructibles
    rect(tabXa_indestructible[i], tabYa_indestructible[i], tailleXa_indestructible, tailleYa_indestructible);
  }

  //lignes pour se répérer en haut en en bas du carré bonus
  stroke(0, 255, 0);
  line(0, Yb, width, Yb);
  line(0, Yb+tailleXYb, width, Yb+tailleXYb);
  rect(Xb, Yb, tailleXYb, tailleXYb);
}
