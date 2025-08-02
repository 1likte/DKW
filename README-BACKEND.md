# DKW Restaurant System - Backend API

## 🚀 Hızlı Başlangıç

### Gereksinimler
- Node.js 18+
- npm veya yarn
- Supabase hesabı

### Kurulum

1. **Dependencies yükle:**
```bash
cd backend
npm install
```

2. **Environment variables ayarla:**
```bash
cp env.example .env
# .env dosyasını düzenle
```

3. **Supabase projesi oluştur:**
- https://supabase.com adresine git
- Yeni proje oluştur
- SQL Editor'de tabloları oluştur (supabase-setup.md'ye bak)

4. **Development server başlat:**
```bash
npm run dev
```

## 📁 Proje Yapısı

```
backend/
├── config/
│   └── supabase.js          # Supabase konfigürasyonu
├── middleware/
│   ├── auth.js              # Authentication middleware
│   └── errorHandler.js      # Error handling
├── routes/
│   ├── auth.js              # Authentication routes
│   ├── orders.js            # Orders API
│   ├── users.js             # Users API (Admin)
│   ├── sales.js             # Sales API
│   └── support.js           # Support API
├── server.js                # Ana server dosyası
├── package.json
└── env.example
```

## 🔧 API Endpoints

### Authentication
- `POST /api/auth/register` - Kullanıcı kaydı
- `POST /api/auth/login` - Kullanıcı girişi
- `POST /api/auth/admin/login` - Admin girişi
- `GET /api/auth/verify` - Token doğrulama

### Orders
- `GET /api/orders` - Siparişleri listele
- `POST /api/orders` - Yeni sipariş oluştur
- `PATCH /api/orders/:id/status` - Sipariş durumu güncelle
- `DELETE /api/orders/:id` - Sipariş sil
- `GET /api/orders/overdue` - Gecikmiş siparişler
- `GET /api/orders/stats` - Sipariş istatistikleri

### Users (Admin)
- `GET /api/users` - Kullanıcıları listele
- `POST /api/users` - Yeni kullanıcı oluştur
- `PATCH /api/users/:id` - Kullanıcı güncelle
- `DELETE /api/users/:id` - Kullanıcı sil
- `PATCH /api/users/:id/toggle-status` - Kullanıcı durumu değiştir

### Sales
- `GET /api/sales` - Satışları listele
- `POST /api/sales` - Yeni satış oluştur

### Support
- `GET /api/support/messages` - Destek mesajlarını listele
- `POST /api/support/messages` - Destek mesajı gönder
- `DELETE /api/support/messages/:id` - Destek mesajı sil

## 🔐 Authentication

API JWT token kullanır. Header'da şu şekilde gönder:
```
Authorization: Bearer <token>
```

## 🛠️ Development

### Scripts
```bash
npm run dev          # Development server
npm start            # Production server
npm test             # Tests çalıştır
```

### Environment Variables
```env
PORT=5000
NODE_ENV=development
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_key
JWT_SECRET=your_jwt_secret
FRONTEND_URL=http://localhost:5173
```

## 🚀 Deployment

### Heroku
```bash
heroku create dkw-restaurant-api
heroku config:set NODE_ENV=production
heroku config:set SUPABASE_URL=your_url
heroku config:set SUPABASE_ANON_KEY=your_key
heroku config:set SUPABASE_SERVICE_ROLE_KEY=your_service_key
heroku config:set JWT_SECRET=your_secret
git push heroku main
```

### Railway
1. Railway.app'e git
2. GitHub repo'yu bağla
3. Environment variables ekle
4. Deploy

### DigitalOcean App Platform
1. DigitalOcean Dashboard > Apps
2. "Create App" > "Source Code"
3. GitHub repo'yu bağla
4. Environment variables ekle
5. Deploy

## 📊 Monitoring

### Health Check
```
GET /health
```

### Logs
```bash
# Heroku
heroku logs --tail

# Railway
railway logs

# Local
npm run dev
```

## 🔒 Security

- JWT authentication
- Rate limiting
- CORS protection
- Helmet security headers
- Input validation
- SQL injection protection (Supabase)

## 📝 API Documentation

### Request/Response Examples

#### Login
```json
POST /api/auth/login
{
  "email": "restaurant@example.com",
  "password": "password123"
}

Response:
{
  "message": "Login successful",
  "user": {
    "id": "uuid",
    "email": "restaurant@example.com",
    "restaurant_name": "Example Restaurant"
  },
  "token": "jwt_token_here"
}
```

#### Create Order
```json
POST /api/orders
Authorization: Bearer <token>
{
  "order_number": "ORD-001",
  "customer_name": "John Doe",
  "items": [
    {
      "name": "Pizza Margherita",
      "price": 12.99,
      "quantity": 2
    }
  ],
  "total_amount": 25.98,
  "payment_method": "cash"
}
```

## 🐛 Troubleshooting

### Common Issues

1. **CORS Error**
   - FRONTEND_URL environment variable'ını kontrol et

2. **Database Connection Error**
   - Supabase credentials'ları kontrol et
   - Network bağlantısını kontrol et

3. **JWT Error**
   - JWT_SECRET environment variable'ını kontrol et
   - Token'ın geçerli olduğunu kontrol et

4. **Rate Limiting**
   - Rate limit ayarlarını kontrol et
   - Çok fazla request gönderiyorsan bekle

## 📞 Support

Sorun yaşarsan:
1. Logs'ları kontrol et
2. Environment variables'ları kontrol et
3. Supabase dashboard'u kontrol et
4. GitHub issues'a bak

## 🎯 Next Steps

1. **Real-time features** - WebSocket/Socket.io ekle
2. **File upload** - Resim yükleme sistemi
3. **Email notifications** - Email gönderme sistemi
4. **Analytics** - Detaylı raporlama
5. **Mobile app** - React Native app

---

**🎉 Backend hazır! Frontend ile entegre et ve sistemi kullanmaya başla!**