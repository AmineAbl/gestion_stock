package org.apache.jsp.users;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import entities.Categorie;
import services.CategorieService;
import entities.User;
import services.UserService;

public final class addProduit_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <title>Formulaire Utilisateur</title>\n");
      out.write("        <style>\n");
      out.write("            * {\n");
      out.write("                margin: 0;\n");
      out.write("                padding: 0;\n");
      out.write("                box-sizing: border-box;\n");
      out.write("                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            body {\n");
      out.write("                background-color: #f5f5f5;\n");
      out.write("                display: flex;\n");
      out.write("                justify-content: center;\n");
      out.write("                align-items: center;\n");
      out.write("                min-height: 100vh;\n");
      out.write("                padding: 20px;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            fieldset {\n");
      out.write("                border: none;\n");
      out.write("                background-color: white;\n");
      out.write("                border-radius: 10px;\n");
      out.write("                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);\n");
      out.write("                padding: 30px;\n");
      out.write("                width: 100%;\n");
      out.write("                max-width: 500px;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            legend {\n");
      out.write("                font-size: 24px;\n");
      out.write("                font-weight: 600;\n");
      out.write("                color: #333;\n");
      out.write("                padding: 0 10px;\n");
      out.write("                margin-bottom: 20px;\n");
      out.write("                position: relative;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            legend::after {\n");
      out.write("                content: '';\n");
      out.write("                display: block;\n");
      out.write("                width: 50px;\n");
      out.write("                height: 3px;\n");
      out.write("                background-color: #4a6fdc;\n");
      out.write("                margin-top: 8px;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            table {\n");
      out.write("                width: 100%;\n");
      out.write("                border-collapse: collapse;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            td {\n");
      out.write("                padding: 12px 0;\n");
      out.write("                vertical-align: top;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            td:first-child {\n");
      out.write("                width: 120px;\n");
      out.write("                font-weight: 500;\n");
      out.write("                color: #555;\n");
      out.write("                padding-top: 20px;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            input[type=\"text\"], input[type=\"password\"] {\n");
      out.write("                width: 100%;\n");
      out.write("                padding: 12px 15px;\n");
      out.write("                border: 1px solid #ddd;\n");
      out.write("                border-radius: 6px;\n");
      out.write("                font-size: 16px;\n");
      out.write("                transition: border-color 0.3s, box-shadow 0.3s;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            input[type=\"text\"]:focus, input[type=\"password\"]:focus {\n");
      out.write("                border-color: #4a6fdc;\n");
      out.write("                box-shadow: 0 0 0 3px rgba(74, 111, 220, 0.2);\n");
      out.write("                outline: none;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            input[type=\"submit\"] {\n");
      out.write("                background-color: #4a6fdc;\n");
      out.write("                color: white;\n");
      out.write("                border: none;\n");
      out.write("                border-radius: 6px;\n");
      out.write("                padding: 12px 25px;\n");
      out.write("                font-size: 16px;\n");
      out.write("                font-weight: 500;\n");
      out.write("                cursor: pointer;\n");
      out.write("                transition: background-color 0.3s;\n");
      out.write("                margin-top: 10px;\n");
      out.write("                width: 100%;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            input[type=\"submit\"]:hover {\n");
      out.write("                background-color: #3a5fc8;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            .form-group {\n");
      out.write("                margin-bottom: 15px;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            @media (max-width: 600px) {\n");
      out.write("                fieldset {\n");
      out.write("                    padding: 20px;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                td:first-child {\n");
      out.write("                    display: block;\n");
      out.write("                    width: 100%;\n");
      out.write("                    padding-top: 0;\n");
      out.write("                    padding-bottom: 5px;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                td {\n");
      out.write("                    display: block;\n");
      out.write("                    padding: 5px 0;\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            select.form-control {\n");
      out.write("                width: 100%;\n");
      out.write("                padding: 12px 15px;\n");
      out.write("                border: 1px solid #ddd;\n");
      out.write("                border-radius: 6px;\n");
      out.write("                font-size: 16px;\n");
      out.write("                transition: border-color 0.3s, box-shadow 0.3s;\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            select.form-control:focus {\n");
      out.write("                border-color: #4a6fdc;\n");
      out.write("                box-shadow: 0 0 0 3px rgba(74, 111, 220, 0.2);\n");
      out.write("                outline: none;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <fieldset>\n");
      out.write("            <legend>Formulaire du produit</legend>\n");
      out.write("            <form method=\"POST\" action=\"../ProduitController\">\n");
      out.write("                <input type=\"hidden\" name=\"id\" value=\"");
      out.print( request.getParameter("id") != null ? request.getParameter("id") : "");
      out.write("\" />\n");
      out.write("                <table>\n");
      out.write("                    <tr class=\"form-group\">\n");
      out.write("                        <td><label for=\"nom\">Nom :</label></td>\n");
      out.write("                        <td><input type=\"text\" id=\"nom\" name=\"nom\" value=\"");
      out.print( request.getParameter("nom") != null ? request.getParameter("nom") : "");
      out.write("\" placeholder=\"Entrez le nom du produit\" /></td>\n");
      out.write("                    </tr>\n");
      out.write("\n");
      out.write("                    <tr class=\"form-group\">\n");
      out.write("                        <td><label for=\"prix\">Prix :</label></td>\n");
      out.write("                        <td><input type=\"text\" id=\"prix\" name=\"prix\" value=\"");
      out.print( request.getParameter("prix") != null ? request.getParameter("prix") : "");
      out.write("\" placeholder=\"Entrez le prix du produit\" /></td>  \n");
      out.write("                    </tr>\n");
      out.write("\n");
      out.write("                    <tr class=\"form-group\">\n");
      out.write("                        <td><label for=\"quantite\">Quantité :</label></td>\n");
      out.write("                        <td><input type=\"text\" id=\"email\" name=\"quantite\" value=\"");
      out.print( request.getParameter("quantite") != null ? request.getParameter("quantite") : "");
      out.write("\" placeholder=\"Entrez la quantite du produit\" /></td>  \n");
      out.write("                    </tr>\n");
      out.write("\n");
      out.write("                    <tr class=\"form-group\">\n");
      out.write("                        <td><label for=\"categorie\">Catégorie :</label></td>\n");
      out.write("                        <td>\n");
      out.write("                            <select id=\"categorie\" name=\"categorie\" class=\"form-control\">\n");
      out.write("                                ");

                                    CategorieService cs = new CategorieService();
                                    java.util.List<Categorie> categories = cs.findAll();
                                    String selectedCategorie = request.getParameter("categorie");
                                    if (categories != null && !categories.isEmpty()) {
                                        for (Categorie c : categories) {
                                            String selected = (selectedCategorie != null && selectedCategorie.equals(String.valueOf(c.getId()))) ? "selected" : "";
                                
      out.write("\n");
      out.write("                                <option value=\"");
      out.print( c.getId());
      out.write('"');
      out.write(' ');
      out.print( selected);
      out.write('>');
      out.print( c.getNom());
      out.write("</option>\n");
      out.write("                                ");

                                        }
                                    }
                                
      out.write("\n");
      out.write("                            </select>\n");
      out.write("\n");
      out.write("                        </td>  \n");
      out.write("                    </tr>\n");
      out.write("\n");
      out.write("                    <tr>\n");
      out.write("                        <td></td>\n");
      out.write("                        <td><input type=\"submit\" value=\"Enregistrer\" /></td>\n");
      out.write("                    </tr>\n");
      out.write("\n");
      out.write("                </table>\n");
      out.write("            </form>\n");
      out.write("        </fieldset>\n");
      out.write("    </body>\n");
      out.write("</html>");
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
