void affiche_fusee ()
{
  //conditions pour que la fusee reste dans la fenêtre même si la souris n'y est pas
  if (mouseY<tailleYf/2)
  {
    mouseY=tailleYf/2;
  }
  if (mouseY>(height-tailleYf/2))
  {
    mouseY=(height-tailleYf/2);
  }
  
  //fusee (centré en Y sur le milieux de la fusee)
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