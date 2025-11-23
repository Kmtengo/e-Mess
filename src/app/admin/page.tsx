'use client';

import React, { useEffect, useState } from 'react';
import { DashboardLayout } from '@/components/layout/DashboardLayout';
import { Card } from '@/components/ui/Card';
import { Loader } from '@/components/ui/Loader';
import { api } from '@/lib/api';
import { SystemHealth } from '@/types';
import { Server, Database, Activity, AlertCircle, CheckCircle, Clock } from 'lucide-react';

export default function AdminDashboardPage() {
  const [health, setHealth] = useState<SystemHealth | null>(null);
  const [loading, setLoading] = useState(true);
  const [lastChecked, setLastChecked] = useState<Date>(new Date());

  useEffect(() => {
    loadHealth();
    const interval = setInterval(() => {
      loadHealth();
    }, 30000); // Refresh every 30 seconds

    return () => clearInterval(interval);
  }, []);

  const loadHealth = async () => {
    try {
      setLoading(true);
      const data = await api.getSystemHealth();
      setHealth(data);
      setLastChecked(new Date());
    } catch (error) {
      console.error('Failed to load system health:', error);
    } finally {
      setLoading(false);
    }
  };

  const formatUptime = (seconds: number) => {
    const days = Math.floor(seconds / 86400);
    const hours = Math.floor((seconds % 86400) / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);

    if (days > 0) return `${days}d ${hours}h ${minutes}m`;
    if (hours > 0) return `${hours}h ${minutes}m`;
    return `${minutes}m`;
  };

  if (loading && !health) {
    return (
      <DashboardLayout activeTab="dashboard">
        <div className="flex items-center justify-center h-96">
          <Loader size="lg" />
        </div>
      </DashboardLayout>
    );
  }

  const getStatusIcon = () => {
    if (!health) return <AlertCircle className="w-6 h-6 text-red-600" />;
    switch (health.status) {
      case 'ok':
        return <CheckCircle className="w-6 h-6 text-green-600" />;
      case 'warning':
        return <AlertCircle className="w-6 h-6 text-yellow-600" />;
      case 'error':
        return <AlertCircle className="w-6 h-6 text-red-600" />;
      default:
        return <AlertCircle className="w-6 h-6 text-gray-600" />;
    }
  };

  const getStatusColor = () => {
    if (!health) return 'bg-red-100 text-red-700';
    switch (health.status) {
      case 'ok':
        return 'bg-green-100 text-green-700';
      case 'warning':
        return 'bg-yellow-100 text-yellow-700';
      case 'error':
        return 'bg-red-100 text-red-700';
      default:
        return 'bg-gray-100 text-gray-700';
    }
  };

  return (
    <DashboardLayout activeTab="dashboard">
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-900">System Health Dashboard</h1>
          <div className="text-sm text-gray-500">
            <Clock className="w-4 h-4 inline mr-1" />
            Last checked: {lastChecked.toLocaleTimeString()}
          </div>
        </div>

        {/* Overall Status */}
        <Card>
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-4">
              {getStatusIcon()}
              <div>
                <h2 className="text-xl font-bold text-gray-900">System Status</h2>
                <p className="text-sm text-gray-500">Overall system health</p>
              </div>
            </div>
            <span className={`px-4 py-2 text-sm font-medium rounded-full ${getStatusColor()}`}>
              {health?.status.toUpperCase() || 'UNKNOWN'}
            </span>
          </div>
        </Card>

        {/* System Metrics */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <Card>
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-600">Server Uptime</p>
                <p className="text-2xl font-bold text-gray-900 mt-1">
                  {health ? formatUptime(health.uptime) : 'N/A'}
                </p>
                <p className="text-xs text-gray-500 mt-1">
                  {health && new Date(health.timestamp).toLocaleString()}
                </p>
              </div>
              <div className="p-3 bg-blue-100 rounded-full">
                <Activity className="w-6 h-6 text-blue-600" />
              </div>
            </div>
          </Card>

          <Card>
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-600">Database Status</p>
                <p className="text-2xl font-bold text-gray-900 mt-1">
                  {health?.database.connected ? 'Connected' : 'Disconnected'}
                </p>
                {health?.database.size && (
                  <p className="text-xs text-gray-500 mt-1">Size: {health.database.size}</p>
                )}
              </div>
              <div className="p-3 bg-green-100 rounded-full">
                <Database className="w-6 h-6 text-green-600" />
              </div>
            </div>
          </Card>

          <Card>
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-600">API Status</p>
                <p className="text-2xl font-bold text-gray-900 mt-1">
                  {health ? 'Operational' : 'Down'}
                </p>
                <p className="text-xs text-gray-500 mt-1">
                  {process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api'}
                </p>
              </div>
              <div className="p-3 bg-purple-100 rounded-full">
                <Server className="w-6 h-6 text-purple-600" />
              </div>
            </div>
          </Card>
        </div>

        {/* Memory Usage (if available) */}
        {health?.memory && (
          <Card title="Memory Usage" subtitle="Server memory statistics">
            <div className="space-y-4">
              <div className="flex justify-between text-sm">
                <span className="text-gray-600">Used / Total</span>
                <span className="font-medium">
                  {(health.memory.used / 1024 / 1024).toFixed(2)} MB /{' '}
                  {(health.memory.total / 1024 / 1024).toFixed(2)} MB
                </span>
              </div>
              <div className="w-full bg-gray-200 rounded-full h-4">
                <div
                  className={`h-4 rounded-full ${
                    health.memory.percentage > 80
                      ? 'bg-red-500'
                      : health.memory.percentage > 60
                      ? 'bg-yellow-500'
                      : 'bg-green-500'
                  }`}
                  style={{ width: `${health.memory.percentage}%` }}
                />
              </div>
              <div className="flex justify-between text-sm">
                <span className="text-gray-600">Usage Percentage</span>
                <span className="font-medium">{health.memory.percentage.toFixed(1)}%</span>
              </div>
            </div>
          </Card>
        )}

        {/* API Endpoints Overview */}
        <Card title="API Endpoints" subtitle="Available endpoints overview">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="p-4 border border-gray-200 rounded-lg">
              <h4 className="font-semibold text-gray-900 mb-2">Authentication</h4>
              <ul className="text-sm text-gray-600 space-y-1">
                <li>• POST /api/auth/login</li>
                <li>• POST /api/auth/register</li>
                <li>• GET /api/auth/me</li>
              </ul>
            </div>
            <div className="p-4 border border-gray-200 rounded-lg">
              <h4 className="font-semibold text-gray-900 mb-2">Meals</h4>
              <ul className="text-sm text-gray-600 space-y-1">
                <li>• GET /api/meals</li>
                <li>• POST /api/meals</li>
                <li>• GET /api/meals/schedules</li>
              </ul>
            </div>
            <div className="p-4 border border-gray-200 rounded-lg">
              <h4 className="font-semibold text-gray-900 mb-2">Orders</h4>
              <ul className="text-sm text-gray-600 space-y-1">
                <li>• GET /api/orders</li>
                <li>• POST /api/orders</li>
                <li>• PATCH /api/orders/:id/status</li>
              </ul>
            </div>
            <div className="p-4 border border-gray-200 rounded-lg">
              <h4 className="font-semibold text-gray-900 mb-2">Analytics</h4>
              <ul className="text-sm text-gray-600 space-y-1">
                <li>• GET /api/analytics/cafeteria/dashboard</li>
                <li>• GET /api/analytics/university/insights</li>
                <li>• GET /api/analytics/university/revenue</li>
              </ul>
            </div>
            <div className="p-4 border border-gray-200 rounded-lg">
              <h4 className="font-semibold text-gray-900 mb-2">Budget</h4>
              <ul className="text-sm text-gray-600 space-y-1">
                <li>• GET /api/budget</li>
                <li>• POST /api/budget</li>
                <li>• GET /api/budget/:id</li>
              </ul>
            </div>
            <div className="p-4 border border-gray-200 rounded-lg">
              <h4 className="font-semibold text-gray-900 mb-2">Wallet</h4>
              <ul className="text-sm text-gray-600 space-y-1">
                <li>• GET /api/wallet/balance</li>
                <li>• POST /api/wallet/topup</li>
                <li>• GET /api/wallet/transactions</li>
              </ul>
            </div>
          </div>
        </Card>

        {/* Database Information */}
        <Card title="Database Information" subtitle="SQLite database details">
          <div className="space-y-3">
            <div className="flex justify-between items-center p-3 bg-gray-50 rounded">
              <span className="text-sm font-medium text-gray-700">Database Type</span>
              <span className="text-sm text-gray-900">SQLite</span>
            </div>
            <div className="flex justify-between items-center p-3 bg-gray-50 rounded">
              <span className="text-sm font-medium text-gray-700">Connection Status</span>
              <span
                className={`text-sm font-semibold ${
                  health?.database.connected ? 'text-green-600' : 'text-red-600'
                }`}
              >
                {health?.database.connected ? 'Connected' : 'Disconnected'}
              </span>
            </div>
            {health?.database.size && (
              <div className="flex justify-between items-center p-3 bg-gray-50 rounded">
                <span className="text-sm font-medium text-gray-700">Database Size</span>
                <span className="text-sm text-gray-900">{health.database.size}</span>
              </div>
            )}
            <div className="flex justify-between items-center p-3 bg-gray-50 rounded">
              <span className="text-sm font-medium text-gray-700">Total Tables</span>
              <span className="text-sm text-gray-900">13</span>
            </div>
          </div>
        </Card>

        {/* System Actions */}
        <Card title="System Actions" subtitle="Administrative actions">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <button
              onClick={loadHealth}
              className="p-4 border-2 border-primary-500 text-primary-600 rounded-lg hover:bg-primary-50 transition-colors font-medium"
            >
              Refresh Status
            </button>
            <button
              className="p-4 border-2 border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-medium"
              onClick={() => alert('Database backup feature coming soon')}
            >
              Backup Database
            </button>
            <button
              className="p-4 border-2 border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-medium"
              onClick={() => alert('View logs feature coming soon')}
            >
              View Logs
            </button>
          </div>
        </Card>
      </div>
    </DashboardLayout>
  );
}
