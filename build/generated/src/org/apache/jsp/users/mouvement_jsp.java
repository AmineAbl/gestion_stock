package org.apache.jsp.users;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import services.MouvementStockService;
import services.ProduitService;
import java.util.List;
import entities.MouvementStock;
import entities.Produit;

public final class mouvement_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"fr\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Mouvement de Stock</title>\n");
      out.write("    <link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap\" rel=\"stylesheet\">\n");
      out.write("    <style>\n");
      out.write("        /* Style général pour la page */\n");
      out.write("        body {\n");
      out.write("            font-family: 'Poppins', sans-serif;\n");
      out.write("            margin: 0;\n");
      out.write("            padding: 0;\n");
      out.write("            background-color: #f4f4f9;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .sidebar {\n");
      out.write("            width: 250px;\n");
      out.write("            background-color: #2c3e50;\n");
      out.write("            position: fixed;\n");
      out.write("            height: 100%;\n");
      out.write("            color: white;\n");
      out.write("            padding: 30px 0;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .sidebar ul {\n");
      out.write("            list-style: none;\n");
      out.write("            padding: 0;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .sidebar ul li {\n");
      out.write("            padding: 15px;\n");
      out.write("            text-align: center;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .sidebar ul li a {\n");
      out.write("            color: white;\n");
      out.write("            text-decoration: none;\n");
      out.write("            display: block;\n");
      out.write("            font-weight: 600;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .sidebar ul li a:hover {\n");
      out.write("            background-color: #34495e;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .main-content {\n");
      out.write("            margin-left: 250px;\n");
      out.write("            padding: 20px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .main-content fieldset {\n");
      out.write("            background-color: white;\n");
      out.write("            padding: 20px;\n");
      out.write("            border: 1px solid #ccc;\n");
      out.write("            border-radius: 10px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .main-content legend {\n");
      out.write("            font-size: 20px;\n");
      out.write("            font-weight: 600;\n");
      out.write("            color: #333;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .form-group {\n");
      out.write("            margin-bottom: 15px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        label {\n");
      out.write("            font-weight: bold;\n");
      out.write("            color: #555;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        input[type=\"number\"], select {\n");
      out.write("            width: 100%;\n");
      out.write("            padding: 10px;\n");
      out.write("            font-size: 16px;\n");
      out.write("            border-radius: 5px;\n");
      out.write("            border: 1px solid #ddd;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        button {\n");
      out.write("            background-color: #2c3e50;\n");
      out.write("            color: white;\n");
      out.write("            padding: 10px 15px;\n");
      out.write("            border: none;\n");
      out.write("            border-radius: 5px;\n");
      out.write("            font-size: 16px;\n");
      out.write("            cursor: pointer;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        button:hover {\n");
      out.write("            background-color: #34495e;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        table {\n");
      out.write("            width: 100%;\n");
      out.write("            margin-top: 20px;\n");
      out.write("            border-collapse: collapse;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        table, th, td {\n");
      out.write("            border: 1px solid #ddd;\n");
      out.write("            text-align: left;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        th, td {\n");
      out.write("            padding: 12px;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        th {\n");
      out.write("            background-color: #f2f2f2;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        .empty-message {\n");
      out.write("            text-align: center;\n");
      out.write("            font-size: 18px;\n");
      out.write("            color: #ccc;\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        /* Style pour les éléments de la sidebar */\n");
      out.write("        .sidebar ul li.active a {\n");
      out.write("            background-color: #16a085;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <!-- Sidebar -->\n");
      out.write("    <div class=\"sidebar\">\n");
      out.write("        <ul>\n");
      out.write("            <li><a href=\"#\">Dashboard</a></li>\n");
      out.write("            <li><a href=\"#\">Mouvements de Stock</a></li>\n");
      out.write("            <li><a href=\"#\">Produits</a></li>\n");
      out.write("            <li><a href=\"#\">Déconnexion</a></li>\n");
      out.write("        </ul>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <!-- Main Content -->\n");
      out.write("    <div class=\"main-content\">\n");
      out.write("        <fieldset>\n");
      out.write("            <legend>Mouvement de Stock</legend>\n");
      out.write("\n");
      out.write("            <!-- Formulaire d'ajout de mouvement de stock -->\n");
      out.write("            <form action=\"ajouterMouvementStock\" method=\"POST\">\n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"produit\">Produit</label>\n");
      out.write("                    <select id=\"produit\" name=\"produit\" required>\n");
      out.write("                        ");
  
                            // Récupération de la liste des produits
                            List<Produit> produits = (List<Produit>) request.getAttribute("produits");
                            if (produits != null && !produits.isEmpty()) {
                                for (Produit produit : produits) {
                        
      out.write("\n");
      out.write("                            <option value=\"");
      out.print( produit.getId() );
      out.write('"');
      out.write('>');
      out.print( produit.getNom() );
      out.write("</option>\n");
      out.write("                        ");
 
                                }
                            } else {
                        
      out.write("\n");
      out.write("                            <option>Aucun produit disponible</option>\n");
      out.write("                        ");
 
                            }
                        
      out.write("\n");
      out.write("                    </select>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"quantite\">Quantité</label>\n");
      out.write("                    <input type=\"number\" id=\"quantite\" name=\"quantite\" required>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"form-group\">\n");
      out.write("                    <label for=\"type\">Type</label>\n");
      out.write("                    <select id=\"type\" name=\"type\" required>\n");
      out.write("                        <option value=\"ajout\">Ajout</option>\n");
      out.write("                        <option value=\"retrait\">Retrait</option>\n");
      out.write("                    </select>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <button type=\"submit\">Ajouter Mouvement</button>\n");
      out.write("            </form>\n");
      out.write("\n");
      out.write("            <!-- Table des mouvements de stock -->\n");
      out.write("            <table>\n");
      out.write("                <thead>\n");
      out.write("                    <tr>\n");
      out.write("                        <th>Date</th>\n");
      out.write("                        <th>Quantité</th>\n");
      out.write("                        <th>Type</th>\n");
      out.write("                        <th>Produit</th>\n");
      out.write("                    </tr>\n");
      out.write("                </thead>\n");
      out.write("                <tbody>\n");
      out.write("                    ");
  
                        MouvementStockService mss = new MouvementStockService();
                        List<MouvementStock> mouvements = mss.findAll();
                        if (mouvements.isEmpty()) {
                    
      out.write("\n");
      out.write("                        <tr>\n");
      out.write("                            <td colspan=\"4\" class=\"empty-message\">Aucun mouvement de stock disponible.</td>\n");
      out.write("                        </tr>\n");
      out.write("                    ");
 
                        } else {
                            for (MouvementStock mouvement : mouvements) {
                    
      out.write("\n");
      out.write("                        <tr>\n");
      out.write("                            <td>");
      out.print( mouvement.getDate() );
      out.write("</td>\n");
      out.write("                            <td>");
      out.print( mouvement.getQuantite() );
      out.write("</td>\n");
      out.write("                            <td>");
      out.print( mouvement.getType() );
      out.write("</td>\n");
      out.write("                            <td>");
      out.print( mouvement.getProduit().getNom() );
      out.write("</td>\n");
      out.write("                        </tr>\n");
      out.write("                    ");
 
                            }
                        }
                    
      out.write("\n");
      out.write("                </tbody>\n");
      out.write("            </table>\n");
      out.write("        </fieldset>\n");
      out.write("    </div>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
