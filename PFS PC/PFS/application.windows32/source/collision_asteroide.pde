void collision_asteroides () {
  // collision avec astéroides
  for (int i=0; i<nbra; i++) 
  {
    if ((tabXa[i]<(tailleXf+fuseeX)) && ( tabXa[i]+tailleXa>fuseeX) && (tabYa[i])<(mouseY+tailleYf/2) && ((tabYa[i]+tailleYa)>(mouseY-tailleYf/2))) 
    {
      //lancement du son
      crash.play();

      //astéroide en fonction du score
      println("asteroide "+score);

      //fusee centrée en Y avec explosion
      if (fusee_choisie == 1) {
        image(fusee, fuseeX, mouseY-tailleYf/2,tailleXf,tailleYf);
      }
      if (fusee_choisie == 2) {
        image(fusee2, fuseeX, mouseY-tailleYf2/2,tailleXf2,tailleYf2);
      }
      if (fusee_choisie == 3) {                                  // SELON LE CHOIX DE LA FUSEE :
        image(fusee3, fuseeX, mouseY-tailleYf3/2,tailleXf3,tailleYf3);                  // AFFICHAGE DES FUSEES EN FONCTION DES COORDONNEES DE LA SOURIS
      }
      image(explosion, fuseeX+tailleXf-64, mouseY-64, 130, 130);

      //points de vie réduit
      vie=vie-1;
    }
  }

  // collision avec astéroides indestructibles
  for (int i=0; i<nbra_indestructible; i++)
  {
    if ((tabXa_indestructible[i]<(tailleXf+fuseeX)) && ( tabXa_indestructible[i]+tailleXa_indestructible>0) && (tabYa_indestructible[i])<(mouseY+tailleYf/2) && ((tabYa_indestructible[i]+tailleYa_indestructible)>(mouseY-tailleYf/2))) 
    {
      //lancement du son
      crash.play();

      //astéroide en fonction du score
      println("asteroide indestructible "+score);

      //fusee centrée en Y avec explosion
      if (fusee_choisie == 1) {
        image(fusee, fuseeX, mouseY-tailleYf/2,tailleXf,tailleYf);
      }
      if (fusee_choisie == 2) {
        image(fusee2, fuseeX, mouseY-tailleYf2/2,tailleXf2,tailleYf2);
      }
      if (fusee_choisie == 3) {                                  // SELON LE CHOIX DE LA FUSEE :
        image(fusee3, fuseeX, mouseY-tailleYf3/2,tailleXf3,tailleYf3);                  // AFFICHAGE DES FUSEES EN FONCTION DES COORDONNEES DE LA SOURIS
      }
      image(explosion, fuseeX+tailleXf-64, mouseY-64, 130, 130);

      //points de vie réduit
      vie=vie-3;
    }
  }
}
