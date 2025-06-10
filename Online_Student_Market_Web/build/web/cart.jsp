<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="stylecart.css">
</head>
<body>
    <div class="row">
        <div class="col-md-3"></div>
    <div class="col-md-6">
        <h1>Shopping Cart</h1>
    <div class="cart">
        <div class="item">Used Textbook – Introduction to Economics (x1) <span>$25</span></div>
        <div class="item">Scientific Calculator (x2) <span>$30</span></div>
        <div class="item">Laptop Backpack (x1) <span>$40</span></div>
    </div>
         <div class="summary">
        <h3>Order Summary</h3>
        <p>Subtotal: $95</p>
        <p>Shipping: Free</p>
        <p>Total: $95</p>
        <form action="checkout" method="post">
            <button type="submit">Proceed to Checkout</button>
        </form>
    </div>
    </div>
    </div>
   
</body>
</html>
