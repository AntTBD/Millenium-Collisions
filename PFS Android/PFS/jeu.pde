void jouer()
{
  // couleur de fond avec image
  background(0);
  //image(fondecran,0,0, width, height);

  //temps (60 fois par seconde)
  t=t+1;
  //score
  if ( (t % 10) == 0 )//reduction à toute les demies secondes
  {
    score = score + 1;//1 point toutes les quarts de secondes
  }

  //lancement de touts les focntions suivant les conditions
  affiche_vies();
  affiche_legende ();
  //aides_affiche();//affichage pour tester
  affiche_etoiles ();
  affiche_fusee ();
  niveaux ();
  bonus ();

  if ( collision_asteroide == true)
  {
    if (collision_missiles==true)
    {
      affiche_asteroide ();
      affiche_missiles ();
      collision_asteroides ();
      collision_missiles ();
    } else if (collision_missiles==false)
    {
      affiche_asteroide ();
      affiche_missiles ();
      collision_asteroides ();
    }
  } else if (collision_asteroide == false)
  {
    if (collision_missiles==true)
    {
      affiche_asteroide ();
      affiche_missiles ();
      collision_missiles ();
    } else if (collision_missiles==false)
    {
      affiche_asteroide ();
      affiche_missiles ();
    }
  }
}