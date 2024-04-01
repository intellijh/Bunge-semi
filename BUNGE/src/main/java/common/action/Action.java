package common.action;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.naming.NamingException;
import java.io.IOException;
import java.sql.SQLException;


public interface Action {
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, NamingException;

}
