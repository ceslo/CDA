<?php

namespace App\Controller;

use App\Repository\CategorieRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class AccueilController extends AbstractController
{
    private $categorieRepository; 

 public function __construct(CategorieRepository $categorieRepository)
 {

    $this-> categorieRepository =$categorieRepository;
    
 }


    #[Route('/', name: 'app_accueil')]
    public function index(): Response
    {
        $categories= $this->categorieRepository-> findAll();
    
    // var_dump($categories);

        return $this->render('accueil/index.html.twig', [
            'controller_name' => 'AccueilController',
            'categories'=> $categories,
        ]);
    }
}
