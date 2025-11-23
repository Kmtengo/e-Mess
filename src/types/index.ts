// User Types
export type UserType = 'student' | 'pos_manager' | 'cafeteria_manager' | 'university_admin';

export interface User {
  id: number;
  username: string;
  email: string;
  user_type: UserType;
  full_name: string;
  student_id?: string;
}

export interface AuthResponse {
  token: string;
  user: User;
}

// Meal Types
export interface MealCategory {
  id: number;
  name: string;
  description?: string;
}

export interface Meal {
  id: number;
  category_id: number;
  name: string;
  description?: string;
  price: number;
  is_active: number;
  image_url?: string;
  category_name?: string;
}

export type MealTime = 'breakfast' | 'lunch' | 'dinner' | 'snack';

export interface MealSchedule {
  id: number;
  meal_id: number;
  schedule_date: string;
  meal_time: MealTime;
  quantity_available: number;
  quantity_ordered?: number;
  remaining_quantity?: number;
  name?: string;
  description?: string;
  price?: number;
  category_name?: string;
}

export interface CreateMealScheduleRequest {
  meal_id: number;
  schedule_date: string;
  meal_time: MealTime;
  quantity_available: number;
}

// Budget Types
export type BudgetPlanType = 'weekly' | 'monthly';
export type BudgetStatus = 'draft' | 'active' | 'completed' | 'cancelled';

export interface BudgetPlanItem {
  id?: number;
  meal_id: number;
  meal_name?: string;
  estimated_quantity: number;
  unit_cost: number;
  total_cost?: number;
  actual_quantity?: number;
  actual_cost?: number;
  notes?: string;
}

export interface BudgetPlan {
  id: number;
  plan_name: string;
  plan_type: BudgetPlanType;
  start_date: string;
  end_date: string;
  total_budget: number;
  estimated_cost: number;
  actual_cost: number;
  status: BudgetStatus;
  created_by: number;
  created_by_name?: string;
  created_at: string;
  items?: BudgetPlanItem[];
}

export interface CreateBudgetPlanRequest {
  plan_name: string;
  plan_type: BudgetPlanType;
  start_date: string;
  end_date: string;
  total_budget: number;
  items: Omit<BudgetPlanItem, 'id' | 'meal_name' | 'total_cost' | 'actual_quantity' | 'actual_cost'>[];
}

// Analytics Types
export interface CafeteriaDashboard {
  total_revenue: number;
  total_orders: number;
  active_students: number;
  revenue_by_day: Array<{
    date: string;
    revenue: number;
    orders: number;
  }>;
  popular_meals: Array<{
    name: string;
    order_count: number;
    total_quantity: number;
    revenue: number;
  }>;
  orders_by_meal_time: Array<{
    meal_time: MealTime;
    count: number;
    revenue: number;
  }>;
  period_days: number;
}

export interface MealConsumptionTrend {
  meal_name: string;
  category: string;
  total_quantity: number;
  total_orders: number;
  total_revenue: number;
  trend_data: Array<{
    date: string;
    quantity: number;
    revenue: number;
  }>;
}

export interface UniversityInsights {
  overall_stats: {
    total_orders: number;
    unique_students: number;
    total_revenue: number;
    avg_order_value: number;
  };
  monthly_trends: Array<{
    month: string;
    orders: number;
    revenue: number;
    active_students: number;
  }>;
  student_engagement: Array<{
    engagement_level: string;
    student_count: number;
    avg_spent: number;
  }>;
  revenue_by_category: Array<{
    category_name: string;
    revenue: number;
    percentage: number;
  }>;
  budget_analysis: Array<{
    plan_name: string;
    estimated_cost: number;
    actual_cost: number;
    variance: number;
    variance_percentage: number;
  }>;
  period_days: number;
}

export interface RevenueReport {
  date: string;
  total_revenue: number;
  total_orders: number;
  breakdown: Array<{
    meal_time: MealTime;
    revenue: number;
    orders: number;
  }>;
}

// Order Types
export type OrderStatus = 'pending' | 'confirmed' | 'preparing' | 'ready' | 'completed' | 'cancelled';
export type PaymentStatus = 'pending' | 'completed' | 'failed' | 'refunded';

export interface Order {
  id: number;
  user_id: number;
  order_number: string;
  total_amount: number;
  payment_method: string;
  payment_status: PaymentStatus;
  order_status: OrderStatus;
  order_type: string;
  created_at: string;
  items?: Array<{
    meal_id: number;
    meal_name: string;
    quantity: number;
    unit_price: number;
  }>;
}

// System Health Types
export interface SystemHealth {
  status: 'ok' | 'warning' | 'error';
  timestamp: string;
  uptime: number;
  database: {
    connected: boolean;
    size?: string;
  };
  memory?: {
    used: number;
    total: number;
    percentage: number;
  };
}
