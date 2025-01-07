// header
const darkBg = document.querySelector('.dark-transparent-bg');
const menuBtn = document.querySelector('.menu-btn');
const closeBtn = document.querySelector('.close-btn');
const header = document.querySelector('.header');
const selectLangBtn = document.querySelector('.select-language');

function openSidebar() {
    document.querySelector('.sidebar').classList.add('active');
    darkBg.classList.add('active');
    document.querySelector('.header').classList.add('active');
    menuBtn.style.display = 'none';
    closeBtn.style.display = 'block';
}

function closeSidebar() {
    document.querySelector('.sidebar').classList.remove('active');
    document.querySelector('.header').classList.remove('active');
    darkBg.classList.remove('active');
    menuBtn.style.display = 'block';
    closeBtn.style.display = 'none';
}

function toggleLangDropdown() {
    selectLangBtn.classList.toggle('active');
}

menuBtn.addEventListener('click', openSidebar);
closeBtn.addEventListener('click', closeSidebar);
darkBg.addEventListener('click', closeSidebar);

selectLangBtn.addEventListener('click', toggleLangDropdown);



// Biến lưu trữ giỏ hàng
let cart = [];

// Biến tạm lưu sản phẩm đang được chọn trong modal
let selectedProduct = null;

// Hàm hiển thị modal sản phẩm
function showProductInfo(name, price, description, image) {
    selectedProduct = {
        name,
        price: parseFloat(price), // Đảm bảo giá được chuyển đổi thành số
        description,
        image
    };
    document.getElementById("productName").innerText = name;
    document.getElementById("productPrice").innerText = price.toLocaleString();
    document.getElementById("productDescription").innerText = description;
    document.getElementById("productImage").src = image;
    document.getElementById("productModal").style.display = "block";
}


// Hàm cập nhật hiển thị giỏ hàng
function updateCartDisplay() {
    const cartContainer = document.querySelector('.giohang');
    const cartCountElement = document.querySelector('.cart-count');
    const totalPriceElement = document.querySelector('.total-price');
    const taxElement = document.querySelector('.tax');
    const grandTotalElement = document.querySelector('.grand-total');

    // Xóa nội dung cũ
    cartContainer.innerHTML = '';

    if (cart.length === 0) {
        cartContainer.innerHTML = '<p class="empty">Giỏ hàng trống</p>';
        cartCountElement.innerText = '0';
        totalPriceElement.innerText = '0đ';
        taxElement.innerText = '0đ';
        grandTotalElement.innerText = '0đ';
        return;
    }

    let totalPrice = 0;
    cart.forEach(item => {
        totalPrice += item.price * item.quantity;
        const productElement = document.createElement('div');
        productElement.classList.add('product');
        productElement.innerHTML = `
            <p>${item.name} (x${item.quantity})</p>
            <p>${(item.price * item.quantity).toLocaleString()}đ</p>
            <button class="btn" onclick="removeFromCart('${item.name}')">Xóa</button>
        `;
        cartContainer.appendChild(productElement);
    });

    const tax = totalPrice * 0.01;
    const grandTotal = totalPrice + tax;

    cartCountElement.innerText = cart.length;
    totalPriceElement.innerText = totalPrice.toLocaleString() + 'đ';
    taxElement.innerText = tax.toLocaleString() + 'đ';
    grandTotalElement.innerText = grandTotal.toLocaleString() + 'đ';
}
// Hàm định dạng số tiền
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
}


// Hàm hiển thị giỏ hàng bằng alert (tùy chọn)
function viewCart() {
    alert("Giỏ hàng của bạn:\n" + cart.map(item => `${item.name} (x${item.quantity}) - ${item.price * item.quantity}đ`).join("\n"));
}


// Hàm xóa sản phẩm khỏi giỏ hàng
function removeFromCart(productName) {
    cart = cart.filter(item => item.name !== productName);
    updateCartDisplay();
}

// Sự kiện khi nhấn vào nút "Đặt mua"
document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll(".order-btn").forEach(button => {
        button.addEventListener("click", function() {
            addToCart(this);
        });
    });
});


// Hàm đóng modal
function closeModal() {
    document.getElementById("productModal").style.display = "none";
    selectedProduct = null;
}

// Gắn sự kiện cho nút Đồng ý trong modal
document.getElementById("confirmAddToCart").addEventListener("click", addToCart);