# e-Mess Management Web Application

A comprehensive Next.js TypeScript web application for managing university cafeteria operations, providing separate dashboards for Cafeteria Management, University Executive Management, and System Administration.

## Features

### 🍽️ Cafeteria Management Dashboard
- **Dashboard Overview**: Real-time analytics with revenue trends, order statistics, and popular meals
- **Meal Management**: CRUD operations for meals with category organization
- **Meal Scheduling**: Daily meal scheduling by meal time (breakfast, lunch, dinner, snack)
- **Budget Planning**: Create and manage weekly/monthly budget plans with cost tracking
- **Analytics**: Detailed meal consumption trends and revenue analytics

### 🎓 University Executive Management Dashboard
- **Deep Insights**: Comprehensive overview of cafeteria operations
- **Monthly Trends**: Revenue, orders, and student engagement over time
- **Student Engagement**: Analysis of spending patterns and engagement levels
- **Budget Analysis**: Estimated vs actual cost comparison across all budget plans
- **Revenue Distribution**: Category-wise revenue breakdown

### ⚙️ Admin Panel
- **System Health Monitoring**: Real-time server status and uptime tracking
- **Database Management**: Database connection status and information
- **API Endpoint Overview**: Complete list of available API endpoints
- **System Actions**: Quick access to administrative functions

## Tech Stack

- **Framework**: Next.js 14 with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Charts**: Recharts
- **HTTP Client**: Axios
- **Date Handling**: date-fns
- **Icons**: Lucide React

## Prerequisites

- Node.js 18.x or higher
- npm or yarn
- Running e-Mess backend API (see backend branch)

## Installation

1. **Clone the repository and navigate to web-app directory**:
   ```bash
   cd web-app
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Configure environment variables**:
   ```bash
   cp .env.local .env.local
   ```

   Update `.env.local` with your backend API URL:
   ```
   NEXT_PUBLIC_API_URL=http://localhost:3000/api
   ```

4. **Run the development server**:
   ```bash
   npm run dev
   ```

5. **Open your browser**:
   Navigate to [http://localhost:3001](http://localhost:3001)

## Project Structure

```
web-app/
├── src/
│   ├── app/                    # Next.js App Router pages
│   │   ├── login/             # Login page
│   │   ├── cafeteria/         # Cafeteria management pages
│   │   │   ├── page.tsx       # Dashboard
│   │   │   ├── meals/         # Meal management
│   │   │   ├── scheduling/    # Meal scheduling
│   │   │   ├── budget/        # Budget planning
│   │   │   └── analytics/     # Analytics
│   │   ├── university/        # University management pages
│   │   │   └── page.tsx       # Insights dashboard
│   │   ├── admin/             # Admin panel pages
│   │   │   └── page.tsx       # System health
│   │   ├── layout.tsx         # Root layout
│   │   └── page.tsx           # Home page (redirects)
│   ├── components/            # React components
│   │   ├── ui/               # Reusable UI components
│   │   └── layout/           # Layout components
│   ├── lib/                  # Utilities and services
│   │   ├── api.ts           # API client
│   │   └── auth.ts          # Authentication utilities
│   └── types/               # TypeScript type definitions
├── public/                  # Static assets
├── .env.local              # Environment variables
├── next.config.js          # Next.js configuration
├── tailwind.config.js      # Tailwind CSS configuration
├── tsconfig.json           # TypeScript configuration
└── package.json            # Dependencies and scripts
```

## User Roles and Access

### Cafeteria Manager
- **Username**: `cafeteria_admin`
- **Password**: `password123`
- **Access**: Meal management, scheduling, budget planning, analytics

### University Admin
- **Username**: `university_admin`
- **Password**: `password123`
- **Access**: Deep insights, budget analysis, comprehensive reports

### System Admin
- **Access**: System health monitoring, database management, API overview

## Available Scripts

- `npm run dev` - Start development server (port 3001)
- `npm run build` - Build production bundle
- `npm run start` - Start production server
- `npm run lint` - Run ESLint

## Features by Role

### Cafeteria Management
1. **Dashboard**
   - Total revenue and orders
   - Active student count
   - Revenue trends chart
   - Popular meals analysis
   - Meal time distribution

2. **Meals Management**
   - Create, edit meals
   - Category-based organization
   - Price management
   - Active/inactive status

3. **Scheduling**
   - Schedule meals by date and time
   - Weekly calendar view
   - Quantity tracking
   - Remaining inventory view

4. **Budget Planning**
   - Create weekly/monthly budgets
   - Track estimated vs actual costs
   - Budget variance analysis
   - Item-level budget details

5. **Analytics**
   - Meal consumption trends
   - Revenue tracking per meal
   - Historical data visualization

### University Executive Management
1. **Dashboard**
   - Overall statistics (revenue, orders, students)
   - Monthly trends analysis
   - Student engagement levels
   - Revenue by category
   - Budget analysis overview

2. **Key Metrics**
   - Unique student count
   - Average order value
   - Student engagement classification
   - Budget variance tracking

### Admin Panel
1. **System Health**
   - Server uptime monitoring
   - Database connection status
   - Memory usage (if available)
   - Last check timestamp

2. **Database Info**
   - Connection status
   - Database size
   - Table count

3. **API Overview**
   - Available endpoints by category
   - Quick reference guide

## API Integration

The web app connects to the e-Mess backend API. Ensure the backend is running before starting the web app.

### Key API Endpoints Used

- **Authentication**: `/api/auth/login`, `/api/auth/me`
- **Meals**: `/api/meals`, `/api/meals/categories`, `/api/meals/schedules`
- **Analytics**: `/api/analytics/cafeteria/dashboard`, `/api/analytics/university/insights`
- **Budget**: `/api/budget`, `/api/budget/:id`
- **Health**: `/api/health`

## Authentication

The app uses JWT token-based authentication:
- Tokens are stored in localStorage
- Automatic token injection in API requests
- Automatic redirect to login on 401 responses
- Role-based access control

## Responsive Design

The application is fully responsive and works on:
- Desktop (1024px and above)
- Tablet (768px - 1023px)
- Mobile (below 768px)

## Charts and Visualizations

The app includes various chart types:
- Line charts for trends
- Bar charts for comparisons
- Pie charts for distributions
- Progress bars for budgets

## Environment Variables

```bash
# API Configuration
NEXT_PUBLIC_API_URL=http://localhost:3000/api

