<?php

namespace App\DataFixtures;

use App\Entity\Article;
use App\Entity\Categorie;
use App\Entity\Fournisseur;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class Jeu1 extends Fixture
{
    public function load(ObjectManager $manager): void
    {
    //1ère methode: Avec une base de données prééxistante:

        //on inclut les tableaux PHP de la base de données préétablie dans les exercices précedents
        include "hazelshop.php";

        //LES FOURNISSEURS
       
        //On remplit la base de donnée en utilisant le tableau PHP de la base pré-existante
        foreach ($fournisseur as $fourni)
        {
            $fDB=new Fournisseur;
            $fDB
            -> setId($fourni['id_fournisseur'])
            -> setNomFournisseur($fourni['nom_fournisseur'])
            -> setMailFournisseur($fourni['mail_fournisseur'])
            -> setTelFournisseur($fourni['tel_fournisseur']);
        // Pour empecher l'auto-incrementation de l'Id:
        $metadata= $manager->getClassMetadata(Fournisseur::class);
        $metadata-> setIdGeneratorType(\Doctrine\ORM\Mapping\ClassMetadata::GENERATOR_TYPE_NONE);
        //On enregistre l'itération de la boucle
        $manager->persist($fDB);
        };
        //On envoie les modifications pour générer le code sql et mettre à jour la base
        $manager ->flush();
 
        
        //LES CATEGORIES

        // Pour appeler les repository des relations
        $categorieRepo= $manager-> getRepository(Categorie::class);

         //On rempli la base de donnée en utilisant le tableau PHP de la base pré-existante
         foreach ($categorie as $cat)
         {
            $catDB=new Categorie;
            $catDB-> setId($cat['id_categorie'])
                  -> setLibelleCategorie($cat['libelle_categorie'])
                  -> setImgCategorie($cat['img_categorie']);
            
                    
            // Pour empecher l'auto-incrementation de l'Id:
            $metadata= $manager->getClassMetadata(Categorie::class);
            $metadata-> setIdGeneratorType(\Doctrine\ORM\Mapping\ClassMetadata::GENERATOR_TYPE_NONE); 

             //on enregistre l'itération de la boucle
             $manager->persist($catDB);
             //on envoie les modifications pour générer le code sql et mettre à jour la base
             $manager ->flush();   
            
             //pour relier avec l'entité de la relation (categorie mère)
               if ($cat['categorie_mere']!= NULL){
                
                $categorieMere= $categorieRepo->find($cat['categorie_mere']);
                $catDB-> setCategorieMere($categorieMere);  
                  //on enregistre l'itération de la boucle
                $manager->persist($catDB);
                //on envoie les modifications pour générer le code sql et mettre à jour la base
                $manager ->flush();                       

               };    
               
        };
        // LES ARTICLES (même schéma)

        // Pour appeler les repository des relations
        $categorieRepo= $manager-> getRepository(Categorie::class); 
        $fournisseurRepo= $manager-> getRepository(Fournisseur::class);        

        //On rempli la base de données en utilisant le tableau PHP de la base pré-existante
        foreach ($article as $art)
        {
            $artDB= new Article;
            $artDB-> setId($art['id_article'])
                  -> setLibelleArticle($art['libelle_article'])
                  -> setDescription($art['description'])
                  -> setImgArticle($art['img_article'])
                  -> setQteStock($art['qte_stock'])
                  -> setPrixAchat($art['prix_achat'])
                  -> setRefFournisseur($art['ref_fournisseur']);


            //pour relier avec l'entité  des relations
            $categorie= $categorieRepo->find($art['id_categorie']);
            $artDB-> setCategorie($categorie);

            $fournisseur=$fournisseurRepo->find($art['id_fournisseur']);
            $artDB->setFournisseur($fournisseur);

            // Pour empecher l'auto-incrémentation de l'Id:
            $metadata= $manager->getClassMetadata(Article::class);
            $metadata-> setIdGeneratorType(\Doctrine\ORM\Mapping\ClassMetadata::GENERATOR_TYPE_NONE);

            //on enregistre l'itération de la boucle
            $manager->persist($artDB);
       
            //on envoie les modifications pour générer le code sql et mettre à jour la base
            $manager ->flush();
        };
      
    //2éme methode: en créant des valeurs

        //On ajoute un article
        $article1= new Article();
        $article1
            -> setLibelleArticle("Codenames")
            -> setDescription("Codenames est un jeu d’association d’idées pour 2 à 8 joueurs (voire plus !). Pour retrouver sous quel nom de code se cachent vos informateurs, écoutez bien les indices donnés par les deux maîtres-espions et prenez garde à ne pas contacter un informateur ennemi, ou pire… le redoutable assassin ! Si une équipe tombe par malchance sur ce vil personnage, la partie s'arrête et l'autre équipe remporte la mission.")
            -> setImgArticle("codenames.webp")
            -> setQteStock("5")
            -> setPrixAchat("14.50")
            -> setRefFournisseur("A50758");
          
        // pour relier à l'entité categorie
        $catArt1= $categorieRepo->find(2);
        $article1-> setCategorie($catArt1);

        //pour relier à l'entité fournisseur
        $fourniArt1= $fournisseurRepo->find(2);
        $article1-> setFournisseur($fourniArt1);
        
        $manager->persist($article1);
        $manager->flush();
    }
}


//Commande pour executer la fixture: php bin/console doctrine:fixtures:load 
