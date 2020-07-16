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
  //rect((width/2)-490, 2*height/3, 980, 120,10);//rectangle "important"
  rect((width/2)-90, 175, 180, 60,10);//rectangle "jouer"
  rect ((width/2)-120,height-120,240,60,10);//rectangle "quitter"
  //rect ((width/2)-110,height/2+50,220,60,10);//rectangle "règles"
  rect ((width/2)-110,height*2/3+25,220,60,10);//rectangle "règles"

  //texte centré
  fill(255);
  textAlign(CENTER);
  textSize(80);
  text("Menu", width/2, 100);

  textSize(50);
  text("jouer", width/2, 220);
  text("quitter",(width/2),height-70);
  //text("régles",width/2,height/2+100);
  text("régles",width/2,height*2/3+75);

  /*textSize(30);
  text("important", (width/2)-385, 2*height/3+30);

  textSize(21);
  text("pour votre bien-être ne pas jouer avec des écouteurs", width/2, 2*height/3+60);
  text("ou les hauts-parleurs à plus de 25.", width/2, 2*height/3+85);*/


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

  //importation des asteroides
  if (astero==true) {
      asteroide = loadImage("asteroid.png");
      nbra = 8;
      tailleXa=164;
      tailleYa=128;
      tabXa=new int[nbra];
      tabYa=new int[nbra];
      sensXa=new int[nbra];
      asteroide_indestructible =loadImage("asteroide_indestructible.png");
      nbra_indestructible=5;
      tailleXa_indestructible=100;
      tailleYa_indestructible=100;
      tabXa_indestructible=new int[nbra_indestructible];
      tabYa_indestructible=new int[nbra_indestructible];
      sensXa_indestructible=new int[nbra_indestructible];
    }
    else {
      asteroide = loadImage("asteroide_indestructible.png");
      nbra = 5;
      tailleXa=100;
      tailleYa=100;
      tabXa=new int[nbra];
      tabYa=new int[nbra];
      sensXa=new int[nbra];
      asteroide_indestructible =loadImage("asteroid.png");
      nbra_indestructible=8;
      tailleXa_indestructible=164;
      tailleYa_indestructible=128;
      tabXa_indestructible=new int[nbra_indestructible];
      tabYa_indestructible=new int[nbra_indestructible];
      sensXa_indestructible=new int[nbra_indestructible];
    }

  //images centré
  imageMode(CENTER);//positionnement au centre de l'image
  image(fusee, width/9-100, height/3+220,tailleXf/2,tailleYf/2);
  image(fusee2, width/9, height/3+220,tailleXf3/2,tailleYf3/2);
  image(fusee3, width/9+100, height/3+220,tailleXf2/2,tailleYf2/2);
  image(asteroide, width/3+50, height/3+100);
  image(asteroide_indestructible, 2*width/3-50, height/3+100);
  image(bonus, 8*width/9, height/3+100);
  
  image(fleches_inverses, width/2, height/3+100, 100,100);
  
  
  // entoure la fusee choisie et la selectionne dans le jeu
  if (fusee_choisie == 1) {
    marge_m=40;//espace à enlever pour le départ du missile
    image(fusee, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9-100-tailleXf/2/2-10, height/3+220-tailleYf/2/2-10,tailleXf/2+20,tailleYf/2+20,5);
    strokeWeight(1);
  }
  else if (fusee_choisie == 2) {
    marge_m=75;//espace à enlever pour le départ du missile
    image(fusee2, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9-tailleXf3/2/2-10, height/3+220-tailleYf3/2/2-10,tailleXf3/2+20,tailleYf3/2+20,5);
    strokeWeight(1);
  }
  if (fusee_choisie == 3) {
    marge_m=40;//espace à enlever pour le départ du missile
    image(fusee3, width/9, height/3+100);
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(width/9+100-tailleXf2/2/2-10, height/3+220-tailleYf2/2/2-10,tailleXf2/2+20,tailleYf2/2+20,5);
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
  //textSize(23*(width/height));//26-1080/1920
  textSize((width/500)*8);
  text("vous contrôlez votre fusée sur la hauteur (avec votre doigt), le but est d'éviter les astéroïdes", width/2, 150);
  text("ou de leur tirer dessus (avec un double tap).", width/2, 190);
  text("vous allez rencontrer des cases mystères, elles vous permettront d'obtenir des bonus:", width/2, 270);
  text("vitesse ralenti, un super missile, une fusée invincible et de la vie supplémentaire.", width/2, 310);
  text("la plupart de ces bonus ont une durée limitée de 6 secondes.", width/2, 350 );
  
  //text("au fur et à mesure du jeu, vous pourrez débloquer 2 fusées.", width/2, 350);
  //text("vous gagnez des pièces durant le jeu, si vous avez 5 pièces au moment de votre mort, vous pouvez", width/2, 390);
  //text("reprendre la partie en échange de ces pièces.", width/2, 430);
  //text("les astéroïdes gris sont à détruire tandis que les rouges sont indestructible et donc à éviter", width/2, 430);
  text("vous pouvez choisir quel asteroide vous voulez detruire et quel sera l'indestructible.", width/2, 430);
  text("vous avez aussi le choix pour la fusée (avec un simple clic dans le menu sur celle de votre choix).",width/2, 470);
  text("appuyer sur le bouton pause en haut à droite pour mettre en pause.", width/2, 560);
  
  //rectangle "retour menu"
  fill(0);
  rect (width-310,height-100,240,60,10);
  fill(255);
  textSize(50);
  text("retour",width-190,height-50);
  
  textAlign(LEFT);
  
  mousePressed ();
}
