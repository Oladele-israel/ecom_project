/*
  Warnings:

  - You are about to drop the `BuyerProfile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Cart` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CartItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Inventory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Order` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OrderItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OrderVendor` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Product` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProductAttribute` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ProductImage` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SellerProfile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "BuyerProfile" DROP CONSTRAINT "BuyerProfile_userId_fkey";

-- DropForeignKey
ALTER TABLE "Cart" DROP CONSTRAINT "Cart_buyerId_fkey";

-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_cartId_fkey";

-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_productId_fkey";

-- DropForeignKey
ALTER TABLE "CartItem" DROP CONSTRAINT "CartItem_sellerProfileId_fkey";

-- DropForeignKey
ALTER TABLE "Category" DROP CONSTRAINT "Category_sellerProfileId_fkey";

-- DropForeignKey
ALTER TABLE "Conversation" DROP CONSTRAINT "Conversation_orderVendorId_fkey";

-- DropForeignKey
ALTER TABLE "Inventory" DROP CONSTRAINT "Inventory_productId_fkey";

-- DropForeignKey
ALTER TABLE "Inventory" DROP CONSTRAINT "Inventory_sellerProfileId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_userId_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_buyerId_fkey";

-- DropForeignKey
ALTER TABLE "OrderItem" DROP CONSTRAINT "OrderItem_orderVendorId_fkey";

-- DropForeignKey
ALTER TABLE "OrderItem" DROP CONSTRAINT "OrderItem_productId_fkey";

-- DropForeignKey
ALTER TABLE "OrderVendor" DROP CONSTRAINT "OrderVendor_orderId_fkey";

-- DropForeignKey
ALTER TABLE "OrderVendor" DROP CONSTRAINT "OrderVendor_sellerProfileId_fkey";

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_sellerProfileId_fkey";

-- DropForeignKey
ALTER TABLE "ProductAttribute" DROP CONSTRAINT "ProductAttribute_productId_fkey";

-- DropForeignKey
ALTER TABLE "ProductImage" DROP CONSTRAINT "ProductImage_productId_fkey";

-- DropForeignKey
ALTER TABLE "SellerProfile" DROP CONSTRAINT "SellerProfile_userId_fkey";

-- DropTable
DROP TABLE "BuyerProfile";

-- DropTable
DROP TABLE "Cart";

-- DropTable
DROP TABLE "CartItem";

-- DropTable
DROP TABLE "Category";

-- DropTable
DROP TABLE "Inventory";

-- DropTable
DROP TABLE "Order";

-- DropTable
DROP TABLE "OrderItem";

-- DropTable
DROP TABLE "OrderVendor";

-- DropTable
DROP TABLE "Product";

-- DropTable
DROP TABLE "ProductAttribute";

-- DropTable
DROP TABLE "ProductImage";

-- DropTable
DROP TABLE "SellerProfile";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "passwordHash" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "buyer_profile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "address" TEXT,

    CONSTRAINT "buyer_profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "seller_profile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "photo" TEXT NOT NULL,

    CONSTRAINT "seller_profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "category" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sellerProfileId" TEXT,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "price" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'NGN',
    "status" "ProductStatus" NOT NULL,
    "sellerProfileId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_images" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "url" TEXT NOT NULL,

    CONSTRAINT "product_images_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_attributes" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "context" JSONB,

    CONSTRAINT "product_attributes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_inventory" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "reservedQuantity" INTEGER NOT NULL DEFAULT 0,
    "lowStockThreshold" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "sellerProfileId" TEXT,

    CONSTRAINT "product_inventory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cart" (
    "id" TEXT NOT NULL,
    "buyerId" TEXT NOT NULL,
    "status" "CartStatus" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cart_items" (
    "id" TEXT NOT NULL,
    "cartId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "sellerProfileId" TEXT,

    CONSTRAINT "cart_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order" (
    "id" TEXT NOT NULL,
    "buyerId" TEXT NOT NULL,
    "totalAmount" DECIMAL(10,2) NOT NULL,
    "status" "OrderStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_vendor" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "subtotal" DECIMAL(10,2) NOT NULL,
    "status" "VendorOrderStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sellerProfileId" TEXT,

    CONSTRAINT "order_vendor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_items" (
    "id" TEXT NOT NULL,
    "orderVendorId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "order_items_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_phone_key" ON "users"("phone");

-- CreateIndex
CREATE INDEX "users_role_idx" ON "users"("role");

-- CreateIndex
CREATE UNIQUE INDEX "buyer_profile_userId_key" ON "buyer_profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "seller_profile_userId_key" ON "seller_profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "category_id_key" ON "category"("id");

-- CreateIndex
CREATE INDEX "products_categoryId_status_idx" ON "products"("categoryId", "status");

-- CreateIndex
CREATE INDEX "product_images_productId_idx" ON "product_images"("productId");

-- CreateIndex
CREATE INDEX "product_attributes_productId_idx" ON "product_attributes"("productId");

-- CreateIndex
CREATE UNIQUE INDEX "product_inventory_productId_key" ON "product_inventory"("productId");

-- CreateIndex
CREATE INDEX "cart_buyerId_status_idx" ON "cart"("buyerId", "status");

-- CreateIndex
CREATE INDEX "cart_items_cartId_idx" ON "cart_items"("cartId");

-- CreateIndex
CREATE INDEX "order_buyerId_idx" ON "order"("buyerId");

-- CreateIndex
CREATE INDEX "order_items_orderVendorId_idx" ON "order_items"("orderVendorId");

-- AddForeignKey
ALTER TABLE "buyer_profile" ADD CONSTRAINT "buyer_profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seller_profile" ADD CONSTRAINT "seller_profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "category" ADD CONSTRAINT "category_sellerProfileId_fkey" FOREIGN KEY ("sellerProfileId") REFERENCES "seller_profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_sellerProfileId_fkey" FOREIGN KEY ("sellerProfileId") REFERENCES "seller_profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_images" ADD CONSTRAINT "product_images_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_attributes" ADD CONSTRAINT "product_attributes_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_inventory" ADD CONSTRAINT "product_inventory_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_inventory" ADD CONSTRAINT "product_inventory_sellerProfileId_fkey" FOREIGN KEY ("sellerProfileId") REFERENCES "seller_profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "cart_buyerId_fkey" FOREIGN KEY ("buyerId") REFERENCES "buyer_profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "cart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_sellerProfileId_fkey" FOREIGN KEY ("sellerProfileId") REFERENCES "seller_profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_buyerId_fkey" FOREIGN KEY ("buyerId") REFERENCES "buyer_profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_vendor" ADD CONSTRAINT "order_vendor_sellerProfileId_fkey" FOREIGN KEY ("sellerProfileId") REFERENCES "seller_profile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_vendor" ADD CONSTRAINT "order_vendor_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_items" ADD CONSTRAINT "order_items_orderVendorId_fkey" FOREIGN KEY ("orderVendorId") REFERENCES "order_vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_items" ADD CONSTRAINT "order_items_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Conversation" ADD CONSTRAINT "Conversation_orderVendorId_fkey" FOREIGN KEY ("orderVendorId") REFERENCES "order_vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
