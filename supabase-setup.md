# Supabase Kurulum Rehberi

## 1. Supabase Projesi Oluşturma
1. https://supabase.com adresine git
2. "Start your project" butonuna tıkla
3. GitHub ile giriş yap
4. "New Project" butonuna tıkla
5. Proje adı: "dkw-restaurant-system"
6. Database password: güçlü bir şifre seç
7. Region: Frankfurt (eu-central-1) seç
8. "Create new project" butonuna tıkla

## 2. Veritabanı Tabloları Oluşturma

### Users Tablosu
```sql
CREATE TABLE users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email VARCHAR UNIQUE NOT NULL,
  restaurant_name VARCHAR NOT NULL,
  phone VARCHAR,
  contact_person VARCHAR,
  address TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Orders Tablosu
```sql
CREATE TABLE orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  order_number VARCHAR NOT NULL,
  customer_name VARCHAR,
  items JSONB NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  status VARCHAR DEFAULT 'new',
  payment_method VARCHAR,
  order_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  completed_time TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Sales Tablosu
```sql
CREATE TABLE sales (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL,
  payment_method VARCHAR NOT NULL,
  sale_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Support Messages Tablosu
```sql
CREATE TABLE support_messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  message TEXT NOT NULL,
  is_from_admin BOOLEAN DEFAULT false,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Settings Tablosu
```sql
CREATE TABLE settings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  payment_settings JSONB DEFAULT '{}',
  station_config VARCHAR DEFAULT 'separate',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## 3. Row Level Security (RLS) Politikaları

### Users Tablosu
```sql
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Admin tüm kullanıcıları görebilir
CREATE POLICY "Admin can view all users" ON users
  FOR SELECT USING (auth.jwt() ->> 'role' = 'admin');

-- Kullanıcılar sadece kendi bilgilerini görebilir
CREATE POLICY "Users can view own data" ON users
  FOR SELECT USING (auth.uid() = id);
```

### Orders Tablosu
```sql
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Kullanıcılar sadece kendi siparişlerini görebilir
CREATE POLICY "Users can view own orders" ON orders
  FOR ALL USING (auth.uid() = user_id);

-- Admin tüm siparişleri görebilir
CREATE POLICY "Admin can view all orders" ON orders
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
```

## 4. Environment Variables
Proje kök dizininde `.env` dosyası oluştur:
```env
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
```

## 5. Supabase Client Kurulumu
```bash
npm install @supabase/supabase-js
```