<?php

namespace App\Controller;

use App\Entity\Adresse;
use App\Entity\Commande;
use App\Entity\Utilisateur;
use App\Form\AdresseCommandeType;
use App\Form\AdresseType;
use App\Repository\AdresseRepository;
use App\Repository\ArticleRepository;
use App\Repository\ClientRepository;
use App\Repository\UtilisateurRepository;
use DateTime;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Attribute\Route;


class CommandeController extends AbstractController
{  
    #[Route('/commande', name: 'app_commande')]
    public function index(SessionInterface $session, Request $request, ArticleRepository $articleRepository, UtilisateurRepository $utilisateurRepo, ClientRepository $clientRepo, AdresseRepository $adresseRepository, EntityManagerInterface $entityManager): Response
    {       
        // Recupération des données de l'utilisateur
      
        $utilisateur= $this->getUser();

        if (!$utilisateur) {
            throw $this->createAccessDeniedException('Vous devez être connecté pour continuer');
            // return $this->redirectToRoute('app_login');
        }         
       
        // on recupère les données du client associé l'utilisateur
        $id = $utilisateur->getUserIdentifier();
        $u = $utilisateurRepo->findOneBy(["email" => $id]);
        $clientID= $u->getClient();
        $client=$clientRepo->findOneBy(["id"=>$clientID]);
        
        // on récupère les adresses connues
        $adresses = $adresseRepository->findBy(['client' => $client]);
        // dd($adresses);

        $options=['utilisateur'=>$utilisateur];
        $form1 = $this->createForm(AdresseCommandeType::class,null, $options);
        $form1->handleRequest($request);
        
        $form2=$this->createForm(AdresseType::class);
        $form2->handleRequest($request);

        // Choix de l'adresse

        if ($form1->isSubmitted() && $form1->isValid()) {
        // Récupère l'adresse existante
            $adresse = $form1->getData();
        }            
    // OU
        if ($form2->isSubmitted() && $form2->isValid()) {
        // Créé l'adresse       
            $adresse = $form2->getData()
                ->setClient($client);
            $entityManager->persist($adresse);
            $entityManager->flush();
        };
                
        // On récupère le contenu du panier
        $panier = $session->get("panier", []);
     
        $panier_details=[];
        foreach ($panier as $id => $quantity) {
            $panier_details[] = [
                'article' => $articleRepository->find($id),
                'quantite' => $quantity,
            ];
        };
        
        $commande=new Commande();
        $commande
            ->setClient($client)
            ->setAdresseLivraison($adresse)
            ->setAdresseFacturation($adresse)
            ->setDateCommande(new DateTime('now'))
            ->setFraisPort("4.90")
            ->setModePaiement("CB")
            ->setDelaisReglement("0")
            ->setStatut("Enregistrée");
            

          

        return $this->render('commande/index.html.twig', [
            'utilisateur'=>$utilisateur, 
            'panier'=>$panier_details,
            'client'=>$client,
            'adresses'=>$adresses,
            'form1' => $form1,
            'form2' => $form2
        ]);
    }


    // #[Route('/commande/livraison', name: 'app_commande_livraison')]
    // public function livraison(){
 
    // }

}

