package org.apache.jsp.users;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import entities.User;
import services.UserService;

public final class user_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <fieldset>\n");
      out.write("            <legend>Formulaire d'utilisateur</legend>\n");
      out.write("            <form method=\"POST\" action=\"../UserController\">\n");
      out.write("                <input type=\"hidden\" name=\"id\" value=\"");
      out.print( request.getParameter("id") != null ? request.getParameter("id") : "" );
      out.write("\" />\n");
      out.write("                <table border=\"0\">\n");
      out.write("                    <tr>\n");
      out.write("                    <td>Nom :</td>\n");
      out.write("                    <td><input type=\"text\" name=\"nom\" value=\"");
      out.print( request.getParameter("nom") != null ? request.getParameter("nom") : "" );
      out.write("\" /></td>\n");
      out.write("                    </tr>\n");
      out.write("                    \n");
      out.write("                    <tr>\n");
      out.write("                    <td>Prenom :</td>\n");
      out.write("                    <td><input type=\"text\" name=\"prenom\" value=\"");
      out.print( request.getParameter("prenom") != null ? request.getParameter("prenom") : "" );
      out.write("\" /></td>  \n");
      out.write("                    </tr>\n");
      out.write("                    \n");
      out.write("                    <tr>\n");
      out.write("                    <td>Email :</td>\n");
      out.write("                    <td><input type=\"text\" name=\"email\" value=\"");
      out.print( request.getParameter("email") != null ? request.getParameter("email") : "" );
      out.write("\" /></td>  \n");
      out.write("                    </tr>\n");
      out.write("                    \n");
      out.write("                    <tr>\n");
      out.write("                    <td>Mot de passe :</td>\n");
      out.write("                    <td><input type=\"text\" name=\"mdp\" value=\"");
      out.print( request.getParameter("mdp") != null ? request.getParameter("mdp") : "" );
      out.write("\" /></td>  \n");
      out.write("                    </tr>\n");
      out.write("                    \n");
      out.write("                    <tr>\n");
      out.write("                        <td></td>\n");
      out.write("                        <td><input type=\"submit\" value=\"Envoyer\" /></td>\n");
      out.write("                    </tr>\n");
      out.write("                </table>\n");
      out.write("            </form>\n");
      out.write("        </fieldset>\n");
      out.write("                    \n");
      out.write("        <fieldset>\n");
      out.write("            <legend>Liste des étudiants :</legend>\n");
      out.write("            <table border=\"0\">\n");
      out.write("                <thead>\n");
      out.write("                    <tr>\n");
      out.write("                        <th>ID</th>\n");
      out.write("                        <th>Nom</th>\n");
      out.write("                        <th>Prénom</th>\n");
      out.write("                        <th>Email</th>\n");
      out.write("                        <th>Supprimer</th>\n");
      out.write("                        <th>Modifier</th>\n");
      out.write("                    </tr>\n");
      out.write("                </thead>\n");
      out.write("                \n");
      out.write("                <tbody>\n");
      out.write("                    ");

                        UserService us = new UserService();
                        for(User u : us.findAll()){
                    
                    
      out.write("\n");
      out.write("                    <tr>\n");
      out.write("                        <td>  ");
      out.print( u.getId() );
      out.write("   </td>\n");
      out.write("                        <td>  ");
      out.print( u.getNom() );
      out.write("   </td>\n");
      out.write("                        <td>  ");
      out.print( u.getPrenom() );
      out.write("   </td>\n");
      out.write("                        <td>  ");
      out.print( u.getEmail() );
      out.write("   </td>\n");
      out.write("                        <td> <a href=\"../UserController?id=");
      out.print( u.getId());
      out.write("&op=delete\">Supprimer</a> </td>\n");
      out.write("                        <td> <a href=\"../UserController?id=");
      out.print( u.getId());
      out.write("&op=update\">Modifier</a> </td>\n");
      out.write("                        <td></td>\n");
      out.write("                    </tr>\n");
      out.write("                    \n");
      out.write("                    ");
 }
      out.write("\n");
      out.write("                </tbody>\n");
      out.write("                \n");
      out.write("            </table>\n");
      out.write("\n");
      out.write("        </fieldset>\n");
      out.write("    </body>\n");
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
