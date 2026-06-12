-- 修复数据库权限
ALTER TABLE customers DISABLE ROW LEVEL SECURITY;
ALTER TABLE bills DISABLE ROW LEVEL SECURITY;
GRANT ALL ON customers TO anon;
GRANT ALL ON bills TO anon;
GRANT ALL ON customers TO authenticated;
GRANT ALL ON bills TO authenticated;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
