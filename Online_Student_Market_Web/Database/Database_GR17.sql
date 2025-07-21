-- Chuyển sang context master để có quyền DROP DATABASE
USE master;
GO

-- Nếu database OSMW_WEB đã tồn tại thì xóa đi
IF DB_ID(N'OSMW_WEB') IS NOT NULL
BEGIN
    ALTER DATABASE [OSMW_WEB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [OSMW_WEB];
END;
GO

-- Tạo lại database và chuyển context
CREATE DATABASE [OSMW_WEB];
GO
USE [OSMW_WEB];
GO

-- Bảng [User]
CREATE TABLE [User] (
    user_id        INT IDENTITY(1,1) PRIMARY KEY,
    username       NVARCHAR(50)  NOT NULL,
    password_hash  NVARCHAR(255) NOT NULL,
    full_name      NVARCHAR(100) NULL,
    email          NVARCHAR(100) NULL,
    phone_number   NVARCHAR(20)  NULL,
    role           NVARCHAR(20)  NOT NULL DEFAULT N'USER',
    created_at     DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
    updated_at     DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- Bảng Category (có thêm category_image_url)
CREATE TABLE Category (
    category_id          INT IDENTITY(1,1) PRIMARY KEY,
    category_name        NVARCHAR(100) NOT NULL,
    category_description NVARCHAR(255) NULL,
    category_image_url   NVARCHAR(255) NULL,
    created_at           DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
    updated_at           DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- Bảng Product
CREATE TABLE Product (
    product_id     INT IDENTITY(1,1) PRIMARY KEY,
    category_id    INT NOT NULL,
    product_name   NVARCHAR(150) NOT NULL,
    description    NVARCHAR(MAX) NULL,
    price          DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    image_url      NVARCHAR(255) NULL,
    created_at     DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    updated_at     DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Product_Category FOREIGN KEY(category_id) REFERENCES Category(category_id)
);
GO

-- Bảng Cart
CREATE TABLE Cart (
    cart_id    INT IDENTITY(1,1) PRIMARY KEY,
    user_id    INT NOT NULL,
    created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    updated_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Cart_User FOREIGN KEY(user_id) REFERENCES [User](user_id)
);
GO

-- Bảng Cart_Item
CREATE TABLE Cart_Item (
    cart_item_id INT IDENTITY(1,1) PRIMARY KEY,
    cart_id      INT NOT NULL,
    product_id   INT NOT NULL,
    quantity     INT NOT NULL,
    CONSTRAINT FK_CartItem_Cart FOREIGN KEY(cart_id) REFERENCES Cart(cart_id),
    CONSTRAINT FK_CartItem_Product FOREIGN KEY(product_id) REFERENCES Product(product_id)
);
GO

-- Bảng [Order]
CREATE TABLE [Order] (
    order_id         INT IDENTITY(1,1) PRIMARY KEY,
    user_id          INT NOT NULL,
    total_amount     DECIMAL(12,2) NOT NULL,
    payment_method   NVARCHAR(50) NULL,
    order_date       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    status           NVARCHAR(20) NOT NULL DEFAULT N'PENDING',
    shipping_address NVARCHAR(255) NULL,
    created_at       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    updated_at       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Order_User FOREIGN KEY(user_id) REFERENCES [User](user_id)
);
GO

-- Bảng Order_Item
CREATE TABLE Order_Item (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id      INT NOT NULL,
    product_id    INT NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    quantity      INT NOT NULL,
    CONSTRAINT FK_OrderItem_Order FOREIGN KEY(order_id) REFERENCES [Order](order_id),
    CONSTRAINT FK_OrderItem_Product FOREIGN KEY(product_id) REFERENCES Product(product_id)
);
GO

-- Chèn dữ liệu mẫu cho bảng User
INSERT INTO [User] (username, password_hash, full_name, email, phone_number, role)
VALUES
    (N'user1',  N'user', N'User One',   N'user1@example.com',  N'0123456781', N'USER'),
    (N'user2',  N'user', N'User Two',   N'user2@example.com',  N'0123456782', N'USER'),
    (N'admin1', N'admin', N'Administrator', N'admin1@example.com', N'0987654321', N'ADMIN');
GO

-- Chèn dữ liệu mẫu cho bảng Category
INSERT INTO Category (category_name, category_description, category_image_url, created_at, updated_at)
VALUES
    (N'Stationery',          N'Dụng cụ văn phòng phẩm cơ bản: giấy, bút, keo, …',             N'https://picsum.photos/seed/cat1/300/300', SYSUTCDATETIME(), SYSUTCDATETIME()),
    (N'Notebooks',           N'Sổ tay, sổ vở các loại: kẻ ngang, kẻ ô, không kẻ',          N'https://picsum.photos/seed/cat2/300/300', SYSUTCDATETIME(), SYSUTCDATETIME()),
    (N'Writing Instruments', N'Bút bi, bút chì, bút màu, dạ quang, marker',                N'https://picsum.photos/seed/cat3/300/300', SYSUTCDATETIME(), SYSUTCDATETIME()),
    (N'Art Supplies',        N'Dụng cụ vẽ: màu nước, màu dầu, cọ, canvas nhỏ, …',         N'https://picsum.photos/seed/cat4/300/300', SYSUTCDATETIME(), SYSUTCDATETIME()),
    (N'Desk Organizers',     N'Kệ bút, ngăn kéo mini, khay đựng hồ sơ, …',                 N'https://picsum.photos/seed/cat5/300/300', SYSUTCDATETIME(), SYSUTCDATETIME()),
    (N'Backpacks',           N'Balo, túi đeo chéo chống nước cho học sinh–sinh viên',        N'https://picsum.photos/seed/cat6/300/300', SYSUTCDATETIME(), SYSUTCDATETIME()),
    (N'School Uniforms',     N'Đồng phục, áo thun, quần soóc, váy đồng phục',              N'https://picsum.photos/seed/cat7/300/300', SYSUTCDATETIME(), SYSUTCDATETIME()),
    (N'Sports Gear',         N'Dụng cụ thể thao cá nhân: bóng, vợt, dây nhảy, …',           N'https://picsum.photos/seed/cat8/300/300', SYSUTCDATETIME(), SYSUTCDATETIME());
GO

-- Chèn dữ liệu mẫu cho bảng Product
INSERT INTO Product (category_id, product_name, description, price, stock_quantity, image_url)
VALUES
    -- Category 1: Stationery
    (1, N'Stationery Bundle #1',  N'Bộ giấy note & bút bi',                      15000.00, 100, N'https://picsum.photos/seed/prod101/300/300'),
    (1, N'Stationery Bundle #2',  N'Set bút chì & gôm tẩy',                      20000.00,  80, N'https://picsum.photos/seed/prod102/300/300'),
    (1, N'Stationery Bundle #3',  N'Bút marker đa màu',                           35000.00,  60, N'https://picsum.photos/seed/prod103/300/300'),
    (1, N'Stationery Bundle #4',  N'Keo dán & băng keo',                          12000.00, 120, N'https://picsum.photos/seed/prod104/300/300'),
    (1, N'Stationery Bundle #5',  N'Bút dạ quang 5 màu',                          25000.00,  90, N'https://picsum.photos/seed/prod105/300/300'),
    (1, N'Stationery Bundle #6',  N'Bút gel 0.5 mm',                             18000.00,  70, N'https://picsum.photos/seed/prod106/300/300'),
    (1, N'Stationery Bundle #7',  N'Ghim & kẹp giấy',                             9900.00, 200, N'https://picsum.photos/seed/prod107/300/300'),
    (1, N'Stationery Bundle #8',  N'Bút lông dầu Black',                          22000.00,  50, N'https://picsum.photos/seed/prod108/300/300'),
    (1, N'Stationery Bundle #9',  N'Giấy in A4 (500 tờ)',                         50000.00, 150, N'https://picsum.photos/seed/prod109/300/300'),
    (1, N'Stationery Bundle #10', N'Hộp bút 12 ngăn',                             40000.00,  40, N'https://picsum.photos/seed/prod110/300/300'),
    (1, N'Stationery Bundle #11', N'Bút roller 0.7 mm',                          21000.00,  65, N'https://picsum.photos/seed/prod111/300/300'),
    (1, N'Stationery Bundle #12', N'Tước kẻ kim loại 30 cm',                     17500.00,  90, N'https://picsum.photos/seed/prod112/300/300'),
    (1, N'Stationery Bundle #13', N'Dao rọc giấy đa năng',                        13000.00,  55, N'https://picsum.photos/seed/prod113/300/300'),
    (1, N'Stationery Bundle #14', N'Bút mực nước Artist',                         30000.00,  45, N'https://picsum.photos/seed/prod114/300/300'),
    (1, N'Stationery Bundle #15', N'Bút highlight neon',                          16000.00, 110, N'https://picsum.photos/seed/prod115/300/300'),
    (1, N'Stationery Bundle #16', N'Tẩy chì non dust-free',                      5000.00,  130, N'https://picsum.photos/seed/prod116/300/300'),
    (1, N'Stationery Bundle #17', N'Gôm nhỏ mini',                               4000.00,  180, N'https://picsum.photos/seed/prod117/300/300'),
    (1, N'Stationery Bundle #18', N'Giấy note màu',                              22000.00,   95, N'https://picsum.photos/seed/prod118/300/300'),
    (1, N'Stationery Bundle #19', N'Băng keo văn phòng',                         11000.00,  140, N'https://picsum.photos/seed/prod119/300/300'),
    (1, N'Stationery Bundle #20', N'Mực bút bi đáy lớn',                        9000.00,   75, N'https://picsum.photos/seed/prod120/300/300'),

    -- Category 2: Notebooks
    (2, N'Hardcover Notebook #1',  N'Sổ bìa cứng 80 trang kẻ ngang',          25000.00, 100, N'https://picsum.photos/seed/prod201/300/300'),
    (2, N'Hardcover Notebook #2',  N'Sổ bìa cứng 80 trang kẻ ô',             26000.00,  90, N'https://picsum.photos/seed/prod202/300/300'),
    (2, N'Spiral Notebook #3',     N'Sổ xoắn 100 trang không kẻ',             20000.00, 120, N'https://picsum.photos/seed/prod203/300/300'),
    (2, N'Spiral Notebook #4',     N'Sổ xoắn 100 trang kẻ ô',                21000.00, 110, N'https://picsum.photos/seed/prod204/300/300'),
    (2, N'Pocket Notebook #5',     N'Sổ tay mini 50 trang',                   18000.00, 130, N'https://picsum.photos/seed/prod205/300/300'),
    (2, N'Pocket Notebook #6',     N'Sổ tay mini 50 trang kẻ ngang',         18500.00, 115, N'https://picsum.photos/seed/prod206/300/300'),
    (2, N'Sketch Notebook #7',     N'Giấy vẽ sketch 40 tờ',                   30000.00,  60, N'https://picsum.photos/seed/prod207/300/300'),
    (2, N'Sketch Notebook #8',     N'Giấy vẽ sketch 80 tờ',                   45000.00,  50, N'https://picsum.photos/seed/prod208/300/300'),
    (2, N'Journal Notebook #9',    N'Sổ nhật ký bìa da',                       50000.00,  40, N'https://picsum.photos/seed/prod209/300/300'),
    (2, N'Journal Notebook #10',   N'Sổ nhật ký có khóa',                      55000.00,  35, N'https://picsum.photos/seed/prod210/300/300'),
    (2, N'Lab Notebook #11',       N'Sổ lab 200 trang',                       60000.00,  30, N'https://picsum.photos/seed/prod211/300/300'),
    (2, N'Lab Notebook #12',       N'Sổ lab 200 trang kẻ ô',                  62000.00,  25, N'https://picsum.photos/seed/prod212/300/300'),
    (2, N'Planner Notebook #13',   N'Sổ kế hoạch hàng tuần',                  40000.00,  55, N'https://picsum.photos/seed/prod213/300/300'),
    (2, N'Planner Notebook #14',   N'Sổ kế hoạch hàng ngày',                  45000.00,  45, N'https://picsum.photos/seed/prod214/300/300'),
    (2, N'Recipe Notebook #15',    N'Sổ công thức nấu ăn',                    35000.00,  65, N'https://picsum.photos/seed/prod215/300/300'),
    (2, N'Bullet Notebook #16',    N'Sổ bullet 120 trang',                    50000.00,  50, N'https://picsum.photos/seed/prod216/300/300'),
    (2, N'Grid Notebook #17',      N'Sổ kẻ ô 160 trang',                     42000.00,  70, N'https://picsum.photos/seed/prod217/300/300'),
    (2, N'Plain Notebook #18',     N'Sổ trắng không kẻ 120 trang',           38000.00,  80, N'https://picsum.photos/seed/prod218/300/300'),
    (2, N'Dot Notebook #19',       N'Sổ kẻ chấm dot 120 trang',              40000.00,  75, N'https://picsum.photos/seed/prod219/300/300'),
    (2, N'Eco Notebook #20',       N'Sổ tái chế 100 trang',                   28000.00,  90, N'https://picsum.photos/seed/prod220/300/300'),

    -- Category 3: Writing Instruments
    (3, N'Gel Pen #1',             N'Bút gel 0.5 mm nhiều màu',                43200.00, 120, N'https://picsum.photos/seed/prod301/300/300'),
    (3, N'Ballpoint Pen #2',       N'Bút bi 1.0 mm trơn tru',                 28800.00, 150, N'https://picsum.photos/seed/prod302/300/300'),
    (3, N'Mechanical Pencil #3',   N'Bút chì kim 0.5 mm',                     48000.00, 100, N'https://picsum.photos/seed/prod303/300/300'),
    (3, N'Brush Pen #4',           N'Bút cọ vẽ thư pháp',                     84000.00,  60, N'https://picsum.photos/seed/prod304/300/300'),
    (3, N'Highlighter #5',         N'Bút dạ quang neon',                      36000.00, 110, N'https://picsum.photos/seed/prod305/300/300'),
    (3, N'Marker #6',              N'Bút marker đầu to',                      67200.00,  80, N'https://picsum.photos/seed/prod306/300/300'),
    (3, N'Fountain Pen #7',        N'Bút máy ngòi thép',                     360000.00,  30, N'https://picsum.photos/seed/prod307/300/300'),
    (3, N'Calligraphy Pen #8',     N'Bút nghệ thuật chữ thư pháp',            120000.00,  50, N'https://picsum.photos/seed/prod308/300/300'),
    (3, N'Colored Pencil #9',      N'Hộp 12 bút chì màu',                     96000.00,  90, N'https://picsum.photos/seed/prod309/300/300'),
    (3, N'Oil Pastel #10',         N'Hộp 24 sáp dầu',                         144000.00,  40, N'https://picsum.photos/seed/prod310/300/300'),
    (3, N'Art Marker #11',         N'Set 6 marker alcohol',                  288000.00,  25, N'https://picsum.photos/seed/prod311/300/300'),
    (3, N'Sketch Pencil #12',      N'Bút chì than vẽ sketch',                 72000.00,  70, N'https://picsum.photos/seed/prod312/300/300'),
    (3, N'Technical Pen #13',      N'Bút kỹ thuật 0.3 mm',                    60000.00,  60, N'https://picsum.photos/seed/prod313/300/300'),
    (3, N'Fineliner #14',          N'Bút line mảnh 0.1 mm',                   52800.00,  80, N'https://picsum.photos/seed/prod314/300/300'),
    (3, N'Multi-Pen #15',          N'Bút đa năng 4 màu',                      72000.00,  65, N'https://picsum.photos/seed/prod315/300/300'),
    (3, N'Erasable Pen #16',       N'Bút xóa được mực',                       67200.00,  75, N'https://picsum.photos/seed/prod316/300/300'),
    (3, N'Liquid Ink Pen #17',     N'Bút mực lỏng Artist',                   108000.00,  50, N'https://picsum.photos/seed/prod317/300/300'),
    (3, N'Color Gel Pen #18',      N'Set 10 gel pen neon',                   120000.00,  45, N'https://picsum.photos/seed/prod318/300/300'),
    (3, N'Dual-Tip Marker #19',    N'Marker 2 đầu to–nhỏ',                    76800.00,  70, N'https://picsum.photos/seed/prod319/300/300'),
    (3, N'Refill Cartridge #20',   N'Ruột bút máy 5 cây',                     48000.00, 100, N'https://picsum.photos/seed/prod320/300/300');
GO

-- Chèn dữ liệu mẫu cho bảng Product: Category 4 - Art Supplies
INSERT INTO Product (category_id, product_name, description, price, stock_quantity, image_url)
VALUES
    -- Category 4: Art Supplies
    (4, N'Watercolor Set #1',      N'Hộp 12 màu nước Artist',                 192000.00,  40, N'https://picsum.photos/seed/prod401/300/300'),
    (4, N'Oil Paint Set #2',       N'Hộp 8 màu dầu cao cấp',                  288000.00,  30, N'https://picsum.photos/seed/prod402/300/300'),
    (4, N'Brush Set #3',           N'Set 5 cọ vẽ nhiều kích cỡ',              132000.00,  60, N'https://picsum.photos/seed/prod403/300/300'),
    (4, N'Canvas Board #4',        N'Canvas gỗ 30x40 cm',                     240000.00,  25, N'https://picsum.photos/seed/prod404/300/300'),
    (4, N'Sketching Charcoal #5',  N'Than vẽ 5 thanh',                        84000.00,  70, N'https://picsum.photos/seed/prod405/300/300'),
    (4, N'Pastel Stick #6',        N'Hộp 24 pastel stick',                    216000.00,  35, N'https://picsum.photos/seed/prod406/300/300'),
    (4, N'Acrylic Set #7',         N'Hộp 10 màu acrylic',                     168000.00,  50, N'https://picsum.photos/seed/prod407/300/300'),
    (4, N'Palette #8',             N'Bảng pha màu nhựa',                       48000.00,  80, N'https://picsum.photos/seed/prod408/300/300'),
    (4, N'Easel Stand #9',         N'Giá vẽ gỗ để bàn',                       360000.00,  20, N'https://picsum.photos/seed/prod409/300/300'),
    (4, N'Canvas Roll #10',        N'Cuộn canvas 1 m x 1 m',                  480000.00,  10, N'https://picsum.photos/seed/prod410/300/300'),
    (4, N'Graphite Pencil #11',    N'Bút chì graphite HB',                    24000.00, 100, N'https://picsum.photos/seed/prod411/300/300'),
    (4, N'Ink Bottle #12',         N'Chai mực đen 50 ml',                     96000.00,  60, N'https://picsum.photos/seed/prod412/300/300'),
    (4, N'Masking Tape #13',       N'Băng giấy che màu',                       36000.00,  90, N'https://picsum.photos/seed/prod413/300/300'),
    (4, N'Paper Pad #14',          N'Bloc giấy A3 50 tờ',                     144000.00,  45, N'https://picsum.photos/seed/prod414/300/300'),
    (4, N'Spray Fixative #15',     N'Chai xịt cố định tranh',                204000.00,  30, N'https://picsum.photos/seed/prod415/300/300'),
    (4, N'Oil Brush Cleaner #16',  N'Dung dịch rửa cọ dầu',                   120000.00,  40, N'https://picsum.photos/seed/prod416/300/300'),
    (4, N'Wood Panel #17',         N'Tấm gỗ vẽ acrylic 20x20 cm',             288000.00,  25, N'https://picsum.photos/seed/prod417/300/300'),
    (4, N'Charcoal Pencil #18',    N'Bút chì than 2B',                        28800.00,  80, N'https://picsum.photos/seed/prod418/300/300'),
    (4, N'Sketch Marker #19',      N'Marker vẽ sketch',                       84000.00,  70, N'https://picsum.photos/seed/prod419/300/300'),
    (4, N'Varnish Spray #20',      N'Chai xịt dầu bóng bảo vệ tranh',         216000.00,  30, N'https://picsum.photos/seed/prod420/300/300');
GO

-- Chèn dữ liệu mẫu cho Category 5: Desk Organizers
INSERT INTO Product (category_id, product_name, description, price, stock_quantity, image_url)
VALUES
    (5, N'Mesh Pen Holder #1',      N'Ống đựng bút lưới',                       72000.00,  80, N'https://picsum.photos/seed/prod501/300/300'),
    (5, N'Drawer Organizer #2',    N'Ngăn kéo mini 3 ngăn',                   288000.00,  40, N'https://picsum.photos/seed/prod502/300/300'),
    (5, N'File Sorter #3',         N'Giá đựng hồ sơ đứng',                     192000.00,  60, N'https://picsum.photos/seed/prod503/300/300'),
    (5, N'Desk Tray #4',           N'Khay giấy A4 2 tầng',                    240000.00,  50, N'https://picsum.photos/seed/prod504/300/300'),
    (5, N'Cable Organizer #5',     N'Giá đỡ dây cáp',                          120000.00,  70, N'https://picsum.photos/seed/prod505/300/300'),
    (5, N'Monitor Stand #6',       N'Đế nâng màn hình gỗ',                     360000.00,  30, N'https://picsum.photos/seed/prod506/300/300'),
    (5, N'Sticky Note Holder #7',  N'Hộp đựng giấy note',                     144000.00,  90, N'https://picsum.photos/seed/prod507/300/300'),
    (5, N'Magazine Rack #8',       N'Giá để tạp chí',                          216000.00,  40, N'https://picsum.photos/seed/prod508/300/300'),
    (5, N'Letter Holder #9',       N'Giá để thư từ',                           144000.00,  60, N'https://picsum.photos/seed/prod509/300/300'),
    (5, N'Desktop Drawer #10',     N'Ngăn kéo để bàn 4 ngăn',                 480000.00,  25, N'https://picsum.photos/seed/prod510/300/300'),
    (5, N'Pen Cup #11',            N'Cốc đựng bút sứ',                         168000.00,  50, N'https://picsum.photos/seed/prod511/300/300'),
    (5, N'Desktop Shelf #12',      N'Kệ để bàn 2 tầng',                       432000.00,  30, N'https://picsum.photos/seed/prod512/300/300'),
    (5, N'Cable Clip #13',         N'Kẹp dây cáp 10 cái',                      48000.00, 100, N'https://picsum.photos/seed/prod513/300/300'),
    (5, N'Phone Stand #14',        N'Giá đỡ điện thoại',                       132000.00,  80, N'https://picsum.photos/seed/prod514/300/300'),
    (5, N'Desk Mat #15',           N'Thảm lót bàn 60x30 cm',                  288000.00,  40, N'https://picsum.photos/seed/prod515/300/300'),
    (5, N'Headphone Hook #16',     N'Móc treo tai nghe',                       84000.00,  70, N'https://picsum.photos/seed/prod516/300/300'),
    (5, N'USB Hub Stand #17',      N'Đế hub USB 4 cổng',                      336000.00,  35, N'https://picsum.photos/seed/prod517/300/300'),
    (5, N'Cable Box #18',          N'Hộp đựng ổ cắm & cáp',                   252000.00,  45, N'https://picsum.photos/seed/prod518/300/300'),
    (5, N'Bookmark Holder #19',    N'Giá kẹp bookmark',                       72000.00,  60, N'https://picsum.photos/seed/prod519/300/300'),
    (5, N'Desk Clock #20',         N'Đồng hồ để bàn nhỏ',                      192000.00,  30, N'https://picsum.photos/seed/prod520/300/300');
GO

-- Chèn dữ liệu mẫu cho Category 6: Backpacks
INSERT INTO Product (category_id, product_name, description, price, stock_quantity, image_url)
VALUES
    (6, N'Classic Backpack #1',     N'Balo nylon chống nước 15L',               600000.00,  50, N'https://picsum.photos/seed/prod601/300/300'),
    (6, N'Laptop Backpack #2',      N'Balo laptop 15.6″ ngăn chống sốc',       840000.00,  40, N'https://picsum.photos/seed/prod602/300/300'),
    (6, N'Mini Backpack #3',        N'Balo mini thời trang 5L',                480000.00,  60, N'https://picsum.photos/seed/prod603/300/300'),
    (6, N'Sport Backpack #4',       N'Balo thể thao 25L',                      720000.00,  45, N'https://picsum.photos/seed/prod604/300/300'),
    (6, N'Travel Backpack #5',      N'Balo du lịch 40L',                      1200000.00,  30, N'https://picsum.photos/seed/prod605/300/300'),
    (6, N'Canvas Backpack #6',      N'Balo vải bố bền đẹp',                   672000.00,  35, N'https://picsum.photos/seed/prod606/300/300'),
    (6, N'Eco Backpack #7',         N'Balo vải tái chế 20L',                  768000.00,  25, N'https://picsum.photos/seed/prod607/300/300'),
    (6, N'School Backpack #8',      N'Balo học sinh 18L',                      528000.00,  55, N'https://picsum.photos/seed/prod608/300/300'),
    (6, N'Hiking Backpack #9',      N'Balo leo núi 30L',                      1440000.00,  20, N'https://picsum.photos/seed/prod609/300/300'),
    (6, N'Child Backpack #10',      N'Balo trẻ em 10L',                        432000.00,  65, N'https://picsum.photos/seed/prod610/300/300'),
    (6, N'Fashion Backpack #11',    N'Balo thời trang da PU',                960000.00,  30, N'https://picsum.photos/seed/prod611/300/300'),
    (6, N'Waterproof Backpack #12', N'Balo chống nước 20L',                    792000.00,  28, N'https://picsum.photos/seed/prod612/300/300'),
    (6, N'Roll-Top Backpack #13',   N'Balo cuộn miệng tiện lợi 25L',         1080000.00,  22, N'https://picsum.photos/seed/prod613/300/300'),
    (6, N'Anti-Theft Backpack #14', N'Balo chống trộm khóa ẩn',               1320000.00,  18, N'https://picsum.photos/seed/prod614/300/300'),
    (6, N'Slim Backpack #15',       N'Balo mỏng gọn 12L',                     648000.00,  50, N'https://picsum.photos/seed/prod615/300/300'),
    (6, N'Duffel Backpack #16',     N'Túi duffel 30L kiêm balo',             1152000.00,  20, N'https://picsum.photos/seed/prod616/300/300'),
    (6, N'Roller Backpack #17',     N'Balo có bánh xe kéo',                  1680000.00,  15, N'https://picsum.photos/seed/prod617/300/300'),
    (6, N'Convertible Backpack #18',N'Balo đổi túi tote 18L',                912000.00,  25, N'https://picsum.photos/seed/prod618/300/300'),
    (6, N'Messenger Backpack #19',  N'Balo đeo chéo messenger',                696000.00,  30, N'https://picsum.photos/seed/prod619/300/300'),
    (6, N'Hydration Backpack #20',  N'Balo tích hợp bình nước',               1560000.00,  12, N'https://picsum.photos/seed/prod620/300/300');
GO

-- Chèn dữ liệu mẫu cho Category 7: School Uniforms
INSERT INTO Product (category_id, product_name, description, price, stock_quantity, image_url)
VALUES
    (7, N'White Polo Shirt #1',     N'Áo polo trắng cotton size S–XL',         360000.00, 100, N'https://picsum.photos/seed/prod701/300/300'),
    (7, N'Blue Polo Shirt #2',      N'Áo polo xanh navy cotton size S–XL',     360000.00,  90, N'https://picsum.photos/seed/prod702/300/300'),
    (7, N'Grey Shorts #3',          N'Quần soóc xám polyester size M–XXL',     288000.00,  80, N'https://picsum.photos/seed/prod703/300/300'),
    (7, N'Black Shorts #4',         N'Quần soóc đen nylon size M–XXL',         288000.00,  85, N'https://picsum.photos/seed/prod704/300/300'),
    (7, N'Skirt #5',                N'Chân váy xếp ly size S–L',               432000.00,  70, N'https://picsum.photos/seed/prod705/300/300'),
    (7, N'Trousers #6',             N'Quần dài kaki size M–XXL',               480000.00,  60, N'https://picsum.photos/seed/prod706/300/300'),
    (7, N'Blazer Jacket #7',        N'Áo blazer học sinh size S–L',            960000.00,  30, N'https://picsum.photos/seed/prod707/300/300'),
    (7, N'Sweater #8',              N'Áo len cổ tim size S–XXL',               600000.00,  50, N'https://picsum.photos/seed/prod708/300/300'),
    (7, N'Socks Pack #9',           N'Tất ngắn học sinh 5 đôi',                192000.00, 100, N'https://picsum.photos/seed/prod709/300/300'),
    (7, N'Tie #10',                 N'Cà vạt đồng phục',                        120000.00, 120, N'https://picsum.photos/seed/prod710/300/300'),
    (7, N'Belt #11',                N'Thắt lưng da size M–L',                  240000.00,  80, N'https://picsum.photos/seed/prod711/300/300'),
    (7, N'Hat #12',                 N'Mũ nón đồng phục',                       168000.00,  60, N'https://picsum.photos/seed/prod712/300/300'),
    (7, N'PE Shirt #13',            N'Áo thể dục đồng phục',                    288000.00,  90, N'https://picsum.photos/seed/prod713/300/300'),
    (7, N'PE Shorts #14',           N'Quần thể dục đồng phục',                  240000.00,  95, N'https://picsum.photos/seed/prod714/300/300'),
    (7, N'Gym Shoes #15',           N'Giày thể thao đơn giản size 36–45',       720000.00,  40, N'https://picsum.photos/seed/prod715/300/300'),
    (7, N'Sweatband #16',           N'Băng cổ tay thể dục',                     72000.00, 100, N'https://picsum.photos/seed/prod716/300/300'),
    (7, N'Gym Bag #17',             N'Túi đựng đồ thể dục',                    480000.00,  50, N'https://picsum.photos/seed/prod717/300/300'),
    (7, N'Training Jacket #18',     N'Áo khoác tập thể thao',                    840000.00,  30, N'https://picsum.photos/seed/prod718/300/300'),
    (7, N'Tracksuit Pants #19',     N'Quần jogger đồng phục',                  600000.00,  45, N'https://picsum.photos/seed/prod719/300/300'),
    (7, N'Caps #20',                N'Mũ lưỡi trai đồng phục',                  240000.00,  80, N'https://picsum.photos/seed/prod720/300/300');
GO

-- Chèn dữ liệu mẫu cho Category 8: Sports Gear
INSERT INTO Product (category_id, product_name, description, price, stock_quantity, image_url)
VALUES
    (8, N'Basketball #1',           N'Quả bóng rổ size 7',                     600000.00,  50, N'https://picsum.photos/seed/prod801/300/300'),
    (8, N'Football #2',             N'Quả bóng đá size 5',                     480000.00,  45, N'https://picsum.photos/seed/prod802/300/300'),
    (8, N'Badminton Racket #3',     N'Vợt cầu lông carbon cao cấp',            720000.00,  40, N'https://picsum.photos/seed/prod803/300/300'),
    (8, N'Shuttlecocks #4',         N'5 trái cầu lông nylon',                  120000.00, 100, N'https://picsum.photos/seed/prod804/300/300'),
    (8, N'Tennis Racket #5',        N'Vợt tennis graphite',                   1440000.00,  30, N'https://picsum.photos/seed/prod805/300/300'),
    (8, N'Tennis Balls #6',         N'Hộp 3 bóng tennis',                     240000.00,  80, N'https://picsum.photos/seed/prod806/300/300'),
    (8, N'Skipping Rope #7',        N'Dây nhảy thể thao',                      192000.00,  90, N'https://picsum.photos/seed/prod807/300/300'),
    (8, N'Yoga Mat #8',             N'Thảm yoga 6 mm',                        360000.00,  60, N'https://picsum.photos/seed/prod808/300/300'),
    (8, N'Dumbbell Set #9',         N'Tạ tay 2 x 2 kg',                       480000.00,  50, N'https://picsum.photos/seed/prod809/300/300'),
    (8, N'Kettlebell #10',          N'Tạ 5 kg hình chuông',                   600000.00,  45, N'https://picsum.photos/seed/prod810/300/300'),
    (8, N'Exercise Ball #11',       N'Bóng tập gym 65 cm',                    432000.00,  40, N'https://picsum.photos/seed/prod811/300/300'),
    (8, N'Resistance Band #12',     N'Bộ 5 dây kháng lực',                    288000.00,  80, N'https://picsum.photos/seed/prod812/300/300'),
    (8, N'Foam Roller #13',         N'Con lăn massage cơ bắp',                360000.00,  70, N'https://picsum.photos/seed/prod813/300/300'),
    (8, N'Pull-Up Bar #14',         N'Thanh xà đơn gắn cửa',                  720000.00,  35, N'https://picsum.photos/seed/prod814/300/300'),
    (8, N'Gym Gloves #15',          N'Găng tay tập gym size M–L',              240000.00,  90, N'https://picsum.photos/seed/prod815/300/300'),
    (8, N'Fitness Tracker #16',     N'Đồng hồ thông minh đo bước',            1200000.00, 20,N'https://picsum.photos/seed/prod816/300/300'),
    (8, N'Jump Box #17',            N'Hộp tập nhảy plyo',                     960000.00,  25, N'https://picsum.photos/seed/prod817/300/300'),
    (8, N'Punching Bag #18',        N'Bao cát treo tường',                    1320000.00, 15, N'https://picsum.photos/seed/prod818/300/300'),
    (8, N'Speed Rope #19',          N'Dây nhảy tốc độ cao',                   288000.00, 85, N'https://picsum.photos/seed/prod819/300/300'),
    (8, N'Ankle Weights #20',       N'Tạ chân 2 x 1 kg',                      432000.00, 75, N'https://picsum.photos/seed/prod820/300/300');
GO

select * from [User]