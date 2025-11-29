-- 2_constrains.sql
USE foodhall;

--pastiin StallSchedule itu ada sebelum menambahkan CHECK
ALTER TABLE StallSchedule
  ADD CONSTRAINT chk_time CHECK (open_time < close_time);

ALTER TABLE MenuItem
  ADD CONSTRAINT chk_price CHECK (price >= 0);

ALTER TABLE OrderItem
  ADD CONSTRAINT chk_qty CHECK (quantity > 0);
