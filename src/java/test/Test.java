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
import java.util.List;

public class Test {
    public static void main(String[] args) {
       // HibernateUtil.getSessionFactory();
        //Création
        UserDao ud = new UserDao();
        CategorieDao cd = new CategorieDao();
        ProduitDao pd = new ProduitDao();
        MouvementStockDao msd = new MouvementStockDao();
        
        /*
        ud.create(new User("Abl", "Amine", "amine@gmail.com", "amine123"));
        ud.create(new User("Abl", "Anas", "anas@gmail.com", "anas123"));
        
        cd.create(new Categorie("eletronique"));
        cd.create(new Categorie("mecanique"));
        
        pd.create(new Produit("alternateur", 4, 1000 ,cd.findById(2) ));
        pd.create(new Produit("cable", 15, 75, cd.findById(1)));
        
        msd.create(new MouvementStock("mecanique", 20, new Date(), pd.findById(1)));
        msd.create(new MouvementStock("sss", 10, new Date(), pd.findById(2)));
        */
        
        //Modification
        /*       
        User u = ud.findById(2);
        u.setPrenom("Anas");
        u.setNom("Aboulaiche");
        ud.update(u);
        
        Categorie c = cd.findById(1);
        c.setNom("electrique");
        cd.update(c);
        
        Produit p = pd.findById(1);
        p.setQuantite(10);
        pd.update(p);
        
        MouvementStock m = msd.findById(2);
        m.setType("tirage");
        msd.update(m);
        */
        
        //Suppression
        /*       
        ud.delete(ud.findById(1));
        
        cd.delete(cd.findById(1));
        
        pd.delete(pd.findById(2));
        
        msd.delete(msd.findById(2));
        
        */
        /*
        for(User us : ud.findAll()){
            System.out.println(us.getPrenom());
        }
        
        
        //Afficher les produits de chaque catégorie
        for(Produit ps :cd.findById(2).getProduits()){
            System.out.println(ps.getNom());
        }
       
       */
         /*       
        for(Produit p : pd.findByCategorie(cd.findById(1))){
            System.out.println(p.getNom());
        }
        
        
        for(Produit p : pd.findByQuantite(10, 20)){
            System.out.println(p.getNom());
        }
        */
        List<Object[]> resultats = pd.findCategorieWithProduitCount();

        for (Object[] ligne : resultats) {
            Categorie categorie = (Categorie) ligne[0];
            Long nbEtudiants = (Long) ligne[1];
            System.out.printf("Categorie %s → %d produits%n",
                    categorie.getNom(), nbEtudiants);
        }
        
        }
}
        

