<%-- 
    Document   : product
    Created on : Jun 14, 2025, 10:04:47 PM
    Author     : Haichann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sản phẩm</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
            />

        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/resources/css/main.css"
            />

        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/resources/css/Haichan/productDetail.css"
            />

    </head>
    <body>
        <!-- Header -->
        <c:import url="/WEB-INF/jsp/common/header.jsp"/>
        <!-- End header -->

        <!-- content -->
        <main class="container my-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/productList?cid=${product.category_id}">${categoryName}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${product.product_name}</li>
                </ol>
            </nav>

            <div class="row product-container">
                <div class="col-md-6">
                    <div class="product-image-container">
                        <img src="${product.image_url}" class="img-fluid product-image" alt="${product.product_name}">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="product-details">
                        <h1 class="product-title">${product.product_name}</h1>
                        <p class="product-price fw-bold"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"/> ₫</p>
                        <p class="product-description">${product.description}</p>

                        <div class="product-meta">
                            <p><strong>Stock:</strong> ${product.stock_quantity} available</p>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/cart?pid=${product.product_id}" method="post" class="mt-4">
                            <input type="hidden" name="productId" value="${product.product_id}">
                            <div class="d-flex">
                                <input type="number" name="quantity" class="form-control quantity-input" value="1" min="1" max="${product.stock_quantity}">
                                
                                <button type="submit" class="btn btn-primary btn-add-to-cart ms-2">Add to Cart</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <!-- content -->

        <!-- Related Products Section -->
        <section class="container my-5">
            <h2 class="section-title mb-4">Sản phẩm cùng danh mục</h2>
            <div class="products-slider-container">
                <button class="slider-nav prev-btn" onclick="scrollProducts('related', -1)">
                    <i class="bi bi-chevron-left"></i>
                </button>
                <div class="products-slider" id="related-slider">
                    <c:forEach var="relatedProduct" items="${relatedProducts}">
                        <div class="product-card-wrapper">
                            <div class="card product-card h-100">
                                <img src="${relatedProduct.image_url}" class="card-img-top" alt="${relatedProduct.product_name}" style="height: 200px; object-fit: cover;">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${relatedProduct.product_name}</h5>
                                    <p class="card-text text-primary fw-bold">
                                        <fmt:formatNumber value="${relatedProduct.price}" type="number" pattern="#,##0"/> ₫
                                    </p>
                                    <a href="${pageContext.request.contextPath}/product?pid=${relatedProduct.product_id}" class="btn btn-outline-primary mt-auto">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button class="slider-nav next-btn" onclick="scrollProducts('related', 1)">
                    <i class="bi bi-chevron-right"></i>
                </button>
            </div>
        </section>

        <!-- Recently Viewed Products Section -->
        <section class="container my-5">
            <h2 class="section-title mb-4">Sản phẩm đã xem gần đây</h2>
            <div class="products-slider-container">
                <button class="slider-nav prev-btn" onclick="scrollProducts('recent', -1)">
                    <i class="bi bi-chevron-left"></i>
                </button>
                <div class="products-slider" id="recent-slider">
                    <c:forEach var="recentProduct" items="${recentlyViewedProducts}">
                        <div class="product-card-wrapper">
                            <div class="card product-card h-100">
                                <img src="${recentProduct.image_url}" class="card-img-top" alt="${recentProduct.product_name}" style="height: 200px; object-fit: cover;">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${recentProduct.product_name}</h5>
                                    <p class="card-text text-primary fw-bold">
                                        <fmt:formatNumber value="${recentProduct.price}" type="number" pattern="#,##0"/> ₫
                                    </p>
                                    <a href="${pageContext.request.contextPath}/product?pid=${recentProduct.product_id}" class="btn btn-outline-primary mt-auto">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button class="slider-nav next-btn" onclick="scrollProducts('recent', 1)">
                    <i class="bi bi-chevron-right"></i>
                </button>
            </div>
        </section>

        <!-- Footer -->
        <c:import url="/WEB-INF/jsp/common/footer.jsp"/>
        <!--Footer styles-->
        
        <script>
            function scrollProducts(sliderType, direction) {
                const slider = document.getElementById(sliderType + '-slider');
                const cardWidth = 280; // Width of each product card + margin
                const visibleCards = 4; // Number of cards visible at once
                const scrollAmount = cardWidth * visibleCards * direction;
                
                slider.scrollBy({
                    left: scrollAmount,
                    behavior: 'smooth'
                });
            }
            
            // Auto-hide navigation buttons when at the beginning/end
            function updateNavButtons() {
                const sliders = ['related', 'recent'];
                
                sliders.forEach(type => {
                    const slider = document.getElementById(type + '-slider');
                    if (!slider) return;
                    
                    const prevBtn = slider.parentElement.querySelector('.prev-btn');
                    const nextBtn = slider.parentElement.querySelector('.next-btn');
                    
                    if (!prevBtn || !nextBtn) return;
                    
                    // Check if at the beginning
                    if (slider.scrollLeft <= 0) {
                        prevBtn.style.opacity = '0.3';
                        prevBtn.style.pointerEvents = 'none';
                    } else {
                        prevBtn.style.opacity = '1';
                        prevBtn.style.pointerEvents = 'auto';
                    }
                    
                    // Check if at the end
                    if (slider.scrollLeft >= slider.scrollWidth - slider.clientWidth - 5) {
                        nextBtn.style.opacity = '0.3';
                        nextBtn.style.pointerEvents = 'none';
                    } else {
                        nextBtn.style.opacity = '1';
                        nextBtn.style.pointerEvents = 'auto';
                    }
                });
            }
            
            // Add scroll event listeners and touch support
            document.addEventListener('DOMContentLoaded', function() {
                const sliders = document.querySelectorAll('.products-slider');
                sliders.forEach(slider => {
                    slider.addEventListener('scroll', updateNavButtons);
                    
                    // Add touch support for mobile
                    let isDown = false;
                    let startX;
                    let scrollLeft;
                    
                    slider.addEventListener('mousedown', (e) => {
                        isDown = true;
                        slider.style.cursor = 'grabbing';
                        startX = e.pageX - slider.offsetLeft;
                        scrollLeft = slider.scrollLeft;
                    });
                    
                    slider.addEventListener('mouseleave', () => {
                        isDown = false;
                        slider.style.cursor = 'grab';
                    });
                    
                    slider.addEventListener('mouseup', () => {
                        isDown = false;
                        slider.style.cursor = 'grab';
                    });
                    
                    slider.addEventListener('mousemove', (e) => {
                        if (!isDown) return;
                        e.preventDefault();
                        const x = e.pageX - slider.offsetLeft;
                        const walk = (x - startX) * 2;
                        slider.scrollLeft = scrollLeft - walk;
                    });
                });
                
                updateNavButtons(); // Initial check
                
                // Update buttons on window resize
                window.addEventListener('resize', updateNavButtons);
            });
        </script>
    </body>
</html>
