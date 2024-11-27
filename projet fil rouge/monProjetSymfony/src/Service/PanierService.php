<?php

namespace App\Service;

use App\Repository\ArticleRepository;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class PanierService {   

    private $session;
    // private $articleRepository;

    // public function __construct(SessionInterface $session, ArticleRepository $articleRepository)  
    public function __construct(private RequestStack $requestStack, private ArticleRepository $articleRepository) { 
        // $this->session = $session;
        // $this->articleRepository = $articleRepository;
        $this->session = $this->requestStack->getSession();

    }       

    public function IndexPanier()
    {
        $panier = $this->session->get("panier", []);
        // dd($panier);
        $panier_details=[];
        foreach ($panier as $id => $quantity) {
            $panier_details[] = [
                'article' => $this->articleRepository->find($id),
                'quantite' => $quantity,
            ];
        };
        // dd($panier_details);
        return $panier_details;        
    }

    public function totalPanier($panier_details){
        // Je calcule le prix total du panier
        $total=0;
        foreach($panier_details as $item)
        {
            $totalItem= ($item['article']->getPrixAchat()) * $item['quantite'];
            $total += $totalItem;
        };
        return $total;
        }    

    public function addToCart($id)
    {
        $panier = $this->session->get("panier", []);
        // dd($panier);

        if (isset($panier[$id])) {
            $panier[$id]++;
        } 
        else {
            $panier[$id] = 1;
        }
        $this->session->set("panier", $panier);
              
    }    
    
    public function removeAllFromCart($id)
    {
        $panier = $this->session->get("panier", []);
        // dd($panier);      
        if (isset($panier[$id])) {

            unset($panier[$id]);
        }
        $this->session->set("panier", $panier);
    }

    public function removeOneFromCart($id)
    {        
        $panier = $this->session->get("panier", []);
        // dd($panier);

        if ($panier[$id]> 1) {
            $panier[$id]--;
        } 
        else {
            unset($panier[$id]);    
        }
        $this->session->set("panier", $panier);      
    }
}