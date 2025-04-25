/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entities.Categorie;
import entities.Produit;
import entities.Produit;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author AMINE
 */
public class ProduitDao extends AbstractDao<Produit> {

    public ProduitDao() {
        super(Produit.class);
    }

    public List<Produit> findByQuantite(int q1, int q2) {
        Session session = null;
        Transaction tx = null;
        List<Produit> produits = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            produits = session.getNamedQuery("findByQuantite").setParameter("q1", q1).setParameter("q2", q2).list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return produits;
    }

    public List<Produit> findByCategorie(Categorie c) {
        Session session = null;
        Transaction tx = null;
        List<Produit> produits = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            produits = session.getNamedQuery("findByCategorie").setParameter("id", c.getId()).list();
            tx.commit();
        } catch (HibernateException ex) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return produits;
    }
    
     public List<Object[]> findCategorieWithProduitCount() {
        Session session = null;
        Transaction tx = null;
        List<Object[]> stats = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            stats = session.getNamedQuery("findCategorieWithProduitCount").list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) tx.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        return stats;
    }
    

}
