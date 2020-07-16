//---------------------------------------------------------------------------------
// Déclaration de variables globales
//---------------------------------------------------------------------------------
//Importation de la fonction son de processing
import processing.sound.*;
//import cassette.audiofiles.*;
//import cassette.audiofiles.SoundFile;


//Initialisation des images
PImage fondecran;
PImage fusee,fusee2,fusee3;
PImage asteroide;
PImage asteroide_indestructible;
PImage missile;
PImage explosion;
PImage jauge;
PImage bonus;
PImage bouclier;
PImage icone_jeu;
PImage demarrage;
PImage fleches_inverses;

//Initialisation des sons
SoundFile missile_tir;
SoundFile crash;
SoundFile bonuss;


// Initialisation étoiles fond d'écran
int nombre = 400;
int []tabX = new int[nombre];
int []tabY = new int[nombre];
int []sensX = new int[nombre];
int [] taille=new int[nombre];

// Initialisation fusée
//coordonnées
int fuseeX=50;
//taille fusee1
int tailleXf=176;
int tailleYf=130;
//taille fusee2
int tailleXf2=157;
int tailleYf2=130;
//taille fusee3
int tailleXf3=139;
int tailleYf3=130;
//choix fusee
int fusee_choisie=1;

//entiers pour les tableaux
int i, j;

//choix asteroides
boolean astero=true;
// Initialisation Astéroides (a pour astéroide)
int nbra;
int []tabXa;
int []tabYa;
int []sensXa;
int tailleXa;
int tailleYa;

//Intialisation asteroides indestructibles (a_indestructible pour différencer)
int nbra_indestructible;
int []tabXa_indestructible;
int []tabYa_indestructible;
int []sensXa_indestructible;
int tailleXa_indestructible;
int tailleYa_indestructible;

// Initialisation missile (m pour missile)
int tabXm;
int tabYm;
int sensXm;
int tailleXm=50;
int tailleYm=22;
int missileX=tailleXf+fuseeX;
int marge_m;

//Initialiasation bonus
int Xb;
int Yb;
//pour oscillation
float periode;
float amplitude;
int tailleXYb=100;//largeur/longueur bonus identique
int sensXb=10;

//variable pour les ponits de vie
int vie;

//bonus
int choix_bonus;
int a;//variable de condition
int timer;//temps du bonus

//taille de la légende en bas de l'écran
int legende=20;

//condition de jeu
boolean collision_asteroide;
boolean collision_missiles;
boolean gameover;
boolean menu;
boolean pause;

//score en fonction de t
int t=0;
int score;

//variable pour lancer le score précedent après rejouer
int rejouer;
//compteurs temporaire si rejouer
int score_tmp;
int compteur_asteroide;
int compteur_asteroide_tmp;

int image_depart;


boolean accestars;
