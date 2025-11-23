# e-Mess Web Application

A comprehensive web-based management system for university cafeteria operations, built with Next.js and TypeScript.

## Overview

This repository contains the web application for the e-Mess cafeteria management system. The application provides three distinct role-based dashboards to manage and monitor university cafeteria operations efficiently.

## Features

### 🍽️ Cafeteria Management Dashboard
The cafeteria manager portal provides comprehensive tools for daily operations:

- **Dashboard Overview**
  - Real-time revenue and order analytics
  - Popular meals tracking
  - Active student metrics
  - Meal time distribution charts

- **Meal Management**
  - Create, edit, and manage meals
  - Category-based organization
  - Price management
  - Active/inactive status control

- **Meal Scheduling**
  - Daily meal scheduling by time (breakfast, lunch, dinner, snack)
  - Weekly calendar view
  - Quantity tracking and inventory management
  - Real-time remaining quantity updates

- **Budget Planning**
  - Create weekly and monthly budget plans
  - Track estimated vs actual costs
  - Budget variance analysis
  - Item-level budget tracking
  - Visual progress indicators

- **Analytics**
  - Detailed meal consumption trends
  - Revenue tracking per meal
  - Historical data visualization
  - Time-series analysis

### 🎓 University Executive Management Dashboard
The university administration portal provides deep insights:

- **Comprehensive Insights**
  - Overall system statistics
  - Total revenue and order metrics
  - Unique student engagement tracking
  - Average order value analysis

- **Trend Analysis**
  - Monthly revenue trends
  - Order volume patterns
  - Active student trends
  - Multi-metric visualization

- **Student Engagement**
  - Engagement level classification
  - Spending pattern analysis
  - Student activity metrics

- **Budget Analysis**
  - Cross-plan budget comparison
  - Estimated vs actual cost tracking
  - Variance analysis with percentages
  - Financial performance indicators

- **Revenue Distribution**
  - Category-wise revenue breakdown
  - Visual distribution charts
  - Percentage analysis

### ⚙️ Admin Panel
System administrator tools for monitoring and management:

- **System Health Monitoring**
  - Real-time server status
  - Uptime tracking
  - Database connection status
  - Memory usage monitoring (when available)

- **Database Management**
  - Connection status monitoring
  - Database size tracking
  - Table information

- **API Overview**
  - Complete endpoint reference
  - Organized by category
  - Quick access to documentation

- **System Actions**
  - Quick health checks
  - Administrative functions
  - System management tools

## Technology Stack

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
- Running e-Mess backend API (see [backend branch](../../tree/backend))

## Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd e-Mess
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Configure environment variables**:
   Edit the `.env.local` file and update with your backend API URL:
   ```bash
   NEXT_PUBLIC_API_URL=http://localhost:3000/api
   NEXT_PUBLIC_APP_NAME=e-Mess Management
   ```

4. **Start the development server**:
   ```bash
   npm run dev
   ```

