package com.betaplan.taulant.test2.controllers;

import com.betaplan.taulant.test2.models.Course;
import com.betaplan.taulant.test2.models.LoginUser;
import com.betaplan.taulant.test2.models.User;
import com.betaplan.taulant.test2.services.CourseService;
import com.betaplan.taulant.test2.services.UserService;
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
    private CourseService courseService;

    @GetMapping("/")
    public String index(@ModelAttribute("newUser")User newUser, @ModelAttribute("newLogin") User newLogin, Model model, HttpSession session){
        Long userId = (Long) session.getAttribute("userId");

        if (userId != null){
            return "redirect:/classes";
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
        return "redirect:/classes";
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session){
        User user = userService.login(newLogin, result);
        if (result.hasErrors()){
            model.addAttribute("newUser", new User());
            return "index";
        }

        session.setAttribute("userId", user.getId());
        return "redirect:/classes";
    }

    @RequestMapping("/classes")
    public String dashboard(HttpSession session, Model model){
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null){
            return "redirect:/";
        }




        User loggedInUser = userService.findOneUser(userId);
        model.addAttribute("user", loggedInUser);
        model.addAttribute("courses", courseService.findAll());
        return "dashboard";
    }

    @RequestMapping("logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/classes/new")
    public String createCourse(@ModelAttribute("course") Course course, HttpSession session){
        Long userID = (Long) session.getAttribute("userId");
        if (userID == null){
            return "redirect:/";
        }

        return "newCourse";
    }

    @PostMapping("/course/new")
    public String newCourse(@Valid @ModelAttribute("course") Course course,BindingResult result, HttpSession session){
        if (session.getAttribute("userId") == null){
            return "redirect:/";
        }
        if (result.hasErrors()){
            return "newCourse";
        } else {
           User user = userService.findOneUser((Long) session.getAttribute("userId"));
           course.setCreator(user);
           courseService.createCourse(course);
            return "redirect:/classes";
        }
    }

    @GetMapping("/classes/{id}")
    public String courseDetails(@PathVariable("id") Long id, Model model, HttpSession session){
        Long userID = (Long) session.getAttribute("userId");
        if (userID == null){
            return "redirect:/";
        }

        Course course = courseService.findCourseById(id);

        model.addAttribute("course", course);
        model.addAttribute("user", userService.findOneUser((Long) session.getAttribute("userId")));
        return "details";
    }

    @GetMapping("/classes/{id}/edit")
    public String editCourse(@PathVariable("id") Long id, Model model, HttpSession session){
        Long userID = (Long) session.getAttribute("userId");
        if (userID == null){
            return "redirect:/";
        }

        Course editCourse = courseService.findCourseById(id);
        model.addAttribute("editCourse", editCourse);
        return "edit";
    }

    @PutMapping("/classes/{id}/update")
    public String updateCourse(@Valid @ModelAttribute("editCourse") Course editCourse, BindingResult result, Model model, @PathVariable("id") Long id, HttpSession session){
        if (result.hasErrors()){
            User user = userService.findOneUser((Long) session.getAttribute("userId"));
            model.addAttribute("user", user);
            return "edit";
        } else {
            User user = userService.findOneUser((Long) session.getAttribute("userId"));
            editCourse.setCreator(user);
            courseService.updateCourse(editCourse);
            return "redirect:/classes";
        }
    }

    @RequestMapping("/classes/delete/{id}")
    public String deleteCourse(@PathVariable("id") Long id, HttpSession session){
        if (session.getAttribute("userId") == null){
            return "redirect:/";
        }

        Course course = courseService.findCourseById(id);
        courseService.deleteCourse(course);
        return "redirect:/classes";
    }

}
