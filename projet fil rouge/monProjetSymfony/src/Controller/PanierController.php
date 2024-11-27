<?php

namespace App\Controller;

use App\Service\PanierService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Attribute\Route;

class PanierController extends AbstractController
{
    public function __construct( private PanierService $panierService) { 
    }    

    #[Route('/panier', name: 'app_panier')]
    public function index(): Response
    {
        $panier_details=$this->panierService->IndexPanier();
        $total=$this->panierService->totalPanier($panier_details) ;
        
    //    dd($panier);
        return $this->render('panier/index.html.twig', [
            'panier' => $panier_details,
            'total' =>$total
        ]);
    }

    #[Route('/panier_add/{id}', name: 'app_panier_add')]
    public function addToCart($id): Response
    {
       $this->panierService->addToCart($id);

        return $this->redirect("/panier");
        // return $this->redirectToRoute("app_panier");
    }

    #[Route('/panier_remove/{id}', name: 'app_panier_remove_one')]
    public function removeOneFromCart($id): Response
    {   $this->panierService->removeOneFromCart($id);

        // return $this->redirect("/panier");
        return $this->redirectToRoute("app_panier");
    }

    #[Route('/panier_remove/{id}', name: 'app_panier_remove')]
    public function removeAllFromCart($id): Response
    {
        $this->panierService->removeAllFromCart($id);

        return $this->redirect("/panier");
        // return $this->redirectToRoute("app_panier");
    }
}
