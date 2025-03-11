### **Mô hình Logout JWT trên nhiều thiết bị**  

JWT (JSON Web Token) không có cơ chế tự động thu hồi token như session-based authentication, vì vậy việc logout trên nhiều thiết bị đòi hỏi một cách tiếp cận đặc biệt. Dưới đây là các mô hình phổ biến để xử lý logout JWT trên nhiều thiết bị.  

---

## **1. Mô hình lưu danh sách token hợp lệ (Token Allowlist)**  
**Cách hoạt động:**  
- Khi người dùng đăng nhập, JWT sẽ được lưu vào một danh sách hợp lệ (Allowlist) trên server hoặc database.  
- Khi logout, token của thiết bị đó sẽ bị xóa khỏi danh sách này.  
- Mọi request từ các thiết bị khác phải kiểm tra token có trong danh sách không.  

🔹 **Ưu điểm:**  
✔️ Dễ triển khai.  
✔️ Kiểm soát chính xác những token nào còn hiệu lực.  

🔸 **Nhược điểm:**  
❌ Tăng tải cho database do phải kiểm tra danh sách hợp lệ.  
❌ Không thể logout ngay lập tức nếu token đã được cache.  

---

## **2. Mô hình lưu danh sách token bị thu hồi (Token Blacklist)**  
**Cách hoạt động:**  
- Khi một thiết bị logout, token của nó được thêm vào danh sách đen (Blacklist).  
- Mọi request phải kiểm tra token có trong blacklist không trước khi xử lý.  

🔹 **Ưu điểm:**  
✔️ Hỗ trợ nhiều thiết bị và có thể force logout token bất kỳ.  
✔️ Có thể triển khai với Redis để tối ưu hiệu suất.  

🔸 **Nhược điểm:**  
❌ Nếu JWT có thời gian sống dài, danh sách blacklist có thể trở nên lớn.  
❌ Không chặn được token đã bị đánh cắp nếu chưa bị thêm vào blacklist.  

---

## **3. Mô hình Refresh Token + Revoke Strategy**  
**Cách hoạt động:**  
- JWT có thời gian sống ngắn (ví dụ: 15 phút), nhưng mỗi lần đăng nhập cũng cấp thêm **refresh token** dài hạn.  
- Khi người dùng logout, refresh token bị xóa khỏi database.  
- Access token hết hạn sau thời gian ngắn nên ngay cả khi bị đánh cắp, nó cũng không còn tác dụng lâu.  

🔹 **Ưu điểm:**  
✔️ Tăng cường bảo mật, hạn chế rủi ro bị đánh cắp JWT.  
✔️ Dễ dàng force logout tất cả thiết bị khi xóa refresh token.  

🔸 **Nhược điểm:**  
❌ Cần quản lý danh sách refresh token.  
❌ Nếu access token chưa hết hạn, user vẫn có thể tiếp tục gửi request cho đến khi hết hạn.  

---

## **4. Mô hình Token Versioning (Token Rotation)**
**Cách hoạt động:**  
- Khi người dùng đăng nhập, hệ thống cấp một **version ID** cho JWT.  
- Khi logout trên một thiết bị, chỉ cần tăng **version ID** của user trên server.  
- Mọi request từ JWT cũ có version ID thấp hơn sẽ bị từ chối.  

🔹 **Ưu điểm:**  
✔️ Không cần lưu danh sách blacklist.  
✔️ Hiệu suất tốt hơn do không phải tra cứu database thường xuyên.  

🔸 **Nhược điểm:**  
❌ Cần thiết kế thêm cơ chế quản lý version ID trong database.  

---

## **Kết luận: Chọn mô hình nào?**  
🔹 Nếu muốn **đơn giản và hiệu quả** → **Token Blacklist với Redis**.  
🔹 Nếu muốn **bảo mật tốt hơn** → **Refresh Token + Revoke Strategy**.  
🔹 Nếu muốn **hiệu suất cao nhất** → **Token Versioning**.  
