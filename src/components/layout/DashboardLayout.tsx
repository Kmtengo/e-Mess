'use client';

import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import {
  LayoutDashboard,
  UtensilsCrossed,
  Calendar,
  DollarSign,
  TrendingUp,
  Settings,
  LogOut,
  Menu,
  X
} from 'lucide-react';
import { getCurrentUser, hasRole } from '@/lib/auth';
import { api } from '@/lib/api';
import type { User } from '@/types';

interface DashboardLayoutProps {
  children: React.ReactNode;
  activeTab?: string;
}

export const DashboardLayout: React.FC<DashboardLayoutProps> = ({ children, activeTab }) => {
  const router = useRouter();
  const [user, setUser] = useState<User | null>(null);
  const [sidebarOpen, setSidebarOpen] = useState(false);

  useEffect(() => {
    const currentUser = getCurrentUser();
    if (!currentUser) {
      router.push('/login');
      return;
    }
    setUser(currentUser);
  }, [router]);

  const handleLogout = async () => {
    await api.logout();
    router.push('/login');
  };

  if (!user) return null;

  // Navigation items based on user role
  const getNavigationItems = () => {
    if (user.user_type === 'cafeteria_manager') {
      return [
        { name: 'Dashboard', href: '/cafeteria', icon: LayoutDashboard },
        { name: 'Meals', href: '/cafeteria/meals', icon: UtensilsCrossed },
        { name: 'Scheduling', href: '/cafeteria/scheduling', icon: Calendar },
        { name: 'Budget Planning', href: '/cafeteria/budget', icon: DollarSign },
        { name: 'Analytics', href: '/cafeteria/analytics', icon: TrendingUp },
      ];
    }

    if (user.user_type === 'university_admin') {
      return [
        { name: 'Dashboard', href: '/university', icon: LayoutDashboard },
        { name: 'Insights', href: '/university/insights', icon: TrendingUp },
        { name: 'Budget Analysis', href: '/university/budgets', icon: DollarSign },
        { name: 'Reports', href: '/university/reports', icon: TrendingUp },
      ];
    }

    // Admin
    return [
      { name: 'Dashboard', href: '/admin', icon: LayoutDashboard },
      { name: 'System Health', href: '/admin/health', icon: Settings },
      { name: 'Database', href: '/admin/database', icon: Settings },
    ];
  };

  const navigationItems = getNavigationItems();

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Mobile sidebar backdrop */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 bg-gray-600 bg-opacity-75 z-20 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside
        className={`fixed inset-y-0 left-0 z-30 w-64 bg-white shadow-lg transform transition-transform duration-300 ease-in-out lg:translate-x-0 ${
          sidebarOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        <div className="flex flex-col h-full">
          {/* Logo */}
          <div className="flex items-center justify-between h-16 px-6 border-b border-gray-200">
            <h1 className="text-xl font-bold text-primary-600">e-Mess</h1>
            <button
              onClick={() => setSidebarOpen(false)}
              className="lg:hidden text-gray-500 hover:text-gray-700"
            >
              <X className="w-6 h-6" />
            </button>
          </div>

          {/* Navigation */}
          <nav className="flex-1 px-4 py-6 space-y-2 overflow-y-auto">
            {navigationItems.map((item) => {
              const Icon = item.icon;
              const isActive = activeTab === item.name.toLowerCase().replace(/\s+/g, '-');
              return (
                <Link
                  key={item.name}
                  href={item.href}
                  className={`flex items-center px-4 py-3 text-sm font-medium rounded-lg transition-colors ${
                    isActive
                      ? 'bg-primary-50 text-primary-700'
                      : 'text-gray-700 hover:bg-gray-50'
                  }`}
                >
                  <Icon className="w-5 h-5 mr-3" />
                  {item.name}
                </Link>
              );
            })}
          </nav>

          {/* User section */}
          <div className="p-4 border-t border-gray-200">
            <div className="px-4 py-3 bg-gray-50 rounded-lg">
              <p className="text-sm font-medium text-gray-900">{user.full_name}</p>
              <p className="text-xs text-gray-500 capitalize">{user.user_type.replace('_', ' ')}</p>
            </div>
            <button
              onClick={handleLogout}
              className="flex items-center w-full px-4 py-3 mt-2 text-sm font-medium text-red-600 rounded-lg hover:bg-red-50 transition-colors"
            >
              <LogOut className="w-5 h-5 mr-3" />
              Logout
            </button>
          </div>
        </div>
      </aside>

      {/* Main content */}
      <div className="lg:pl-64">
        {/* Top bar */}
        <header className="h-16 bg-white shadow-sm border-b border-gray-200 flex items-center justify-between px-6">
          <button
            onClick={() => setSidebarOpen(true)}
            className="lg:hidden text-gray-500 hover:text-gray-700"
          >
            <Menu className="w-6 h-6" />
          </button>
          <div className="flex-1 lg:ml-0 ml-4">
            <h2 className="text-lg font-semibold text-gray-900 capitalize">
              {activeTab?.replace(/-/g, ' ') || 'Dashboard'}
            </h2>
          </div>
        </header>

        {/* Page content */}
        <main className="p-6">{children}</main>
      </div>
    </div>
  );
};
