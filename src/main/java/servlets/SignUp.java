package servlets;

import lombok.extern.java.Log;
import models.Person;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

import static servlets.ServletConst.ERROR;
import static servlets.ServletConst.PERSON;

@Log
@WebServlet("/SignUp")
public class SignUp extends ServletWrapper {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        log.info(() -> " doGet");
        req.getRequestDispatcher("/auth/signUp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        log.info(() -> "Registration");
        HttpSession session = req.getSession();

        String email = req.getParameter("email");
        if (personDao.getByEmail(email).isPresent()) {
            req.setAttribute(ERROR, "errEmail");
            req.getRequestDispatcher("/auth/signUp.jsp").forward(req, resp);
        }

        personDao.create(Person.builder()
                .firstName(req.getParameter("firstName"))
                .lastName(req.getParameter("lastName"))
                .email(req.getParameter("email"))
                .password(req.getParameter("password"))
                .build());

        Optional<Person> person = personDao.getByEmail(email);
        if (person.isPresent()){
            session.setAttribute(PERSON, person.get());
//            session.setAttribute(, person.get());

            resp.sendRedirect("/Profile/" + person.get().getId());
        } else
            req.getRequestDispatcher("/auth/error.jsp").forward(req, resp);

    }
}
