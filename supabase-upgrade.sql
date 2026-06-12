-- 🔹 为 bills 表添加 delivered_qty 字段（允许 NULL，旧数据自动设为 ordered_qty）
alter table bills
add column if not exists delivered_qty integer;

-- 🔹 设置默认值：旧记录的 delivered_qty = ordered_qty
update bills
set delivered_qty = qty
where delivered_qty is null;

-- 🔹 （可选）添加检查约束：delivered_qty ≤ ordered_qty（防输入错误）
-- alter table bills add constraint chk_delivered_le_ordered check (delivered_qty <= qty);