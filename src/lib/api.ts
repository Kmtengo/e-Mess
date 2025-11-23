import axios, { AxiosInstance, AxiosError } from 'axios';
import type {
  AuthResponse,
  User,
  Meal,
  MealCategory,
  MealSchedule,
  CreateMealScheduleRequest,
  BudgetPlan,
  CreateBudgetPlanRequest,
  CafeteriaDashboard,
  MealConsumptionTrend,
  UniversityInsights,
  RevenueReport,
  Order,
  SystemHealth,
} from '@/types';

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api';

class ApiClient {
  private client: AxiosInstance;

  constructor() {
    this.client = axios.create({
      baseURL: API_URL,
      headers: {
        'Content-Type': 'application/json',
      },
    });

    // Add request interceptor to include auth token
    this.client.interceptors.request.use(
      (config) => {
        const token = this.getToken();
        if (token) {
          config.headers.Authorization = `Bearer ${token}`;
        }
        return config;
      },
      (error) => Promise.reject(error)
    );

    // Add response interceptor to handle errors
    this.client.interceptors.response.use(
      (response) => response,
      (error: AxiosError) => {
        if (error.response?.status === 401) {
          this.clearAuth();
          if (typeof window !== 'undefined') {
            window.location.href = '/login';
          }
        }
        return Promise.reject(error);
      }
    );
  }

  // Token Management
  private getToken(): string | null {
    if (typeof window === 'undefined') return null;
    return localStorage.getItem('auth_token');
  }

  private setToken(token: string): void {
    if (typeof window !== 'undefined') {
      localStorage.setItem('auth_token', token);
    }
  }

  private clearAuth(): void {
    if (typeof window !== 'undefined') {
      localStorage.removeItem('auth_token');
      localStorage.removeItem('user');
    }
  }

  // Authentication
  async login(username: string, password: string): Promise<AuthResponse> {
    const response = await this.client.post<AuthResponse>('/auth/login', {
      username,
      password,
    });
    this.setToken(response.data.token);
    if (typeof window !== 'undefined') {
      localStorage.setItem('user', JSON.stringify(response.data.user));
    }
    return response.data;
  }

  async logout(): Promise<void> {
    this.clearAuth();
  }

  async getCurrentUser(): Promise<User> {
    const response = await this.client.get<User>('/auth/me');
    return response.data;
  }

  // Meals
  async getMeals(categoryId?: number, activeOnly = true): Promise<Meal[]> {
    const params: any = {};
    if (categoryId) params.category_id = categoryId;
    if (activeOnly) params.active_only = 'true';
    const response = await this.client.get<Meal[]>('/meals', { params });
    return response.data;
  }

  async createMeal(meal: Omit<Meal, 'id'>): Promise<{ message: string; id: number }> {
    const response = await this.client.post('/meals', meal);
    return response.data;
  }

  async updateMeal(id: number, meal: Partial<Meal>): Promise<{ message: string }> {
    const response = await this.client.put(`/meals/${id}`, meal);
    return response.data;
  }

  async getMealCategories(): Promise<MealCategory[]> {
    const response = await this.client.get<MealCategory[]>('/meals/categories');
    return response.data;
  }

  // Meal Schedules
  async getAvailableMeals(date: string, mealTime?: string): Promise<MealSchedule[]> {
    const params: any = { date };
    if (mealTime) params.meal_time = mealTime;
    const response = await this.client.get<MealSchedule[]>('/meals/schedules/available', { params });
    return response.data;
  }

  async createMealSchedule(schedule: CreateMealScheduleRequest): Promise<{ message: string; id: number }> {
    const response = await this.client.post('/meals/schedules', schedule);
    return response.data;
  }

  async getMealSchedules(date?: string, mealTime?: string): Promise<MealSchedule[]> {
    const params: any = {};
    if (date) params.date = date;
    if (mealTime) params.meal_time = mealTime;
    const response = await this.client.get<MealSchedule[]>('/meals/schedules', { params });
    return response.data;
  }

  // Budget Management
  async getBudgetPlans(status?: string, planType?: string): Promise<BudgetPlan[]> {
    const params: any = {};
    if (status) params.status = status;
    if (planType) params.plan_type = planType;
    const response = await this.client.get<BudgetPlan[]>('/budget', { params });
    return response.data;
  }

  async getBudgetPlan(id: number): Promise<BudgetPlan> {
    const response = await this.client.get<BudgetPlan>(`/budget/${id}`);
    return response.data;
  }

  async createBudgetPlan(plan: CreateBudgetPlanRequest): Promise<{ message: string; id: number }> {
    const response = await this.client.post('/budget', plan);
    return response.data;
  }

  async updateBudgetStatus(id: number, status: string): Promise<{ message: string }> {
    const response = await this.client.patch(`/budget/${id}/status`, { status });
    return response.data;
  }

  // Analytics - Cafeteria
  async getCafeteriaDashboard(period: number = 30): Promise<CafeteriaDashboard> {
    const response = await this.client.get<CafeteriaDashboard>('/analytics/cafeteria/dashboard', {
      params: { period },
    });
    return response.data;
  }

  async getMealConsumptionTrends(period: number = 30): Promise<MealConsumptionTrend[]> {
    const response = await this.client.get<MealConsumptionTrend[]>('/analytics/cafeteria/consumption', {
      params: { period },
    });
    return response.data;
  }

  // Analytics - University
  async getUniversityInsights(period: number = 90): Promise<UniversityInsights> {
    const response = await this.client.get<UniversityInsights>('/analytics/university/insights', {
      params: { period },
    });
    return response.data;
  }

  async getRevenueReports(startDate: string, endDate: string): Promise<RevenueReport[]> {
    const response = await this.client.get<RevenueReport[]>('/analytics/university/revenue', {
      params: { start_date: startDate, end_date: endDate },
    });
    return response.data;
  }

  // Orders
  async getOrders(status?: string, limit = 50, offset = 0): Promise<Order[]> {
    const params: any = { limit, offset };
    if (status) params.status = status;
    const response = await this.client.get<Order[]>('/orders', { params });
    return response.data;
  }

  async updateOrderStatus(id: number, status: string): Promise<{ message: string }> {
    const response = await this.client.patch(`/orders/${id}/status`, { status });
    return response.data;
  }

  // System Health (Admin)
  async getSystemHealth(): Promise<SystemHealth> {
    const response = await this.client.get<SystemHealth>('/health');
    return response.data;
  }
}

export const api = new ApiClient();