5. **Open your browser**:
   Navigate to [http://localhost:3000](http://localhost:3000)

## Project Structure

```
e-Mess/
├── src/
│   ├── app/                   # Next.js App Router pages
│   │   ├── login/            # Authentication
│   │   ├── cafeteria/        # Cafeteria management
│   │   │   ├── page.tsx              # Dashboard
│   │   │   ├── meals/                # Meal management
│   │   │   ├── scheduling/           # Scheduling interface
│   │   │   ├── budget/               # Budget planning
│   │   │   └── analytics/            # Analytics
│   │   ├── university/       # University insights
│   │   └── admin/            # Admin panel
│   ├── components/           # React components
│   │   ├── ui/              # Reusable UI components
│   │   └── layout/          # Layout components
│   ├── lib/                 # Utilities and services
│   │   ├── api.ts          # API client
│   │   └── auth.ts         # Authentication
│   └── types/               # TypeScript definitions
├── public/                  # Static assets
├── .env.local              # Environment variables
├── .gitignore
├── README.md
├── package.json            # Dependencies
├── next.config.js          # Next.js config
├── tailwind.config.js      # Tailwind config
└── tsconfig.json           # TypeScript config
```

## User Roles and Access

### Cafeteria Manager
- **Username**: `cafeteria_admin`
- **Password**: `password123`
- **Permissions**: Full access to meal management, scheduling, budget planning, and analytics

### University Administrator
- **Username**: `university_admin`
- **Password**: `password123`
- **Permissions**: Read-only access to insights, comprehensive reports, and budget analysis

### System Administrator
- **Permissions**: System health monitoring, database management, and API overview

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build production bundle
- `npm run start` - Start production server
- `npm run lint` - Run ESLint

## Backend Integration

This web application integrates with the e-Mess backend API. The backend provides:

- User authentication (JWT-based)
- Meal management APIs
- Order processing
- Analytics endpoints
- Budget management
- System health checks

**Backend Repository**: Switch to the `backend` branch to access the Node.js backend with SQLite database.

### Key API Endpoints

- **Authentication**: `/api/auth/login`, `/api/auth/me`
- **Meals**: `/api/meals`, `/api/meals/categories`, `/api/meals/schedules`
- **Analytics**: `/api/analytics/cafeteria/dashboard`, `/api/analytics/university/insights`
- **Budget**: `/api/budget`, `/api/budget/:id`
- **Orders**: `/api/orders`
- **Health**: `/api/health`

## Features Breakdown

### Authentication System
- JWT token-based authentication
- Automatic token management
- Role-based access control
- Secure localStorage implementation
- Auto-redirect on unauthorized access

### Real-time Analytics
- Interactive charts and visualizations
- Time-series data analysis
- Filtering by time periods (7, 30, 90 days)
- Export-ready data formats

### Responsive Design
Fully responsive interface supporting:
- Desktop (1024px and above)
- Tablet (768px - 1023px)
- Mobile (below 768px)

### Data Visualization
- Line charts for trend analysis
- Bar charts for comparisons
- Pie charts for distribution
- Progress bars for budgets
- Interactive tooltips and legends

## Development

### Code Organization
- **Pages**: Organized by user role and feature
- **Components**: Reusable UI components with TypeScript
- **Services**: Centralized API client with error handling
- **Types**: Comprehensive TypeScript type definitions

### Best Practices
- TypeScript strict mode enabled
- Component-based architecture
- Centralized state management
- Error boundary implementation
- Loading states for async operations

## Deployment

### Production Build

1. **Build the application**:
   ```bash
   npm run build
   ```

2. **Test production build locally**:
   ```bash
   npm run start
   ```

3. **Deploy to hosting platform**:
   - Vercel (recommended for Next.js)
   - Netlify
   - AWS Amplify
   - Custom server

### Environment Configuration

Update environment variables for production:

```env
NEXT_PUBLIC_API_URL=https://your-api-domain.com/api
NEXT_PUBLIC_APP_NAME=e-Mess Management
```

## Security

- JWT token authentication
- HTTPS recommended for production
- Environment variable protection
- Input validation on all forms
- Role-based access control
- API request authentication

## Troubleshooting

### Common Issues

**API Connection Errors**
- Verify backend is running
- Check `NEXT_PUBLIC_API_URL` in `.env.local`
- Ensure CORS is properly configured

**Authentication Issues**
- Clear browser localStorage
- Verify credentials with backend
- Check JWT token expiration

**Chart Rendering Problems**
- Verify data format from API
- Check browser console for errors
- Ensure recharts dependency is installed

## Contributing

This is a university project. For issues or suggestions:
1. Check existing issues
2. Review the backend documentation
3. Test with the latest backend version

## System Requirements

- **Development**: Node.js 18+, npm/yarn
- **Browser**: Modern browsers (Chrome, Firefox, Safari, Edge)
- **Backend**: e-Mess backend API running
- **Database**: SQLite (via backend)

## Related Repositories

- **Backend API**: Switch to `backend` branch for Node.js backend
- **Mobile POS App**: See Flutter application in separate repository

## Future Enhancements

- Real-time updates with WebSockets
- PDF/Excel report exports
- Email notifications
- Advanced filtering and search
- Data caching
- Offline PWA support
- Multi-language support

## License

This project is part of the e-Mess University Cafeteria Management System.

## Support

For detailed API documentation, refer to the backend branch:
```bash
git checkout backend
```

## Credits

Built with Next.js, TypeScript, and Tailwind CSS for efficient university cafeteria management.

---

**Version**: 1.0.0
**Last Updated**: November 2025
**Status**: Production Ready
