void affiche_vies()
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