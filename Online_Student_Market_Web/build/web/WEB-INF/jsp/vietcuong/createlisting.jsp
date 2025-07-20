<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Listing page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vietcuong/editlisting.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
    <style>
        #imagePreview img {
            object-fit: cover;
            height: 150px;
            width: 100%;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">SVMarket</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="#">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Khám phá</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Yêu thích</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Tin nhắn</a></li>
                <li class="nav-item">
                    <img src="https://i.pinimg.com/736x/a6/16/28/a6162845747ab6f081706e9a00552a13.jpg" class="avatar-img" alt="Avatar">
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container py-5 mx-auto" style="max-width: 600px;">
    <h2 class="fw-bold mb-4">Tạo tin đăng mới</h2>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/createlisting" method="post">
        <div class="mb-3">
            <label class="form-label">Tiêu đề</label>
            <input type="text" name="title" class="form-control" placeholder="Nhập tiêu đề..." value="${param.title != null ? param.title : ''}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả..." required>${param.description != null ? param.description : ''}</textarea>
        </div>

        <div class="mb-4">
            <label class="form-label">Hình ảnh</label>
            <c:if test="${empty uploadedImages}">
                <input type="file" id="imageInput" accept="image/*" style="display: none;" />
                <div id="customUploadBox" class="border rounded-3 p-4 text-center text-muted" style="cursor: pointer;">
                    <p>Nhấp để chọn ảnh hoặc kéo thả vào đây</p>
                    <p class="small">Chỉ được tải lên 1 hình ảnh</p>
                </div>
                <div id="imagePreview" class="row g-2 mt-2"></div>
            </c:if>
            <input type="hidden" name="uploadedImages" id="uploadedImages" value="${param.uploadedImages}" />
        </div>

        <c:if test="${not empty uploadedImages}">
            <div class="mb-4">
                <label class="form-label">Ảnh đã tải lên:</label>
                <div class="row g-3">
                    <c:forEach var="img" items="${uploadedImages}">
                        <div class="col-12">
                            <img src="${pageContext.request.contextPath}/${img}" class="img-fluid rounded border" />
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <div class="mb-3">
            <label class="form-label">Giá</label>
            <input type="text" name="price" class="form-control" placeholder="Nhập giá..." value="${param.price != null ? param.price : ''}" required />
        </div>

        <div class="mb-4">
            <label class="form-label">Danh mục</label>
            <input type="text" name="category" class="form-control" placeholder="Nhập danh mục..." value="${param.category != null ? param.category : ''}" required />
        </div>

        <div class="d-flex justify-content-center gap-3">
            <button type="submit" name="action" value="create" class="btn btn-primary px-4 rounded-pill flex-fill" style="max-width: 250px;">Tạo mới</button>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary px-4 rounded-pill flex-fill text-center" style="max-width: 120px;">Huỷ</a>
        </div>
        <style>
            .gap-3 > * { margin-right: 16px; }
            .gap-3 > *:last-child { margin-right: 0; }
        </style>
    </form>
</div>

<c:import url="/WEB-INF/jsp/common/footer.jsp"/>

<script>
    const fileInput = document.getElementById('imageInput');
    const uploadBox = document.getElementById('customUploadBox');
    const preview = document.getElementById('imagePreview');
    const uploadedImagesInput = document.getElementById('uploadedImages');

    if (uploadBox) {
        uploadBox.addEventListener('click', () => fileInput.click());

        fileInput.addEventListener('change', async (e) => {
            const file = e.target.files[0];
            if (!file) return;

            const localUrl = URL.createObjectURL(file);
            preview.innerHTML = `<div class="col-12"><img src='${localUrl}' class='img-fluid rounded border' style='max-width: 200px;'/></div>`;

            const formData = new FormData();
            formData.append("file", file);
            formData.append("action", "upload"); // ✅ Thêm dòng này

            try {
                const res = await fetch("${pageContext.request.contextPath}/createlisting", {
                    method: "POST",
                    body: formData
                });

                const data = await res.json(); // sẽ lỗi nếu không phải JSON
                uploadedImagesInput.value = data.url;
            } catch (err) {
                alert("Lỗi upload ảnh: " + err);
            }
        });
    }
</script>

</body>
</html>
