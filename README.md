# DKW - Digitale Küchenverwaltung

[![Netlify Status](https://api.netlify.com/api/v1/badges/2b4f8067-6cb1-4aed-9d93-6fe3db13c345/deploy-status)](https://app.netlify.com/projects/dkw/deploys)

Ein professionelles Multi-Tenant Küchen-Management-System für Restaurants.

## Features

- **Multi-Tenant Architektur**: Separate Datenverwaltung für jedes Restaurant
- **Echtzeit Bestellverfolgung**: Live-Updates für Bestellstatus
- **QR-Code Menüs**: Kontaktlose Menüansicht für Kunden
- **Tagesangebote**: Dynamische Verwaltung von Sonderangeboten
- **Mehrsprachigkeit**: Deutsch, Türkisch, Englisch
- **Zahlungsintegration**: IBAN, QR-Code, PayPal
- **Responsive Design**: Optimiert für Desktop und Mobile

## Technologie Stack

- **Frontend**: React 18, TypeScript, Tailwind CSS
- **Backend**: Supabase (PostgreSQL, Auth, Real-time)
- **Routing**: React Router v6
- **Internationalisierung**: i18next
- **QR-Code**: qrcode library
- **PDF Generation**: jsPDF
- **Icons**: Lucide React

## Setup

### 1. Supabase Projekt erstellen

1. Gehen Sie zu [supabase.com](https://supabase.com)
2. Erstellen Sie ein neues Projekt
3. Kopieren Sie die Project URL und Anon Key

### 2. Umgebungsvariablen

Erstellen Sie eine `.env` Datei im Projektroot:

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

### 3. Datenbank Setup

1. Öffnen Sie den SQL Editor in Ihrem Supabase Dashboard
2. Führen Sie das SQL-Script aus `supabase/migrations/001_initial_schema.sql` aus
3. Dies erstellt alle notwendigen Tabellen und Sicherheitsrichtlinien

### 4. Installation

```bash
npm install
npm run dev
```

## Verwendung

### Admin-Zugang
- **URL**: `/admin/login`
- **Benutzername**: `chefyunuskalkan`
- **Passwort**: `Antalya1250.`

### Restaurant-Zugang
- **URL**: `/tenant/login`
- Verwenden Sie die vom Admin erstellten Zugangsdaten

### Kunden-Menü
- **URL**: `/menu/{tenantId}/{tableNumber}`
- Wird über QR-Codes zugänglich gemacht

## Architektur

### Datenbank Schema

- **tenants**: Restaurant-Informationen
- **orders**: Bestellverwaltung
- **menu_items**: Menü-Artikel
- **qr_tables**: QR-Code Tische
- **daily_specials**: Tagesangebote
- **payment_settings**: Zahlungseinstellungen
- **contact_info**: Kontaktinformationen

### Sicherheit

- Row Level Security (RLS) für alle Tabellen
- Tenant-Isolation durch Benutzer-basierte Richtlinien
- Sichere Authentifizierung über Supabase Auth

### Offline-Funktionalität

Das System kann mit localStorage als Fallback arbeiten, wenn Supabase nicht verfügbar ist.

## Deployment

### Netlify

1. Verbinden Sie Ihr GitHub Repository mit Netlify
2. Setzen Sie die Umgebungsvariablen in den Netlify-Einstellungen
3. Deploy-Befehl: `npm run build`
4. Publish-Verzeichnis: `dist`

### Vercel

1. Importieren Sie Ihr Projekt in Vercel
2. Setzen Sie die Umgebungsvariablen
3. Automatisches Deployment bei Git-Push

## Entwicklung

### Lokale Entwicklung

```bash
npm run dev
```

### Build für Produktion

```bash
npm run build
```

### Linting

```bash
npm run lint
```

## Lizenz

Alle Rechte vorbehalten. Dieses System ist proprietär und darf nicht ohne Genehmigung verwendet werden.

## Support

Für Support und weitere Informationen kontaktieren Sie:
- E-Mail: info@dkw-system.de
- Telefon: +49 123 456 789

## FTP ile Yükleme

1. `npm run build` komutu ile projeyi derleyin.
2. Oluşan `dist/` klasöründeki tüm dosyaları FTP ile sunucunuza yükleyin.
3. Sunucunuzun kök dizinine yüklediğinizde uygulamanız çalışacaktır.