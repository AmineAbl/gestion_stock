/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.ProduitDao;
import entities.Categorie;
import entities.Produit;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author AMINE
 */
public class ProduitService implements IService<Produit> {

    private final ProduitDao pd;

    public ProduitService() {
        this.pd = new ProduitDao();
    }

    @Override
    public boolean create(Produit o) {
        return pd.create(o);
    }

    @Override
    public boolean update(Produit o) {
        return pd.update(o);
    }

    @Override
    public boolean delete(Produit o) {
        return pd.delete(o);
    }

    @Override
    public List<Produit> findAll() {
        return pd.findAll();
    }

    @Override
    public Produit findById(int id) {
        return pd.findById(id);
    }
     public List<Produit> findByQuantite(int q1, int q2) {
        return pd.findByQuantite(q1, q2);
    }
    
   public List<Produit> findByCategorie(Categorie c) {
        return pd.findByCategorie(c);
    }
   
   public List<Object[]> findCategorieWithProduitCount() {
    return pd.findCategorieWithProduitCount();
    }

}
