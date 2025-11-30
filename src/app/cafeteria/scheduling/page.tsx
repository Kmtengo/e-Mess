'use client';

import React, { useEffect, useState } from 'react';
import { DashboardLayout } from '@/components/layout/DashboardLayout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { Input } from '@/components/ui/Input';
import { Select } from '@/components/ui/Select';
import { Loader } from '@/components/ui/Loader';
import { api } from '@/lib/api';
import { Meal, MealSchedule, MealTime } from '@/types';
import { Plus, Calendar as CalendarIcon } from 'lucide-react';
import { format, addDays, startOfWeek } from 'date-fns';

export default function SchedulingPage() {
  const [schedules, setSchedules] = useState<MealSchedule[]>([]);
  const [meals, setMeals] = useState<Meal[]>([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [selectedDate, setSelectedDate] = useState(format(new Date(), 'yyyy-MM-dd'));
  const [selectedMealTime, setSelectedMealTime] = useState<MealTime | ''>('');

  const [formData, setFormData] = useState({
    meal_id: '',
    schedule_date: format(new Date(), 'yyyy-MM-dd'),
    meal_time: 'lunch' as MealTime,
    quantity_available: '',
  });

  useEffect(() => {
    loadData();
  }, [selectedDate, selectedMealTime]);

  const loadData = async () => {
    try {
      setLoading(true);
      const [schedulesData, mealsData] = await Promise.all([
        api.getMealSchedules(selectedDate, selectedMealTime || undefined),
        api.getMeals(),
      ]);
      setSchedules(schedulesData);
      setMeals(mealsData);
    } catch (error) {
      console.error('Failed to load data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await api.createMealSchedule({
        meal_id: parseInt(formData.meal_id),
        schedule_date: formData.schedule_date,
        meal_time: formData.meal_time,
        quantity_available: parseInt(formData.quantity_available),
      });
      setShowModal(false);
      resetForm();
      loadData();
    } catch (error) {
      console.error('Failed to create schedule:', error);
    }
  };

  const resetForm = () => {
    setFormData({
      meal_id: '',
      schedule_date: format(new Date(), 'yyyy-MM-dd'),
      meal_time: 'lunch',
      quantity_available: '',
    });
  };

  const mealTimes: { value: MealTime; label: string }[] = [
    { value: 'breakfast', label: 'Breakfast' },
    { value: 'lunch', label: 'Lunch' },
    { value: 'dinner', label: 'Dinner' },
    { value: 'snack', label: 'Snack' },
  ];

  const getWeekDates = () => {
    const start = startOfWeek(new Date(), { weekStartsOn: 1 });
    return Array.from({ length: 7 }, (_, i) => addDays(start, i));
  };

  if (loading) {
    return (
      <DashboardLayout activeTab="scheduling">
        <div className="flex items-center justify-center h-96">
          <Loader size="lg" />
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout activeTab="scheduling">
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-900">Meal Scheduling</h1>
          <Button onClick={() => setShowModal(true)}>
            <Plus className="w-4 h-4 mr-2" />
            Schedule Meal
          </Button>
        </div>

        {/* Filters */}
        <Card>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Input
              type="date"
              label="Date"
              value={selectedDate}
              onChange={(e) => setSelectedDate(e.target.value)}
            />
            <Select
              label="Meal Time"
              value={selectedMealTime}
              onChange={(e) => setSelectedMealTime(e.target.value as MealTime | '')}
              options={[
                { value: '', label: 'All Meal Times' },
                ...mealTimes,
              ]}
            />
          </div>
        </Card>

        {/* Quick Week View */}
        <Card title="This Week's Schedule">
          <div className="grid grid-cols-1 md:grid-cols-7 gap-4">
            {getWeekDates().map((date) => {
              const dateStr = format(date, 'yyyy-MM-dd');
              const daySchedules = schedules.filter((s) => s.schedule_date === dateStr);
              const isToday = dateStr === format(new Date(), 'yyyy-MM-dd');

              return (
                <div
                  key={dateStr}
                  className={`p-4 border rounded-lg ${
                    isToday ? 'border-primary-500 bg-primary-50' : 'border-gray-200'
                  }`}
                >
                  <div className="text-center mb-2">
                    <p className="text-xs text-gray-500">{format(date, 'EEE')}</p>
                    <p className="text-lg font-semibold">{format(date, 'd')}</p>
                  </div>
                  <div className="space-y-1">
                    <p className="text-xs text-gray-500">{daySchedules.length} meals</p>
                    <Button
                      size="sm"
                      variant="ghost"
                      className="w-full"
                      onClick={() => setSelectedDate(dateStr)}
                    >
                      View
                    </Button>
                  </div>
                </div>
              );
            })}
          </div>
        </Card>

        {/* Schedules Table */}
        <Card title={`Meals for ${format(new Date(selectedDate), 'MMMM dd, yyyy')}`}>
          {schedules.length === 0 ? (
            <div className="text-center py-12 text-gray-500">
              No meals scheduled for this date
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                      Meal Time
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                      Meal Name
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                      Category
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                      Available
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                      Ordered
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                      Remaining
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                      Price
                    </th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {schedules.map((schedule) => (
                    <tr key={schedule.id}>
                      <td className="px-6 py-4 whitespace-nowrap text-sm">
                        <span className="px-2 py-1 text-xs font-medium rounded-full bg-blue-100 text-blue-700 capitalize">
                          {schedule.meal_time}
                        </span>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                        {schedule.name}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        {schedule.category_name}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        {schedule.quantity_available}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        {schedule.quantity_ordered || 0}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm">
                        <span
                          className={`font-medium ${
                            (schedule.remaining_quantity || 0) > 10
                              ? 'text-green-600'
                              : 'text-red-600'
                          }`}
                        >
                          {schedule.remaining_quantity || schedule.quantity_available}
                        </span>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        {new Intl.NumberFormat('en-UG', {
                          style: 'currency',
                          currency: 'UGX',
                          minimumFractionDigits: 0,
                        }).format(schedule.price || 0)}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </Card>
      </div>

      {/* Modal */}
      {showModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg max-w-md w-full p-6">
            <h2 className="text-xl font-bold mb-4">Schedule Meal</h2>
            <form onSubmit={handleSubmit} className="space-y-4">
              <Select
                label="Meal"
                value={formData.meal_id}
                onChange={(e) => setFormData({ ...formData, meal_id: e.target.value })}
                options={[
                  { value: '', label: 'Select Meal' },
                  ...meals.map((meal) => ({
                    value: meal.id,
                    label: `${meal.name} - ${new Intl.NumberFormat('en-UG', {
                      style: 'currency',
                      currency: 'UGX',
                      minimumFractionDigits: 0,
                    }).format(meal.price)}`,
                  })),
                ]}
                required
              />
              <Input
                label="Date"
                type="date"
                value={formData.schedule_date}
                onChange={(e) => setFormData({ ...formData, schedule_date: e.target.value })}
                required
              />
              <Select
                label="Meal Time"
                value={formData.meal_time}
                onChange={(e) => setFormData({ ...formData, meal_time: e.target.value as MealTime })}
                options={mealTimes}
                required
              />
              <Input
                label="Quantity Available"
                type="number"
                min="1"
                value={formData.quantity_available}
                onChange={(e) => setFormData({ ...formData, quantity_available: e.target.value })}
                required
              />
              <div className="flex space-x-3">
                <Button type="submit" className="flex-1">
                  Schedule
                </Button>
                <Button
                  type="button"
                  variant="secondary"
                  className="flex-1"
                  onClick={() => {
                    setShowModal(false);
                    resetForm();
                  }}
                >
                  Cancel
                </Button>
              </div>
            </form>
          </div>
        </div>
      )}
    </DashboardLayout>
  );
}
