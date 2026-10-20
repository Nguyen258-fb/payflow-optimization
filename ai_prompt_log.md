# Nhật ký tương tác AI (AI Prompt Log)

- **Câu hỏi 1 (Brainstorm về Non-SARGable):** 
  *"Trong MySQL, nếu tôi tạo Index cho một cột ngày tháng, nhưng trong mệnh đề WHERE tôi lại viết WHERE YEAR(col) = 2026, tại sao MySQL lại từ chối sử dụng Index và phải quét toàn bộ bảng (Full Table Scan)?"*
  - **Phản hồi tóm tắt từ AI:** Việc bọc cột trong một hàm (`YEAR()`) biến biểu thức thành Non-SARGable, bắt buộc cơ sở dữ liệu phải thực thi hàm trên mọi giá trị của từng dòng trước khi so sánh, làm vô hiệu hóa cơ chế tìm kiếm nhị phân của B-Tree Index.

- **Câu hỏi 2 (Logic thiết kế Composite Index):** 
  *"Khi thiết kế một Composite Index trong MySQL cho cột (transaction_type, created_at), thứ tự các cột trong Index có quan trọng không? Tôi nên đặt cột nào đứng trước để có hiệu suất lọc dữ liệu tốt nhất?"*
  - **Phản hồi tóm tắt từ AI:** Thứ tự rất quan trọng. Cột có tính chọn lọc cao hoặc được lọc bằng toán tử bằng (`=`) như `transaction_type` nên đứng ở vị trí đầu tiên, tiếp theo mới đến cột dùng cho dải giá trị (`created_at`).

- **Câu hỏi 3 (Phân tích Extra):** 
  *"Trong kết quả EXPLAIN, cột 'Extra' hiện chữ 'Using index condition' khác gì với 'Using index' (Covering Index)?"*
  - **Phản hồi tóm tắt từ AI:** 'Using index' là Covering Index (lấy dữ liệu trực tiếp từ Index mà không cần đọc bảng). 'Using index condition' (ICP) là kỹ thuật đẩy một phần điều kiện xuống tầng storage engine để lọc bớt dữ liệu trước khi truy xuất bảng gốc, giúp tối ưu hóa đáng kể so với quét toàn bảng.
