package com.mitrais.rms.controller;

import com.mitrais.rms.dao.UserDao;
import com.mitrais.rms.dao.impl.UserDaoImpl;
import com.mitrais.rms.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/users/*")
public class UserServlet extends AbstractController {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        // TODO Auto-generated method stub
        super.init();
        userDao = UserDaoImpl.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // check the user is already login
        if (isUserLogin(req, resp)) {
            String path = getTemplatePath(req.getServletPath() + req.getPathInfo());
            String action = req.getPathInfo().toLowerCase();

            switch (action) {
                case "/list":
                    listUser(req, resp, path, "");
                    break;
                case "/add":
                    addUser(req, resp, path);
                    break;
                case "/load":
                    loadUser(req, resp, path);
                    break;
                case "/update":
                    updateUser(req, resp, path);
                    break;
                case "/delete":
                    deleteUser(req, resp, path);
                    break;

                default:
                    listUser(req, resp, path, "");
                    break;
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }

    }

    /**
     * check is user login
     *
     * @param req
     * @param resp
     * @throws IOException
     */
    private boolean isUserLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            return false;
        } else {
            if (session.getAttribute("user") == null) {
                return false;
            }
        }

        return true;

    }

    /**
     * update user
     *
     * @param req
     * @param resp
     * @param path
     * @throws IOException
     */
    private void deleteUser(HttpServletRequest req, HttpServletResponse resp, String path) throws IOException {
        long userId = Long.parseLong(req.getParameter("userId"));

        User user = new User(userId, null, null);

        userDao.delete(user);

        resp.sendRedirect(req.getContextPath() + "/users/list");
    }

    /**
     * update user
     *
     * @param req
     * @param resp
     * @param path
     * @throws IOException
     */
    private void updateUser(HttpServletRequest req, HttpServletResponse resp, String path) throws IOException {
        long userId = Long.parseLong(req.getParameter("userId"));
        String userName = req.getParameter("userName");
        String password = req.getParameter("password");

        User user = new User(userId, userName, password);
        if (userDao.update(user)) {
            resp.sendRedirect(req.getContextPath() + "/users/list");
        }

    }

    /**
     * load user
     *
     * @param req
     * @param resp
     * @param path
     * @throws ServletException
     * @throws IOException
     */
    private void loadUser(HttpServletRequest req, HttpServletResponse resp, String path)
            throws ServletException, IOException {
        long userId = Long.parseLong(req.getParameter("userId"));
        Optional<User> userOpt = userDao.find(userId);

        User user = userOpt.get();
        req.setAttribute("user", user);

        RequestDispatcher requestDispatcher = req.getRequestDispatcher(path);
        requestDispatcher.forward(req, resp);
    }

    /**
     * add new user
     *
     * @param req
     * @param resp
     * @param path
     * @throws ServletException
     * @throws IOException
     */
    private void addUser(HttpServletRequest req, HttpServletResponse resp, String path)
            throws ServletException, IOException {
        String userName = req.getParameter("userName");
        String password = req.getParameter("password");
        User user = new User(userName, password);
        if (userDao.save(user)) {
            resp.sendRedirect(req.getContextPath() + "/users/list");
        }

    }

    /**
     * get all users
     *
     * @param req
     * @param resp
     * @param path
     * @param message
     * @throws ServletException
     * @throws IOException
     */
    private void listUser(HttpServletRequest req, HttpServletResponse resp, String path, String message)
            throws ServletException, IOException {
        List<User> users = userDao.findAll();
        req.setAttribute("users", users);

        RequestDispatcher requestDispatcher = req.getRequestDispatcher(path);
        requestDispatcher.forward(req, resp);
    }
}
