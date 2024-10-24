<?php

namespace App\Controller;

use App\Entity\Client;
use App\Entity\Utilisateur;
use App\Form\InscriptionType;
use App\Repository\TypeClientRepository;
use App\Repository\TypeUtilisateurRepository;
use App\Repository\UtilisateurRepository;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\RequestHandlerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;

class InscriptionController extends AbstractController
{
    #[Route('/inscription', name: 'app_inscription')]
    public function index(Request $request, UserPasswordHasherInterface $userPasswordHasher, EntityManagerInterface $entitymanager, TypeUtilisateurRepository $typeUtilisateurRepo, TypeClientRepository $typeClientRepo, UtilisateurRepository $utilisateurRepo): Response
    {
        $form=$this->createForm(InscriptionType::class);
        
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $utilisateur=$form->getData();
            //creation d'un nouvel utilisateur type CLIENT
            // $utilisateur= new Utilisateur();
            // $utilisateur=$data;
            // $utilisateur->setEmail($data['email']);
            // $utilisateur->setNom($data['nom']);
            // $utilisateur->setPrenom($data['prenom']);
             /** @var string $plainPassword */
            $plainPassword = $form->get('plainPassword')->getData();

             // encode the plain password
            $utilisateur->setPassword($userPasswordHasher->hashPassword($utilisateur, $plainPassword));
             
            $utilisateur->setDateInscription(new DateTime());

            $typeUtilisateur=$typeUtilisateurRepo->findOneBy(['libelle_utilisateur'=>'client']);          
            $utilisateur->setTypeUtilisateur($typeUtilisateur);
            
            $entitymanager->persist($utilisateur);
            $entitymanager->flush();

            // Creation d'un nouveau client type Particulier
            $client= new Client();
            // $telephone=$form->getData('telephone');
            // $client->setTelephone($telephone);
            $client->setCoefClient('1.35');
            $client->setNumClient('12345678');
            $client->setUtilisateur($utilisateur);
            $commercial=$utilisateurRepo->find(4);
            $client->setCommercial($commercial);
            
            $typeclient= $typeClientRepo->findOneBy(['libelle'=>'particulier']);
            $client->setTypeClient($typeclient);

            $entitymanager->persist($client);
            $entitymanager->flush();
            
            return $this-> redirectToRoute('app_accueil');

        }

        return $this->render('inscription/index.html.twig', [
            'controller_name' => 'InscriptionController',
            'form'=>$form,
        ]);
    }
}
