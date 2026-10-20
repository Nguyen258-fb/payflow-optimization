# Phân tích EXPLAIN trước và sau khi tối ưu hệ thống PayFlow

## 1. Trước khi tối ưu (Truy vấn lỗi dùng hàm YEAR và MONTH)
- **Cột type**: `ALL` (Quét toàn bộ bảng - Full Table Scan).
- **Cột possible_keys / key**: `NULL` (Không sử dụng được Index).
- **Cột rows**: Quét toàn bộ 5,000,000 dòng dữ liệu, làm CPU vọt lên 100% và gây khóa bảng trong 45 giây.
- **Nguyên nhân**: Việc bọc hàm `YEAR(created_at)` và `MONTH(created_at)` biến truy vấn thành **Non-SARGable**, làm mất hiệu lực cấu trúc cây B-Tree của Index.

## 2. Sau khi tối ưu (Dùng Composite Index và Range Condition)
- **Cột type**: `range` (Sử dụng Index Range Scan hiệu quả).
- **Cột possible_keys / key**: `idx_type_date`.
- **Cột rows**: Giảm từ 5 triệu dòng xuống chỉ còn vài nghìn dòng thực tế cần quét.
- **Kết quả**: Thời gian thực thi giảm từ 45 giây xuống dưới 0.1 giây, giải phóng tài nguyên CPU và loại bỏ hoàn toàn lỗi Timeout.
