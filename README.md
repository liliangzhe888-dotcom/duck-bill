# 🦆 烤鸭送货记账 — 云端版

一个为老大定制的极简、大字、手机友好的烤鸭送货记账网页，数据存于 [Supabase](https://supabase.com) 云端，免费、安全、永不丢失。

> 💡 **一句话说明**：用手机打开网页 → 记账 → 查谁欠钱 → 一键导出 Excel 发给客户对账

---

## ✅ 功能亮点

- **极简大字界面**：所有文字 ≥ 20px，按钮 ≥ 50px，拇指友好，专为手机设计
- **云端存储**：数据存在 Supabase（免费 tier），换手机、清缓存也不丢
- **记住登录**：首次登录后，30 天内打开网页自动进入，无需重复输入密码
- **Excel 导出**：点击「导出为 Excel (.xlsx)」，生成正规表格，可直接微信转发对账
- **单页应用**：记账 / 查欠款 / 客户管理，一个页面全搞定，不跳转、不晕眩
- **免费部署**：一键部署到 Vercel，零服务器、零运维、零费用

---

## ⚙️ 快速开始（Supabase 配置）

### 1. 创建 Supabase 项目
- 访问 [Supabase Dashboard](https://app.supabase.com)
- 点击「New project」→ 填写项目名（如 `duck-bill`）、区域（选 `US East (Virginia)`）、密码
- 等待项目创建完成（约 1 分钟）

### 2. 创建数据库表
在 Supabase 项目中：
- 进入 **Table Editor** → 「Create a new table」
- 创建 `customers` 表：
  - `id` (UUID, Primary Key, default: `gen_random_uuid()`)
  - `name` (Text, required)
  - `price` (Numeric, required)
- 创建 `bills` 表：
  - `id` (UUID, Primary Key, default: `gen_random_uuid()`)
  - `customer_id` (UUID, Foreign Key → `customers.id`)
  - `qty` (Integer, required)
  - `amount` (Numeric, required)
  - `paid` (Boolean, default: `false`)
  - `date` (Date, required)

### 3. 添加 PostgreSQL 函数（用于查欠款）
在 Supabase **SQL Editor** 中运行：
```sql
create or replace function get_accounts_receivable()
returns table(name text, ar numeric, last_date date)
as $$
  select 
    c.name,
    sum(b.amount) as ar,
    max(b.date) as last_date
  from bills b
  join customers c on b.customer_id = c.id
  where b.paid = false
  group by c.name
  order by ar desc;
$$ language sql;
```

### 4. 获取 API 密钥
- 进入 **Project Settings → API**
- 复制 `Project URL`（形如 `https://xxx.supabase.co`）
- 复制 `anon public key`（以 `eyJhbGciOi...` 开头）

### 5. 替换 index.html 中的密钥
打开 `index.html`，搜索并替换：
- `https://your-project.supabase.co` → 你的 Project URL
- `your-anon-key` → 你的 anon public key

---

## 🚀 部署到 Vercel

1. 将本目录初始化为 Git 仓库：
   ```bash
   cd "D:\Vibe Coding\cchaha6月12日烤鸭记账"
   git init
   git add .
   git commit -m "feat: initial commit"
   ```
2. 登录 [Vercel Dashboard](https://vercel.com/dashboard)
3. 点击「Add New Project」→ 「Import Git Repository」
4. 选择本仓库 → 点击「Deploy」
5. 部署完成后，访问生成的 `xxx.vercel.app` 链接即可使用！

> ⚠️ **注意**：Vercel 免费版 30 天无访问会休眠，首次打开需 2~5 秒唤醒，后续秒开。

---

## 📱 使用说明（给老大）

- **记账**：点顶部「📝 记账」→ 输入客户名 → 填数量 → 选「赊账/已付」→ 点「✅ 记录本单」
- **查欠款**：点「💰 查欠款」→ 看谁还欠钱 → 点「📥 导出为 Excel」生成表格发微信
- **客户管理**：点「👥 客户管理」→ 添加新客户（不同客户可设不同单价）
- **登录**：首次使用点右上角「登录」→ 输入邮箱密码 → 之后自动记住

---

## 🛠️ 技术栈
- 前端：纯 HTML/CSS/JS（零框架，内联全栈）
- 数据库：Supabase（PostgreSQL + Auth）
- 部署：Vercel（静态托管）
- Excel：SheetJS（xlsx.min.js）

---

> ✨ 本项目由老六（Claude Code）与老二（Hermes）联合打造，专为老大服务。有任何问题，随时喊我们！

---

[![Vercel](https://vercel.com/button)](https://vercel.com/new/git/external?repository-url=https%3A%2F%2Fgithub.com%2Fuser%2Fduck-bill&project-name=duck-bill&repo-name=duck-bill)