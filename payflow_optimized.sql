-- HỆ THỐNG PAYFLOW (OPTIMIZED SCRIPT)
CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

DROP TABLE IF EXISTS Transactions;

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20), -- 'DEPOSIT', 'WITHDRAW', 'TRANSFER'
    created_at DATETIME
);

-- Thiết kế Composite Index tối ưu trên 2 cột lọc chính
CREATE INDEX idx_type_date ON Transactions(transaction_type, created_at);

-- ========================================================
-- BÁO CÁO ĐÃ ĐƯỢC TỐI ƯU HÓA (Loại bỏ hàm YEAR/MONTH, dùng Range SARGable)
-- ========================================================
EXPLAIN 
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT' 
  AND created_at >= '2026-06-01 00:00:00' 
  AND created_at < '2026-07-01 00:00:00';
