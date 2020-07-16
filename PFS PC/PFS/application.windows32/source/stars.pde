//initialisation etoiles de fin
Star[] stars = new Star[800];
float speed;

//fonction étoiles de fin
void stars_fin ()
{
  //vitesse des étoiles
  //speed = 3;

  //centrage de la fenetre
  translate(width/2, height/2);

  //lancement des actions sur la classe étoile
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }

  //remise à 0 de la fenetre
  translate(-width/2, -height/2);
}

//initialisation des étoiles 
class Star {
  float x;
  float y;
  float z;

  float pz;

  Star() {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
    pz = z;
  }

  //reintialisation des étoiles si plus dans la fenêtre/cube
  void update() {
    z = z - speed;
    if (z < 1) {
      z = random(3*width/4);
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      pz = z;
    }
  }

  //déplacement des étoiles avec trainé
  void show() {
    fill(255);
    noStroke();

    //étoiles
    float sx = map(x / z, 0, 1, 0, width/2);
    float sy = map(y / z, 0, 1, 0, height/2);
    float r = map(z, 0, width/2, 16, 0);
    ellipse(sx, sy, r, r);

    //lignes dérières étoiles
    float px = map(x / pz, 0, 1, 0, width/2);
    float py = map(y / pz, 0, 1, 0, height/2);
    pz = z;
    stroke(255);
    line(px, py, sx, sy);
  }
}
