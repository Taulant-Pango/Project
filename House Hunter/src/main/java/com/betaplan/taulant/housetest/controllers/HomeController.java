package com.betaplan.taulant.housetest.controllers;

import com.betaplan.taulant.housetest.models.Cart;
import com.betaplan.taulant.housetest.models.LoginUser;
import com.betaplan.taulant.housetest.models.User;
import com.betaplan.taulant.housetest.services.CartService;
import com.betaplan.taulant.housetest.services.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
public class HomeController {
    @Autowired
    private UserService userService;
    @Autowired
    private CartService cartService;

    @GetMapping("/")
    public String index(@ModelAttribute("newUser") User newUser, @ModelAttribute("newLogin") User newLogin, Model model, HttpSession session){
        Long userId = (Long) session.getAttribute("userId");

        if (userId != null){
            return "redirect:/home";
        }
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "index";
    }
    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session){
        userService.register(newUser, result);
        if (result.hasErrors()){
            model.addAttribute("newLogin", new LoginUser());
            return "index";
        }
        session.setAttribute("userId", newUser.getId());
        return "redirect:/home";
    }
    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session){
        User user = userService.login(newLogin, result);
        if (result.hasErrors()){
            model.addAttribute("newUser", new User());
            return "index";
        }
        session.setAttribute("userId", user.getId());
        return "redirect:/home";
    }
    @RequestMapping("/home")
    public String dashboard(HttpSession session, Model model){
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null){
            return "redirect:/";
        }
        User loggedInUser = userService.findOneUser(userId);
        model.addAttribute("user", loggedInUser);
        model.addAttribute("carts", cartService.allCarts());
        return "dashboard";
    }
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }
    @GetMapping("/listings/new")
    public String newListing(@ModelAttribute("carts")Cart cart, Model model, HttpSession session){
        User user = userService.findOneUser((Long)session.getAttribute("userId"));
        model.addAttribute("user", user);
        return "new";
    }
    @PostMapping("/new")
    public String createListing(@Valid @ModelAttribute("carts") Cart cart, BindingResult result, Model model, HttpSession session){
        if (result.hasErrors()){
            User user = userService.findOneUser((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            return "new";
        } else {
            User user = userService.findOneUser((Long) session.getAttribute("userId"));
            cart.setUser(user);
            cartService.create(cart);
            return "redirect:/home";
        }
    }
    @GetMapping("/listings/{id}")
    public String listingDetails(@PathVariable("id") Long id, Model model, HttpSession session){
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null){
            return "redirect:/";
        }

        Cart cart = cartService.findCart(id);

        model.addAttribute("cart", cart);
        model.addAttribute("user", userService.findOneUser((Long) session.getAttribute("userId")));
        return "details";
    }
    @GetMapping("/listings/{id}/edit")
    public String editListings(@PathVariable("id") Long id, HttpSession session, Model model){
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null){
            return "redirect:/";
        }

        Cart editCart = cartService.findCart(id);
        model.addAttribute("editCart", editCart);
        return "edit";
    }
    @PutMapping("/listings/{id}/update")
    public String updateListing(@Valid @ModelAttribute("editCart") Cart editCart, BindingResult result, Model model, @PathVariable("id") Long id,HttpSession session){
        if (result.hasErrors()){
            User user = userService.findOneUser((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            return "edit";
        } else {
            User user = userService.findOneUser((Long) session.getAttribute("userId"));
            editCart.setUser(user);
            cartService.update(editCart);
            return "redirect:/home";
        }
    }
    @RequestMapping("/listings/delete/{id}")
    public String deleteListing(@PathVariable("id") Long id, HttpSession session){
        if (session.getAttribute("userId") == null){
            return "redirect:/";
        }

        Cart cart = cartService.findCart(id);
        cartService.deleteCart(cart);
        return "redirect:/home";
    }
}
