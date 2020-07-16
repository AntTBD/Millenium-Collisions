int regles;
boolean regless;

void affiche_menu()
{
  mousePressed();
  
  //fond noir avec image
  background(0);
  //image(fondecran, 0, 0,width,height);
  
  //lancement fonction étoiles fin 
  stars_fin();
  
  //formes de mise en page
  stroke(255);
  fill(0);
  rect((width/2)-490, 2*height/3, 980, 120);//rectangle "important"
  rect((width/2)-90, 175, 180, 60);//rectangle "jouer"
  rect ((width/2)-120,height-120,240,60);//rectangle "quitter"
  rect ((width/2)-110,height/2+50,220,60);//rectangle "règles"

  //texte centré
  fill(255);
  textAlign(CENTER);
  textSize(80);
  text("Menu", width/2, 100);

  textSize(50);
  text("jouer", width/2, 220);
  text("quitter",(width/2),height-70);
  text("régles",width/2,height/2+100);

  textSize(30);
  text("important", (width/2)-385, 2*height/3+30);

  textSize(21);
  text("pour votre bien-être ne pas jouer avec des écouteurs", width/2, 2*height/3+60);
  text("ou les hauts-parleurs à plus de 25.", width/2, 2*height/3+85);


  //légende images
  textSize(25);
  text("votre ", width/9, height/3-30);
  text("vaisseau :", width/9, height/3);
  text("astéroïdes à ", width/3+50, height/3-30);
  text("détruire :", width/3+50, height/3);
  text("astéroïdes  ", 2*width/3-50, height/3-30);
  text("indestructibles :", 2*width/3-50, height/3);
  text("4 bonus ", 8*width/9, height/3-30);
  text("aléatoire :", 8*width/9, height/3);

  //images centré
  imageMode(CENTER);//positionnement au centre de l'image
  image(fusee, width/9-100, height/3+220,tailleXf/2,tailleYf/2);
  image(fusee2, width/9+100, height/3+220,tailleXf2/2,tailleYf2/2);
  image(fusee3, width/9, height/3+220,tailleXf3/2,tailleYf3/2);
  image(asteroide, width/3+50, height/3+100);
  image(asteroide_indestructible, 2*width/3-50, height/3+100);
  image(bonus, 8*width/9, height/3+100);
  
  
  // entoure la fusee choisie et la selectionne dans le jeu
  if (fusee_choisie == 1) {
    marge_m=40;//espace à enlever pour le départ du missile
    image(fusee, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9-100-tailleXf/2/2-10, height/3+220-tailleYf/2/2-10,tailleXf/2+20,tailleYf/2+20);
    strokeWeight(1);
  }
  else if (fusee_choisie == 2) {
    marge_m=75;//espace à enlever pour le départ du missile
    image(fusee2, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9+100-tailleXf2/2/2-10, height/3+220-tailleYf2/2/2-10,tailleXf2/2+20,tailleYf2/2+20);
    strokeWeight(1);
  }
  if (fusee_choisie == 3) {
    marge_m=40;//espace à enlever pour le départ du missile
    image(fusee3, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9-tailleXf3/2/2-10, height/3+220-tailleYf3/2/2-10,tailleXf3/2+20,tailleYf3/2+20);
    strokeWeight(1);
  }
  
  
  imageMode(CORNER);//repositionnement en au à gauche de l'image
  
  if (regless==true){
    regles();
  }
}

//-----------------------------------------------------------------------------------------
//affichage regles
//-----------------------------------------------------------------------------------------
void regles()
{
  background (0);
  textSize(48);
  fill(255);
  textAlign(CENTER);
  text("RÉGLES", width/2, 60); 
  stroke(255);
  strokeWeight(4);
  line(width/2-100, 68, width/2+100, 68);
  strokeWeight(1);//remise de la taille des contours au minimum
  textSize(23*(width/height));//26-1080/1920
  text("vous contrôlez votre fusée sur la hauteur (avec votre doigt), le but est d'éviter les astéroïdes ou de ", width/2, 150);
  text("leur tirer dessus (avec un double tap).", width/2, 190);
  text("vous allez rencontrer des cases mystères, elles vous permettront d'obtenir des bonus (vitesse ralenti,", width/2, 270);
  text("un super missile, une fusée invincible et de la vie supplémentaire).", width/2, 310);

  text("la plupart de ces bonus ont une durée limitée de 6 secondes.", width/2, 350 );
  //text("au fur et à mesure du jeu, vous pourrez débloquer 2 fusées.", width/2, 350);
  //text("vous gagnez des pièces durant le jeu, si vous avez 5 pièces au moment de votre mort, vous pouvez", width/2, 390);
  //text("reprendre la partie en échange de ces pièces.", width/2, 430);
  text("les astéroïdes gris sont à détruire tandis que les rouges sont indestructible et donc à éviter", width/2, 430);
  text("appuyer sur le bouton pause pour mettre en pause", width/2, 510);
  
  //rectangle "retour menu"
  fill(0);
  rect (width-310,height-100,240,60);
  fill(255);
  textSize(50);
  text("retour",width-190,height-50);
  
  textAlign(LEFT);
  
  mousePressed ();
}

//-----------------------------------------------------------------------------------------
//affichage skin
//-----------------------------------------------------------------------------------------