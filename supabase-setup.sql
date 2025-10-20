-- Users tablosu
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

-- Orders tablosu
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

-- Sales tablosu
CREATE TABLE sales (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL,
  payment_method VARCHAR NOT NULL,
  sale_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Support Messages tablosu
CREATE TABLE support_messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  message TEXT NOT NULL,
  is_from_admin BOOLEAN DEFAULT false,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Settings tablosu
CREATE TABLE settings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  payment_settings JSONB DEFAULT '{}',
  station_config VARCHAR DEFAULT 'separate',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Row Level Security (RLS) Policies
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE sales ENABLE ROW LEVEL SECURITY;
ALTER TABLE support_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

-- Users policies
CREATE POLICY "Users can view own data" ON users
  FOR SELECT USING (auth.uid()::text = id::text);

CREATE POLICY "Users can update own data" ON users
  FOR UPDATE USING (auth.uid()::text = id::text);

-- Orders policies
CREATE POLICY "Users can view own orders" ON orders
  FOR SELECT USING (user_id::text = auth.uid()::text);

CREATE POLICY "Users can insert own orders" ON orders
  FOR INSERT WITH CHECK (user_id::text = auth.uid()::text);

CREATE POLICY "Users can update own orders" ON orders
  FOR UPDATE USING (user_id::text = auth.uid()::text);

CREATE POLICY "Users can delete own orders" ON orders
  FOR DELETE USING (user_id::text = auth.uid()::text);

-- Sales policies
CREATE POLICY "Users can view own sales" ON sales
  FOR SELECT USING (user_id::text = auth.uid()::text);

CREATE POLICY "Users can insert own sales" ON sales
  FOR INSERT WITH CHECK (user_id::text = auth.uid()::text);

-- Support messages policies
CREATE POLICY "Users can view own messages" ON support_messages
  FOR SELECT USING (user_id::text = auth.uid()::text);

CREATE POLICY "Users can insert own messages" ON support_messages
  FOR INSERT WITH CHECK (user_id::text = auth.uid()::text);

-- Settings policies
CREATE POLICY "Users can view own settings" ON settings
  FOR SELECT USING (user_id::text = auth.uid()::text);

CREATE POLICY "Users can insert own settings" ON settings
  FOR INSERT WITH CHECK (user_id::text = auth.uid()::text);

CREATE POLICY "Users can update own settings" ON settings
  FOR UPDATE USING (user_id::text = auth.uid()::text);