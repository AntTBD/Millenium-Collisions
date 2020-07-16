void affiche_legende ()
{
  //center la légende et le score
  textAlign(CENTER);

  /*
  //trait blanc de séparation pour la légende
   stroke(255);
   line(0, height-legende, width, height-legende);
   
   //légende
   fill(255);
   textSize(17);
   text("espace : pause           clic souris : tirer           souris : déplacement fusée", width/2, height-4);
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

  //centrer à gauche pour niveau, niveau précédent, nombre astéroides détruits
  textAlign(LEFT);

  //affichage niveau
  fill(255);
  textSize(40);
  text("niveau : "+niveau, 35, 50);

  //affichage du score précedent après avoir fait au moins une partie
  if (rejouer ==1) {
    textSize(36);
    text("score précédent : ", 35, 100);
    text("  "+compteur_asteroide_tmp, width/3, 100);
    textAlign(CENTER);
    text(score_tmp, width/2, 100);
    textAlign(LEFT);
  }

  //affichage nb d'asteroide détruit à coté de l'image astéroide explosé
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
