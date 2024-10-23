<?php

namespace App\Controller;

use App\Entity\Article;
use App\Repository\ArticleRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Attribute\Route;

class PanierController extends AbstractController
{
    #[Route('/panier', name: 'app_panier')]
    public function index(ArticleRepository $articleRepository, SessionInterface $session): Response
    {
        $panier = $session->get("panier", []);
        // dd($panier);
        $panier_details=[];
        foreach ($panier as $id => $quantity) {
            $panier_details[] = [
                'article' => $articleRepository->find($id),
                'quantite' => $quantity,
            ];
        };
        
    //    dd($panier);
        return $this->render('panier/index.html.twig', [
            'panier' => $panier_details,
        ]);
    }

    #[Route('/panier_add/{id}', name: 'app_panier_add')]
    public function addToCart($id, SessionInterface $session): Response
    {
        $panier = $session->get("panier", []);
        // dd($panier);

        if (isset($panier[$id])) {
            $panier[$id]++;
        } 
        else {
            $panier[$id] = 1;
        }

        $session->set("panier", $panier);

        return $this->redirect("/panier");
        // return $this->redirectToRoute("app_panier");
    }

    #[Route('/panier_remove/{id}', name: 'app_panier_remove_one')]
    public function removeOneFromCart($id, SessionInterface $session): Response
    {
        $panier = $session->get("panier", []);
        // dd($panier);

        if ($panier[$id] = 1) {
            unset($panier[$id]);
        } 
        else {
            
            $panier[$id]--;
        }

        $session->set("panier", $panier);

        return $this->redirect("/panier");
        // return $this->redirectToRoute("app_panier");
    }

    #[Route('/panier_remove/{id}', name: 'app_panier_remove')]
    public function removeAllFromCart($id, SessionInterface $session): Response
    {
        $panier = $session->get("panier", []);
        // dd($panier);

      
        if (isset($panier[$id])) {

            unset($panier[$id]);
        }

        $session->set("panier", $panier);

        return $this->redirect("/panier");
        // return $this->redirectToRoute("app_panier");
    }
}
