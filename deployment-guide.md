# DKW Restaurant System - Deployment Guide

## 1. Supabase Kurulumu

### 1.1 Supabase Projesi Oluşturma
1. https://supabase.com adresine git
2. GitHub ile giriş yap
3. "New Project" oluştur
4. Proje adı: `dkw-restaurant-system`
5. Database password: güçlü şifre seç
6. Region: Frankfurt (eu-central-1)

### 1.2 Veritabanı Tabloları
Supabase Dashboard > SQL Editor'de aşağıdaki SQL'leri çalıştır:

```sql
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
```

### 1.3 Environment Variables
Supabase Dashboard > Settings > API'den:
- Project URL
- anon/public key
- service_role key

## 2. Backend API Deployment

### 2.1 Heroku Deployment
```bash
# Heroku CLI kurulumu
npm install -g heroku

# Heroku'da uygulama oluştur
heroku create dkw-restaurant-api

# Environment variables ayarla
heroku config:set NODE_ENV=production
heroku config:set SUPABASE_URL=your_supabase_url
heroku config:set SUPABASE_ANON_KEY=your_supabase_anon_key
heroku config:set SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
heroku config:set JWT_SECRET=your_jwt_secret_key

# Deploy
git add .
git commit -m "Initial backend deployment"
git push heroku main
```

### 2.2 Railway Deployment
1. https://railway.app adresine git
2. GitHub ile giriş yap
3. "New Project" > "Deploy from GitHub repo"
4. Repository'yi seç
5. Environment variables ekle
6. Deploy

### 2.3 DigitalOcean App Platform
1. DigitalOcean Dashboard > Apps
2. "Create App" > "Source Code"
3. GitHub repository'yi bağla
4. Environment variables ekle
5. Deploy

## 3. Frontend Deployment (Netlify)

### 3.1 Netlify'da Site Oluşturma
1. https://netlify.com adresine git
2. GitHub ile giriş yap
3. "New site from Git" > "GitHub"
4. Repository'yi seç
5. Build settings:
   - Build command: `npm run build`
   - Publish directory: `dist`

### 3.2 Environment Variables
Netlify Dashboard > Site settings > Environment variables:
```
VITE_API_URL=https://your-api-domain.com
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 3.3 Custom Domain
1. Netlify Dashboard > Domain settings
2. "Add custom domain"
3. Domain adını gir
4. DNS ayarlarını yap

## 4. Domain Satın Alma ve Ayarlama

### 4.1 Domain Satın Alma
- **Namecheap**: https://namecheap.com
- **GoDaddy**: https://godaddy.com
- **Google Domains**: https://domains.google

### 4.2 DNS Ayarları
Netlify için:
```
Type: CNAME
Name: www
Value: your-site.netlify.app

Type: A
Name: @
Value: 75.2.60.5
```

### 4.3 SSL Sertifikası
Netlify otomatik olarak SSL sertifikası sağlar.

## 5. Production Checklist

### 5.1 Backend
- [ ] Environment variables ayarlandı
- [ ] Database migrations çalıştırıldı
- [ ] API endpoints test edildi
- [ ] CORS ayarları yapıldı
- [ ] Rate limiting aktif
- [ ] Error handling tamamlandı

### 5.2 Frontend
- [ ] Environment variables ayarlandı
- [ ] Build başarılı
- [ ] API bağlantıları test edildi
- [ ] Authentication çalışıyor
- [ ] Responsive design kontrol edildi

### 5.3 Security
- [ ] HTTPS aktif
- [ ] JWT secret güvenli
- [ ] API keys korunuyor
- [ ] CORS policy doğru
- [ ] Rate limiting aktif

## 6. Monitoring ve Analytics

### 6.1 Backend Monitoring
- **Heroku**: Built-in monitoring
- **Railway**: Built-in logs
- **DigitalOcean**: Monitoring tab

### 6.2 Frontend Analytics
- **Google Analytics**: Site trafiği
- **Netlify Analytics**: Built-in analytics

## 7. Backup ve Recovery

### 7.1 Database Backup
Supabase Dashboard > Settings > Database > Backups

### 7.2 Code Backup
GitHub repository otomatik backup

## 8. Maintenance

### 8.1 Regular Updates
- Node.js dependencies güncelle
- Security patches uygula
- Database optimizasyonu

### 8.2 Performance Monitoring
- API response times
- Database query performance
- Frontend load times

## 9. Support ve Documentation

### 9.1 API Documentation
- Postman collection oluştur
- Swagger/OpenAPI docs

### 9.2 User Documentation
- Admin panel kullanım kılavuzu
- Restaurant panel kullanım kılavuzu

## 10. Launch Checklist

- [ ] Domain aktif
- [ ] SSL sertifikası çalışıyor
- [ ] API endpoints test edildi
- [ ] Frontend responsive
- [ ] Authentication çalışıyor
- [ ] Database bağlantısı stabil
- [ ] Backup sistemi aktif
- [ ] Monitoring aktif
- [ ] Documentation hazır
- [ ] Support sistemi aktif

**🎉 Sistem hazır! Launch edebilirsiniz!**