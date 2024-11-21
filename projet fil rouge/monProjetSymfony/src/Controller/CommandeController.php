<?php

namespace App\Controller;

use App\Entity\Adresse;
use App\Entity\Utilisateur;
use App\Form\AdresseCommandeType;
use App\Repository\AdresseRepository;
use App\Repository\ArticleRepository;
use App\Repository\ClientRepository;
use App\Repository\UtilisateurRepository;
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

        $form = $this->createForm(AdresseCommandeType::class,null,['utilisateur'=>$utilisateur]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $data = $form->getData();

            // Récupérer ou créer l'adresse
            // $adresse = Adresse::class;
            if ($data['adresseExistante']) {
                $adresse = $adresseRepository>find($data['adresseExistante']);
            } elseif ($data['nouvelleAdresse']) {
                $adresse = $data['nouvelleAdresse']
                    ->setClient($client);
                $entityManager->persist($adresse);
                $entityManager->flush();
            };
            dd($adresse);
       
        // On récupère le contenu du panier
        $panier = $session->get("panier", []);
     
        $panier_details=[];
        foreach ($panier as $id => $quantity) {
            $panier_details[] = [
                'article' => $articleRepository->find($id),
                'quantite' => $quantity,
            ];
        };

        return $this->render('commande/index.html.twig', [
            'utilisateur'=>$utilisateur, 
            'panier'=>$panier_details,
            'client'=>$client,
            'adresses'=>$adresses
        ]);
    }

    // #[Route('/commande/livraison', name: 'app_commande_livraison')]
    // public function livraison(){
 
    // }

}

}