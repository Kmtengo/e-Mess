'use client';

import React, { useEffect, useState } from 'react';
import { DashboardLayout } from '@/components/layout/DashboardLayout';
import { Card } from '@/components/ui/Card';
import { Loader } from '@/components/ui/Loader';
import { api } from '@/lib/api';
import { MealConsumptionTrend } from '@/types';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { format } from 'date-fns';

export default function AnalyticsPage() {
  const [trends, setTrends] = useState<MealConsumptionTrend[]>([]);
  const [loading, setLoading] = useState(true);
  const [period, setPeriod] = useState(30);

  useEffect(() => {
    loadTrends();
  }, [period]);

  const loadTrends = async () => {
    try {
      setLoading(true);
      const data = await api.getMealConsumptionTrends(period);
      setTrends(data);
    } catch (error) {
      console.error('Failed to load trends:', error);
    } finally {
      setLoading(false);
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('en-UG', {
      style: 'currency',
      currency: 'UGX',
      minimumFractionDigits: 0,
    }).format(value);
  };

  if (loading) {
    return (
      <DashboardLayout activeTab="analytics">
        <div className="flex items-center justify-center h-96">
          <Loader size="lg" />
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout activeTab="analytics">
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-900">Meal Consumption Analytics</h1>
          <select
            value={period}
            onChange={(e) => setPeriod(Number(e.target.value))}
            className="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500"
          >
            <option value={7}>Last 7 days</option>
            <option value={30}>Last 30 days</option>
            <option value={90}>Last 90 days</option>
          </select>
        </div>

        {/* Summary Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card>
            <div>
              <p className="text-sm font-medium text-gray-600">Total Meals Tracked</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">{trends.length}</p>
            </div>
          </Card>
          <Card>
            <div>
              <p className="text-sm font-medium text-gray-600">Total Quantity Sold</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">
                {trends.reduce((sum, t) => sum + t.total_quantity, 0).toLocaleString()}
              </p>
            </div>
          </Card>
          <Card>
            <div>
              <p className="text-sm font-medium text-gray-600">Total Revenue</p>
              <p className="text-2xl font-bold text-gray-900 mt-1">
                {formatCurrency(trends.reduce((sum, t) => sum + t.total_revenue, 0))}
              </p>
            </div>
          </Card>
        </div>

        {/* Meal Trends */}
        {trends.map((trend) => (
          <Card
            key={trend.meal_name}
            title={trend.meal_name}
            subtitle={`${trend.category} • ${trend.total_orders} orders • ${formatCurrency(trend.total_revenue)} revenue`}
          >
            <ResponsiveContainer width="100%" height={300}>
              <LineChart data={trend.trend_data}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis
                  dataKey="date"
                  tickFormatter={(date) => format(new Date(date), 'MMM dd')}
                />
                <YAxis yAxisId="left" />
                <YAxis yAxisId="right" orientation="right" tickFormatter={(value) => `${(value / 1000).toFixed(0)}K`} />
                <Tooltip
                  formatter={(value: number, name: string) => {
                    if (name === 'Revenue') return formatCurrency(value);
                    return value;
                  }}
                  labelFormatter={(date) => format(new Date(date), 'MMMM dd, yyyy')}
                />
                <Legend />
                <Line
                  yAxisId="left"
                  type="monotone"
                  dataKey="quantity"
                  stroke="#3b82f6"
                  strokeWidth={2}
                  name="Quantity"
                />
                <Line
                  yAxisId="right"
                  type="monotone"
                  dataKey="revenue"
                  stroke="#ef4444"
                  strokeWidth={2}
                  name="Revenue"
                />
              </LineChart>
            </ResponsiveContainer>
          </Card>
        ))}

        {trends.length === 0 && (
          <Card>
            <div className="text-center py-12 text-gray-500">
              No consumption data available for the selected period
            </div>
          </Card>
        )}
      </div>
    </DashboardLayout>
  );
}
