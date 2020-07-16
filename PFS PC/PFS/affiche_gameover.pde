int c=0;

void affiche_gameover ()
{
  //pour changement de la couleurs des commentaires
  c=c+2;
  if (c > 1250) c = 0;

  //fond noir avec animation étoiles
  background(0);
  stars_fin();

  //légende de fin
  textAlign(LEFT);//allignement du texte à gauche
  fill(255);
  textSize(40);
  text("votre score : "+score+" points", 20, 50);
  text("vous avez detruit : "+compteur_asteroide+" astéroïdes", 20, 100);
  //image(asteroide, 550, 50, 70, 60);

  //changement de couleur automatique
  colorMode(HSB);
  fill(c/5, 1000, 1000);

  //Commentaires adaptés en fonction du score
  if (score<200) {
    text("you can do it !!!", 20, 150);
  }
  if ((score>200) && (score<500)) {
    text("keep practicing !", 20, 150);
  }
  if ((score>500) && (score<2000)) {
    text("good game", 20, 150);
  }
  if ((score>2000) && (score<4000)) {
    text("almost great", 20, 150);
  }
  if (score>4000) {
    text("you're so great !", 20, 150);
  }

  //affichage du score précedent 
  if (rejouer ==1) {
    fill(255);
    text("score précédent :           /  "+score_tmp+" points", 20, 250);
    text(compteur_asteroide_tmp, 490, 250);
    image(asteroide, 600, 200, 70, 60);

    //changement de couleur automatique
    colorMode(HSB);
    fill(c/4, 1000, 1000);

    //commentaire progression avec le précédent score
    if (score_tmp<score) {
      text("tu progresses, bravo !", 20, 300);
    } else if (score_tmp>score) {
      text("tu as déjà fait mieux, dommage", 20, 300);
    }
  }
  colorMode(RGB);//remise en place du bon mode de couleur RGB
  fill(255);//remise de la couleur en blanc


  textAlign(CENTER);
  fill(255, 0, 0);
  textSize(70);
  text("game over", width/2, height/2);

  mousePressed();

  //rectangle "rejouer"
  fill(255);
  rect(width/2-100, height/2+100, 200, 50,10);
  fill(0);
  textSize(40);
  text("rejouer", width/2, height/2+140);
  
  //rectangle "menu"
  fill(255);
  rect ((width/2)-400,height/2+100,200,50,10);
  fill(0);
  textSize(40);
  text("menu",(width/2-300), height/2+140);
  
  //rectangle "quitter"
  fill(255);
  rect ((width/2)+200,height/2+100,200,50,10);
  fill(0);
  textSize(40);
  text("quitter",(width/2+300), height/2+140);
}