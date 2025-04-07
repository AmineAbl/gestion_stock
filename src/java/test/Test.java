/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import dao.CategorieDao;
import dao.MouvementStockDao;
import dao.ProduitDao;
import util.HibernateUtil;
import dao.UserDao;
import entities.Categorie;
import entities.MouvementStock;
import entities.Produit;
import entities.User;
import java.util.Date;

public class Test {
    public static void main(String[] args) {
        //HibernateUtil.getSessionFactory();
       /* UserDao ud = new UserDao();
        ud.create(new User("Abl", "Amine", "amine@gmail.com", "amine123"));
        
        ud.create(new User("Abl", "Anas", "anas@gmail.com", "anas123"));
        ud.delete(ud.findById(1));
        
        for(User u : ud.findAll()){
            System.out.println(u.getPrenom());
        }
        
        CategorieDao cd = new CategorieDao();
        cd.create(new Categorie("eletronique"));
        cd.create(new Categorie("mecanique"));
        
        ProduitDao pd = new ProduitDao();
        pd.create(new Produit("alternateur", 4, 1000 ,cd.findById(2) ));
        
        for(Produit p :cd.findById(2).getProduits()){
            System.out.println(p.getNom());
        }
       MouvementStockDao msd = new MouvementStockDao();
       msd.create(new MouvementStock("mecanique", 20, new Date(), pd.findById(1)));
                */
        }
}
        

