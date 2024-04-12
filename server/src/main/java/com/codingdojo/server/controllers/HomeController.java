package com.codingdojo.server.controllers;

import com.codingdojo.server.models.*;
import com.codingdojo.server.repositories.OrderRepository;
import com.codingdojo.server.services.CartService;
import com.codingdojo.server.services.OrderService;
import com.codingdojo.server.services.ProductService;
import com.codingdojo.server.services.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class HomeController {
    @Autowired
    private UserService users;
    @Autowired
    private ProductService products;
    @Autowired
    private CartService carts;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderService orderService;
    @Autowired
    private JavaMailSender emailSender;

    @GetMapping("/")
    public String index(Model model, @ModelAttribute("newUser") User newUser,
                        @ModelAttribute("newLogin") User newLogin, HttpSession session) {

        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "index";
    }
    @GetMapping("/login")
    public String login(Model model, @ModelAttribute("newUser") User newUser,
                        @ModelAttribute("newLogin") User newLogin) {
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "login";
    }
    @GetMapping("/register")
    public String register(Model model, @ModelAttribute("newUser") User newUser,
                        @ModelAttribute("newLogin") User newLogin) {
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "register";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {

        User user = users.register(newUser, result);
        if (result.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "index";
        }
        session.setAttribute("userId", user.getId());
        return "redirect:/home";
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {

        User user = users.login(newLogin, result);
        if (result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "index";
        }
        session.setAttribute("userId", user.getId());
        return "redirect:/home";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/home")
    public String home(Model model, HttpSession session, @RequestParam(name = "search", required = false) String search) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/";
        }

        List<Product> productList;
        if (search != null && !search.isEmpty()) {
            productList = products.searchProducts(search);
        } else {
            productList = products.getAll();
        }

        model.addAttribute("user", users.findById((Long) session.getAttribute("userId")));
        model.addAttribute("products", productList);
        model.addAttribute("searchTerm", search); // Add the search term to the model if you want to display it in the input field after searching
        return "home";
    }

    @GetMapping("/addPage")
    public String addPage(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        model.addAttribute("product", new Product());
        return "addPage";
    }


    @PostMapping("/products")
    public String createProduct(@Valid @ModelAttribute("product") Product product,
                                BindingResult result,
                                @RequestParam("image") String image,
                                HttpSession session) {
        if (!isAdmin(session)) {
            Long userId = (Long) session.getAttribute("userId");
            if (userId == null) {
                return "redirect:/login";
            }
            User user = users.findById(userId);
            if (user != null) {
                product.setUser(user);
            } else {
                return "redirect:/login";
            }
        }
        product.setImage(image);
        try {
            products.createProduct(product);
        } catch (IllegalArgumentException e) {
            result.rejectValue("name", "error.product", "An error occurred while creating the product.");
            return "addPage";
        }
        return "redirect:/admin";
    }


    @GetMapping("/products/{id}")
    public String productDetail(Model model, @PathVariable("id") Long id, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/home";
        }
        Product product = products.findById(id);
        List<Review> reviews = products.getReviewsForProduct(id);
        model.addAttribute("products", product);
        model.addAttribute("reviews", reviews);
        model.addAttribute("user", users.findById((Long) session.getAttribute("userId")));
        return "product";
    }

    @GetMapping("/products/{id}/edit")
    public String getEditProductPage(@PathVariable("id") Long id, Model model, HttpSession session) {
        if (!isAdmin(session) && session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Product product = products.findById(id);
        if (product == null) {
            return "redirect:/admin";
        }
        model.addAttribute("productEdit", product);
        return "editProduct";
    }


    @PutMapping("/products/{id}/update")
    public String editProduct(@Valid @ModelAttribute("productEdit") Product productEdit, BindingResult result, Model model, @PathVariable("id") Long id, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        if (result.hasErrors()) {
            model.addAttribute("productEdit", productEdit);
            return "editProduct";
        } else {
            try {
                products.updateProduct(productEdit);
            } catch (IllegalArgumentException e) {
                result.rejectValue("name", "error.product", "A product with this name already exists.");
                return "editProduct";
            }
            return "redirect:/admin";
        }
    }


    private boolean isAdmin(HttpSession session) {
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        return Boolean.TRUE.equals(isAdmin);
    }

    @DeleteMapping("/products/{id}/delete")
    public String deleteProduct(@PathVariable("id") Long id, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/";
        }
        products.deleteProduct(id);
        return "redirect:/admin";
    }

    @PostMapping("/products/{productId}/review")
    public String reviewProduct(@PathVariable("productId") Long productId, @RequestParam("review") String reviewText, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        Optional<Review> existingReview = products.findReviewsByUserAndProduct(userId, productId);
        Review review;
        if (existingReview.isPresent()) {
            review = existingReview.get();
        } else {
            review = new Review();
            review.setUser(users.findById(userId));
            review.setProduct(products.findById(productId));
        }

        // Set the review text
        review.setReview(reviewText);

        // Save the review
        products.addReview(review);

        return "redirect:/products/" + productId;
    }


    @GetMapping("/checkout")
    public String showCheckoutForm(HttpSession session, Model model) {
        model.addAttribute("shippingAddress", new ShippingAddress());
        return "checkout";
    }

    @PostMapping("/processDeliveryAddress")
    public String processDeliveryAddress(@Valid @ModelAttribute("shippingAddress") ShippingAddress shippingAddress,
                                         BindingResult result, HttpSession session, RedirectAttributes redirectAttrs) {
        if (result.hasErrors()) {
            return "checkout";
        }

        session.setAttribute("shippingAddress", shippingAddress);

        return "redirect:/payment";
    }

    @GetMapping("/payment")
    public String showPaymentForm(HttpSession session, Model model) {
        if (session.getAttribute("shippingAddress") == null) {
            return "redirect:/checkout";
        }

        return "payment";
    }

    @PostMapping("/processPayment")
    public String processPayment(@RequestParam String paymentMethod, HttpSession session, RedirectAttributes redirectAttrs) {
        if (paymentMethod == null || paymentMethod.isEmpty()) {
            redirectAttrs.addFlashAttribute("error", "You must select a payment method.");
            return "redirect:/payment";
        }

        session.setAttribute("paymentMethod", paymentMethod);

        return "redirect:/confirmOrder";
    }

    @GetMapping("/confirmOrder")
    public String showOrderConfirmation(HttpSession session, Model model) {
        ShippingAddress shippingAddress = (ShippingAddress) session.getAttribute("shippingAddress");
        String paymentMethod = (String) session.getAttribute("paymentMethod");

        if (shippingAddress == null || paymentMethod == null) {
            return "redirect:/checkout";
        }
        BigDecimal totalAmount = carts.getTotalAmount();
        Long userId = (Long) session.getAttribute("userId");
        List<CartItem> cartItems = carts.getCartItems();
        User user = users.findById(userId);
        model.addAttribute("shippingAddress", shippingAddress);
        model.addAttribute("paymentMethod", paymentMethod);
        model.addAttribute("user", user);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalAmount", totalAmount);
        return "confirmOrder";
    }

    @PostMapping("/placeOrder")
    public String placeOrder(HttpSession session, RedirectAttributes redirectAttrs, Model model) {
        ShippingAddress shippingAddress = (ShippingAddress) session.getAttribute("shippingAddress");
        String paymentMethod = (String) session.getAttribute("paymentMethod");

        if (shippingAddress == null || paymentMethod == null) {
            return "redirect:/checkout";
        }

        Order order = new Order();
        order.setUser(users.findById((Long) session.getAttribute("userId")));
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setPaid(false);
        order.setDelivered(false);
        order.setTotalPrice(carts.getTotalAmount().doubleValue());
        orderRepository.save(order);

        session.removeAttribute("cart");
        session.removeAttribute("shippingAddress");
        session.removeAttribute("paymentMethod");

        redirectAttrs.addFlashAttribute("successMessage", "Order placed successfully!");
        model.addAttribute("orderId", order.getId());
        return "redirect:/orderSuccess";
    }

    @GetMapping("/cart")
    public String showCart(Model model) {
        model.addAttribute("cartProducts", carts.getCartItems());
        model.addAttribute("totalAmount", carts.getTotalAmount());
        return "cart";
    }

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("productId") Long productId, Model model, HttpSession session) {
        Product product = products.findById(productId);
        CartItem existingItem = carts.getCartItems().stream()
                .filter(item -> item.getId().equals(productId))
                .findFirst()
                .orElse(null);

        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + 1);
        } else {
            BigDecimal price = BigDecimal.valueOf(product.getPrice());
            CartItem newItem = new CartItem(product.getId(), product.getName(), product.getImage(), 1, price, price);
            carts.addToCart(newItem);
        }

        model.addAttribute("cartSize", carts.getCartItems().size());

        return "redirect:/cart";
    }

    @PostMapping("/cart/remove")
    public String removeFromCart(@RequestParam("productId") Long productId, HttpSession session) {
        carts.removeFromCart(productId);
        return "redirect:/cart";
    }

    @PostMapping("/cart/update")
    public String updateCartItem(@RequestParam("productId") Long productId, @RequestParam("quantity") int quantity, HttpSession session) {
        carts.updateCartItemQuantity(productId, quantity);
        return "redirect:/cart";
    }

    @PostMapping("/captureOrder")
    public ResponseEntity<?> captureOrder(@RequestBody Map<String, Object> payload, HttpSession session) {
        try {
            String orderIdStr = (String) payload.get("orderID");
            Long orderId = Long.parseLong(orderIdStr);

            Optional<Order> orderOptional = orderService.findById(orderId);
            if (!orderOptional.isPresent()) {
                return ResponseEntity.badRequest().body("Order not found");
            }

            Order order = orderOptional.get();
            order.setPaid(true);
            order.setPaidAt(new Date());
            order.setDelivered(false);

            orderService.saveOrder(order);

            return ResponseEntity.ok("Order payment captured successfully");
        } catch (NumberFormatException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid order ID format");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred processing your order.");
        }
    }

    @GetMapping("/orderSuccess")
    public String orderSuccess() {
        return "orderSuccess";
    }

    @GetMapping("/orders")
    public String showUserOrders(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        List<Order> orders = orderService.findOrdersByUserId(userId);
        model.addAttribute("orders", orders);
        return "orders";
    }

    @PostMapping("/admin/login")
    public String adminLogin(@RequestParam("email") String email, @RequestParam("password") String password, HttpSession session) {
        if ("admin@example.com".equals(email) && "12345678".equals(password)) {
            session.setAttribute("isAdmin", true);
            return "redirect:/admin";
        }
        return "redirect:/admin/login?error";
    }

    @GetMapping("/admin")
    public String adminDashboard(Model model, HttpSession session) {
        if (Boolean.TRUE.equals(session.getAttribute("isAdmin"))) {
            model.addAttribute("users", users.findAll());
            model.addAttribute("orders", orderRepository.findAll());
            List<Order> orders = orderService.findAllOrders();
            List<Product> allProducts = products.getAll();

            model.addAttribute("products", allProducts);
            model.addAttribute("orders", orders);
            return "adminDashboard";
        }
        return "redirect:/";
    }

    @GetMapping("/admin/login")
    public String adminLoginPage() {
        return "adminLogin";
    }
    @PostMapping("/contact")
    public String bookTable(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("subject") String subject,
            @RequestParam("message") String message

    ) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setFrom("your-email@gmail.com"); // Replace with your email
        mailMessage.setTo("taulantpango@gmail.com");
        mailMessage.setSubject("New message from " + name);

        String emailBody = "You have received a new message from the user " + name + ".\n\n";
        emailBody += "Here is the message information:\n";
        emailBody += "Name: " + name + "\n";
        emailBody += "Email: " + email + "\n";
        emailBody += "Subject: " + subject + "\n";
        emailBody += "Message: " + message + "\n\n";
        mailMessage.setText(emailBody);

        emailSender.send(mailMessage);
        return "redirect:/";
    }

}