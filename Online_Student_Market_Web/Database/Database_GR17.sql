USE master;
GO

IF DB_ID(N'OSMW_WEB234') IS NOT NULL
    BEGIN
        ALTER DATABASE OSMW_WEB234 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE OSMW_WEB234;
    END
GO
CREATE DATABASE OSMW_WEB234;
GO
USE OSMW_WEB234;
GO

/*================ USER ==================*/
CREATE TABLE dbo.[User] (
                            user_id       INT IDENTITY(1,1) PRIMARY KEY,
                            username      NVARCHAR(50)  NOT NULL,
                            password_hash NVARCHAR(255) NOT NULL,
                            full_name     NVARCHAR(100) NULL,
                            email         NVARCHAR(100) NULL,
                            phone_number  NVARCHAR(20)  NULL,
                            status        NVARCHAR(20)  NOT NULL DEFAULT N'ACTIVE',
                            role          NVARCHAR(20)  NOT NULL DEFAULT N'USER',
                            created_at    DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
                            updated_at    DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

/*============== CATEGORY ================*/
CREATE TABLE dbo.Category (
                              category_id   INT IDENTITY(1,1) PRIMARY KEY,
                              category_name NVARCHAR(100) NOT NULL,
                              image_url     NVARCHAR(255) NULL,
                              created_at    DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                              updated_at    DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

/*============= SUBCATEGORY ==============*/
CREATE TABLE dbo.Subcategory (
                                 subcategory_id   INT IDENTITY(1,1) PRIMARY KEY,
                                 category_id      INT NOT NULL,
                                 subcategory_name NVARCHAR(100) NOT NULL,
                                 image_url        NVARCHAR(255) NULL,
                                 created_at       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                                 updated_at       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                                 CONSTRAINT FK_Subcategory_Category
                                     FOREIGN KEY (category_id) REFERENCES dbo.Category(category_id)
);
GO

/*================ PRODUCT ===============*/
CREATE TABLE dbo.Product (
                             product_id     INT IDENTITY(1,1) PRIMARY KEY,
                             subcategory_id INT NOT NULL,
                             product_name   NVARCHAR(150) NOT NULL,
                             description    NVARCHAR(MAX) NULL,
                             price          DECIMAL(10,2) NOT NULL,
                             image_url   NVARCHAR(255) NOT NULL,
                             stock_quantity INT NOT NULL DEFAULT 0,
                             created_at     DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                             updated_at     DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                             CONSTRAINT FK_Product_Subcategory
                                 FOREIGN KEY (subcategory_id) REFERENCES dbo.Subcategory(subcategory_id)
);
GO

/*================= CART =================*/
CREATE TABLE dbo.Cart (
                          cart_id    INT IDENTITY(1,1) PRIMARY KEY,
                          user_id    INT NOT NULL,
                          created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                          updated_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                          CONSTRAINT FK_Cart_User FOREIGN KEY(user_id) REFERENCES dbo.[User](user_id)
);
GO

/*============== CART_ITEM ===============*/
CREATE TABLE dbo.Cart_Item (
                               cart_item_id INT IDENTITY(1,1) PRIMARY KEY,
                               cart_id      INT NOT NULL,
                               product_id   INT NOT NULL,
                               quantity     INT NOT NULL,
                               CONSTRAINT FK_CartItem_Cart    FOREIGN KEY(cart_id)    REFERENCES dbo.Cart(cart_id),
                               CONSTRAINT FK_CartItem_Product FOREIGN KEY(product_id) REFERENCES dbo.Product(product_id)
);
GO

/*================= ORDER ================*/
CREATE TABLE dbo.[Order] (
                             order_id         INT IDENTITY(1,1) PRIMARY KEY,
                             user_id          INT NOT NULL,
                             total_amount     DECIMAL(12,2) NOT NULL,
                             payment_method   NVARCHAR(50) NULL,
                             order_date       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                             status           NVARCHAR(20) NOT NULL DEFAULT N'PENDING',
                             shipping_address NVARCHAR(255) NULL,
                             created_at       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                             updated_at       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
                             CONSTRAINT FK_Order_User FOREIGN KEY(user_id) REFERENCES dbo.[User](user_id)
);
GO

/*============= ORDER_ITEM ===============*/
CREATE TABLE dbo.Order_Item (
                                order_item_id INT IDENTITY(1,1) PRIMARY KEY,
                                order_id      INT NOT NULL,
                                product_id    INT NOT NULL,
                                unit_price    DECIMAL(10,2) NOT NULL,
                                quantity      INT NOT NULL,
                                CONSTRAINT FK_OrderItem_Order   FOREIGN KEY(order_id)   REFERENCES dbo.[Order](order_id),
                                CONSTRAINT FK_OrderItem_Product FOREIGN KEY(product_id) REFERENCES dbo.Product(product_id)
);
GO

-- Insert initial user
INSERT INTO dbo.[User]
(username, password_hash, full_name, email, phone_number, status, role)
VALUES
    ('user1',  '123',  N'User One',  'user1@example.com',  '0901000001', N'ACTIVE', N'USER'),
    ('user2',  '123',  N'User Two',  'user2@example.com',  '0901000002', N'ACTIVE', N'USER'),
    ('admin1', 'admin',N'Admin One', 'admin1@example.com', '0901000999', N'ACTIVE', N'ADMIN');
GO

select * from [User]

-- Insert initial cart for users
INSERT INTO dbo.Cart (user_id)
SELECT u.user_id
FROM dbo.[User] u
         LEFT JOIN dbo.Cart c ON c.user_id = u.user_id
WHERE u.role <> N'ADMIN'
  AND c.user_id IS NULL;
GO

select * from Cart;

-- Insert initial categories
INSERT INTO dbo.Category (category_name, image_url)
VALUES
    (N'Thời trang',       'https://plus.unsplash.com/premium_photo-1673356302439-fa5252f45abb?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    (N'Văn phòng phẩm',   'https://images.unsplash.com/photo-1623697899817-2e067e4a4036?q=80&w=1565&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    (N'Thể thao',         'https://plus.unsplash.com/premium_photo-1679517155948-4b6c8d26cbd5?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    (N'Đồ điện tử',       'https://images.unsplash.com/photo-1526406915894-7bcd65f60845?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZnJlZSUyMGltYWdlcyUyMEVsZWN0cm9uaWNzfGVufDB8fDB8fHww'),
    (N'Phụ kiện',         'https://plus.unsplash.com/premium_photo-1683309555671-7efeac6caa3d?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    (N'Sách',             'https://images.unsplash.com/photo-1604866830893-c13cafa515d5?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
GO

select * from Category

-- Insert initial subcategories
select * from Subcategory
INSERT INTO dbo.Subcategory (category_id, subcategory_name)
VALUES
    (1, N'Nam'),
    (1, N'Nữ'),
    (1, N'Trẻ em'),
    (1, N'Giày dép'),
    (1, N'Đồ ngủ / đồ lót');

INSERT INTO dbo.Subcategory (category_id, subcategory_name)
VALUES
    (2, N'Sổ tay & giấy ghi chú'),
    (2, N'Bút & bút chì'),
    (2, N'File, bìa, kẹp tài liệu'),
    (2, N'Dụng cụ học tập'),
    (2, N'Mực / mực in');




INSERT INTO dbo.Product
(subcategory_id, product_name, description, price, stock_quantity, image_url)
VALUES
    (1, N'Áo thun basic nam',              N'Áo thun cotton 100% form regular',                     149000.00, 120, 'https://picsum.photos/id/1011/800/800'),
    (1, N'Áo thun oversize trơn',          N'Form rộng, chất cotton 2 chiều',                       169000.00,  90, 'https://picsum.photos/id/1012/800/800'),
    (1, N'Áo polo nam cổ bẻ',              N'Piqué co giãn nhẹ, thoáng mát',                         199000.00,  85, 'https://picsum.photos/id/1013/800/800'),
    (1, N'Áo sơ mi trắng slim-fit',        N'Vải poplin, chống nhăn nhẹ',                            259000.00,  70, 'https://picsum.photos/id/1014/800/800'),
    (1, N'Áo sơ mi caro dài tay',          N'Kiểu caro basic, form regular',                         279000.00,  65, 'https://picsum.photos/id/1015/800/800'),
    (1, N'Áo hoodie nỉ mỏng',              N'Khoá kéo, có túi kenguru',                              329000.00,  55, 'https://picsum.photos/id/1016/800/800'),
    (1, N'Áo khoác bomber',                N'Vải dù nhẹ, lót lưới',                                  399000.00,  40, 'https://picsum.photos/id/1018/800/800'),
    (1, N'Áo khoác denim xanh',            N'Jean wash nhẹ, 2 túi ngực',                             459000.00,  35, 'https://picsum.photos/id/1019/800/800'),
    (1, N'Áo len cổ tròn',                 N'Len acrylic mềm, ấm',                                   349000.00,  50, 'https://picsum.photos/id/1020/800/800'),
    (1, N'Áo len cổ tim',                  N'Len đan mịn, không xù lông',                            359000.00,  45, 'https://picsum.photos/id/1021/800/800'),
    (1, N'Quần jean slim xanh đậm',        N'Jean co giãn 1%, 5 túi',                                399000.00,  90, 'https://picsum.photos/id/1022/800/800'),
    (1, N'Quần jean skinny đen',           N'Ôm sát, wash đen than',                                 419000.00,  80, 'https://picsum.photos/id/1023/800/800'),
    (1, N'Quần chinos kaki be',            N'Vải kaki mềm, đứng form',                               339000.00,  70, 'https://picsum.photos/id/1024/800/800'),
    (1, N'Quần chinos xanh navy',          N'Cạp chuẩn, 2 túi chéo',                                 339000.00,  60, 'https://picsum.photos/id/1025/800/800'),
    (1, N'Quần jogger nỉ',                 N'Bo gấu, dây rút, thoải mái',                            299000.00,  95, 'https://picsum.photos/id/1026/800/800'),
    (1, N'Quần jogger kaki',               N'Chất kaki co giãn nhẹ',                                 329000.00,  55, 'https://picsum.photos/id/1027/800/800'),
    (1, N'Quần short jean nam',            N'Xanh nhạt rách nhẹ',                                    279000.00,  85, 'https://picsum.photos/id/1028/800/800'),
    (1, N'Quần short kaki',                N'5 màu cơ bản, form regular',                            259000.00, 100, 'https://picsum.photos/id/1029/800/800'),
    (1, N'Quần short thể thao',            N'Polyester thoáng khí, nhanh khô',                       199000.00, 120, 'https://picsum.photos/id/1030/800/800'),
    (1, N'Áo ba lỗ thể thao',              N'Chất dry-fit, hút ẩm tốt',                              159000.00, 110, 'https://picsum.photos/id/1031/800/800'),
    (1, N'Áo tanktop gym',                 N'Form rộng, thoáng mát',                                 149000.00,  95, 'https://picsum.photos/id/1032/800/800'),
    (1, N'Áo khoác gió nam',               N'Chống nước nhẹ, chống gió',                             379000.00,  40, 'https://picsum.photos/id/1033/800/800'),
    (1, N'Áo blazer nam',                  N'Poly-viscose, mặc công sở',                             789000.00,  25, 'https://picsum.photos/id/1035/800/800'),
    (1, N'Áo vest 2 khuy',                 N'Form slim, may đo chuẩn size',                          999000.00,  15, 'https://picsum.photos/id/1036/800/800'),
    (1, N'Áo thun graphic',                N'In hình trước ngực, cotton 2 chiều',                    189000.00, 130, 'https://picsum.photos/id/1037/800/800'),
    (1, N'Áo thun sọc ngang',              N'Sọc basic, dễ phối',                                    179000.00, 100, 'https://picsum.photos/id/1038/800/800'),
    (1, N'Áo cardigan nam',                N'Cài khuy, len mỏng',                                     369000.00,  45, 'https://picsum.photos/id/1039/800/800'),
    (1, N'Áo bomber da PU',                N'Giả da, cổ bo, phong cách',                             589000.00,  20, 'https://picsum.photos/id/1040/800/800'),
    (1, N'Áo khoác dạ dài',                N'2 lớp, giữ ấm tốt',                                     899000.00,  10, 'https://picsum.photos/id/1041/800/800'),
    (1, N'Áo khoác puffer',                N'Phồng nhẹ, ấm, chống gió',                              659000.00,  30, 'https://picsum.photos/id/1042/800/800'),
    (1, N'Áo sweater in chữ',              N'Nỉ bông, in nổi',                                       299000.00,  60, 'https://picsum.photos/id/1043/800/800'),
    (1, N'Áo sweater trơn',                N'Màu pastel, unisex',                                    289000.00,  65, 'https://picsum.photos/id/1044/800/800'),
    (1, N'Áo dài tay henley',              N'3 nút cổ, cotton dày',                                  219000.00,  55, 'https://picsum.photos/id/1045/800/800'),
    (1, N'Áo cổ lọ nam',                   N'Len gân, ôm nhẹ cổ',                                    329000.00,  35, 'https://picsum.photos/id/1047/800/800'),
    (1, N'Bộ đồ ngủ nam cotton',           N'Áo quần dài, mềm mại',                                  319000.00,  50, 'https://picsum.photos/id/1048/800/800'),
    (1, N'Bộ đồ thể thao 2 mảnh',          N'Áo khoác + quần jogger',                                499000.00,  35, 'https://picsum.photos/id/1049/800/800'),
    (1, N'Áo sơ mi họa tiết',              N'In hoa văn nhẹ, dạo phố',                               299000.00,  45, 'https://picsum.photos/id/1050/800/800'),
    (1, N'Áo sơ mi kẻ sọc',                N'Sọc dọc, tạo cảm giác cao',                             289000.00,  60, 'https://picsum.photos/id/1051/800/800'),
    (1, N'Áo thun cổ tim',                 N'V kiểu basic, cotton 100%',                             159000.00, 140, 'https://picsum.photos/id/1052/800/800'),
    (1, N'Áo thun cổ tròn dài tay',        N'Cotton dày, giữ ấm',                                    199000.00,  80, 'https://picsum.photos/id/1053/800/800'),
    (1, N'Áo khoác cardigan len dệt',      N'Len dệt caro, ấm',                                      449000.00,  25, 'https://picsum.photos/id/1054/800/800'),
    (1, N'Áo gile len',                    N'Nỉ len, mặc layer',                                     269000.00,  40, 'https://picsum.photos/id/1055/800/800'),
    (1, N'Áo khoác field jacket',          N'Nhiều túi, phong cách lính',                            649000.00,  18, 'https://picsum.photos/id/1056/800/800'),
    (1, N'Áo khoác trench coat',           N'Dáng dài, chất kaki dày',                               959000.00,  12, 'https://picsum.photos/id/1057/800/800'),
    (1, N'Áo khoác varsity',               N'Tay da PU, thân nỉ',                                    579000.00,  22, 'https://picsum.photos/id/1058/800/800'),
    (1, N'Áo thun không tay',              N'Cut-off sleeve, streetwear',                            139000.00,  90, 'https://picsum.photos/id/1059/800/800'),
    (1, N'Áo thun tie-dye',                N'Nhuộm loang, độc lạ',                                   209000.00,  55, 'https://picsum.photos/id/1060/800/800'),
    (1, N'Áo thun cổ tròn slim',           N'Ôm body, co giãn 4 chiều',                              179000.00, 100, 'https://picsum.photos/id/1061/800/800'),
    (1, N'Áo sơ mi linen',                 N'Linen thoáng mát, mùa hè',                              369000.00,  30, 'https://picsum.photos/id/1062/800/800'),
    (1, N'Áo sơ mi flannel',               N'Flannel ấm, kẻ caro',                                   329000.00,  35, 'https://picsum.photos/id/1063/800/800');
GO

select * from Product
select * from Subcategory
select * from Category

UPDATE dbo.Subcategory SET image_url = 'https://picsum.photos/id/237/800/800' WHERE subcategory_id = 1;
UPDATE dbo.Subcategory SET image_url = 'https://picsum.photos/id/238/800/800' WHERE subcategory_id = 2;
UPDATE dbo.Subcategory SET image_url = 'https://picsum.photos/id/239/800/800' WHERE subcategory_id = 3;
UPDATE dbo.Subcategory SET image_url = 'https://picsum.photos/id/240/800/800' WHERE subcategory_id = 4;
UPDATE dbo.Subcategory SET image_url = 'https://picsum.photos/id/241/800/800' WHERE subcategory_id = 5;
UPDATE dbo.Subcategory SET image_url = 'https://picsum.photos/id/242/800/800' WHERE subcategory_id = 6;
GO