# Application Configuration
NEXT_PUBLIC_APP_NAME=e-Mess Management
```

## Development Tips

1. **Hot Reload**: The dev server supports hot reload for instant feedback
2. **Type Safety**: Full TypeScript support with strict mode enabled
3. **Code Organization**: Components are organized by feature and reusability
4. **API Client**: Centralized API client with automatic error handling

## Troubleshooting

### API Connection Issues
- Ensure backend server is running on port 3000
- Check `NEXT_PUBLIC_API_URL` in `.env.local`
- Verify CORS settings in backend

### Login Issues
- Verify credentials with backend
- Check browser console for errors
- Clear localStorage and try again

### Chart Not Rendering
- Ensure data is being fetched successfully
- Check browser console for errors
- Verify recharts is properly installed

## Production Deployment

1. **Build the application**:
   ```bash
   npm run build
   ```

2. **Test the production build**:
   ```bash
   npm run start
   ```

3. **Deploy to your hosting platform**:
   - Vercel (recommended for Next.js)
   - Netlify
   - Your own server

4. **Environment Variables**:
   - Update `NEXT_PUBLIC_API_URL` to production API URL
   - Set up environment variables in hosting platform

## Security Considerations

- JWT tokens are stored in localStorage (consider httpOnly cookies for production)
- API requests include authentication headers
- Role-based access control implemented
- Input validation on forms
- HTTPS recommended for production

## Future Enhancements

- Real-time updates with WebSockets
- Export reports to PDF/Excel
- Email notifications
- Advanced filtering and search
- Data caching for better performance
- Offline support with PWA

## Support

For issues or questions:
- Check the backend API documentation
- Review the IMPLEMENTATION_SUMMARY.md in the backend branch
- Check browser console for errors

## License

This project is part of the e-Mess Cafeteria Management System.

## Credits

Built with Next.js, TypeScript, and Tailwind CSS for university cafeteria management.
