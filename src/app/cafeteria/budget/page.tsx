'use client';

import React, { useEffect, useState } from 'react';
import { DashboardLayout } from '@/components/layout/DashboardLayout';
import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { Input } from '@/components/ui/Input';
import { Select } from '@/components/ui/Select';
import { Loader } from '@/components/ui/Loader';
import { api } from '@/lib/api';
import { BudgetPlan, BudgetPlanItem, Meal, BudgetPlanType, BudgetStatus } from '@/types';
import { Plus, Eye, X } from 'lucide-react';
import { format } from 'date-fns';

export default function BudgetPage() {
  const [budgets, setBudgets] = useState<BudgetPlan[]>([]);
  const [meals, setMeals] = useState<Meal[]>([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [viewingBudget, setViewingBudget] = useState<BudgetPlan | null>(null);
  const [selectedStatus, setSelectedStatus] = useState<BudgetStatus | ''>('');

  const [formData, setFormData] = useState({
    plan_name: '',
    plan_type: 'weekly' as BudgetPlanType,
    start_date: format(new Date(), 'yyyy-MM-dd'),
    end_date: format(new Date(), 'yyyy-MM-dd'),
    total_budget: '',
  });

  const [budgetItems, setBudgetItems] = useState<Omit<BudgetPlanItem, 'id' | 'meal_name' | 'total_cost' | 'actual_quantity' | 'actual_cost'>[]>([
    { meal_id: 0, estimated_quantity: 0, unit_cost: 0, notes: '' },
  ]);

  useEffect(() => {
    loadData();
  }, [selectedStatus]);

  const loadData = async () => {
    try {
      setLoading(true);
      const [budgetsData, mealsData] = await Promise.all([
        api.getBudgetPlans(selectedStatus || undefined),
        api.getMeals(),
      ]);
      setBudgets(budgetsData);
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
      await api.createBudgetPlan({
        ...formData,
        total_budget: parseFloat(formData.total_budget),
        items: budgetItems.filter(item => item.meal_id > 0),
      });
      setShowModal(false);
      resetForm();
      loadData();
    } catch (error) {
      console.error('Failed to create budget:', error);
    }
  };

  const resetForm = () => {
    setFormData({
      plan_name: '',
      plan_type: 'weekly',
      start_date: format(new Date(), 'yyyy-MM-dd'),
      end_date: format(new Date(), 'yyyy-MM-dd'),
      total_budget: '',
    });
    setBudgetItems([{ meal_id: 0, estimated_quantity: 0, unit_cost: 0, notes: '' }]);
  };

  const addBudgetItem = () => {
    setBudgetItems([...budgetItems, { meal_id: 0, estimated_quantity: 0, unit_cost: 0, notes: '' }]);
  };

  const removeBudgetItem = (index: number) => {
    setBudgetItems(budgetItems.filter((_, i) => i !== index));
  };

  const updateBudgetItem = (index: number, field: keyof BudgetPlanItem, value: any) => {
    const updated = [...budgetItems];
    updated[index] = { ...updated[index], [field]: value };
    setBudgetItems(updated);
  };

  const getTotalEstimatedCost = () => {
    return budgetItems.reduce((sum, item) => sum + (item.estimated_quantity * item.unit_cost), 0);
  };

  const viewBudgetDetails = async (budgetId: number) => {
    try {
      const budget = await api.getBudgetPlan(budgetId);
      setViewingBudget(budget);
    } catch (error) {
      console.error('Failed to load budget details:', error);
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('en-UG', {
      style: 'currency',
      currency: 'UGX',
      minimumFractionDigits: 0,
    }).format(value);
  };

  const getStatusColor = (status: BudgetStatus) => {
    const colors = {
      draft: 'bg-gray-100 text-gray-700',
      active: 'bg-blue-100 text-blue-700',
      completed: 'bg-green-100 text-green-700',
      cancelled: 'bg-red-100 text-red-700',
    };
    return colors[status];
  };

  if (loading) {
    return (
      <DashboardLayout activeTab="budget-planning">
        <div className="flex items-center justify-center h-96">
          <Loader size="lg" />
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout activeTab="budget-planning">
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-2xl font-bold text-gray-900">Budget Planning</h1>
          <Button onClick={() => setShowModal(true)}>
            <Plus className="w-4 h-4 mr-2" />
            Create Budget Plan
          </Button>
        </div>

        {/* Filter */}
        <Card>
          <Select
            label="Filter by Status"
            value={selectedStatus}
            onChange={(e) => setSelectedStatus(e.target.value as BudgetStatus | '')}
            options={[
              { value: '', label: 'All Statuses' },
              { value: 'draft', label: 'Draft' },
              { value: 'active', label: 'Active' },
              { value: 'completed', label: 'Completed' },
              { value: 'cancelled', label: 'Cancelled' },
            ]}
          />
        </Card>

        {/* Budgets List */}
        <div className="space-y-4">
          {budgets.length === 0 ? (
            <Card>
              <div className="text-center py-12 text-gray-500">
                No budget plans found
              </div>
            </Card>
          ) : (
            budgets.map((budget) => (
              <Card key={budget.id}>
                <div className="space-y-4">
                  <div className="flex justify-between items-start">
                    <div>
                      <h3 className="text-lg font-semibold text-gray-900">{budget.plan_name}</h3>
                      <p className="text-sm text-gray-500 mt-1">
                        {format(new Date(budget.start_date), 'MMM dd, yyyy')} -{' '}
                        {format(new Date(budget.end_date), 'MMM dd, yyyy')}
                      </p>
                    </div>
                    <div className="flex items-center space-x-2">
                      <span className={`px-3 py-1 text-xs font-medium rounded-full capitalize ${getStatusColor(budget.status)}`}>
                        {budget.status}
                      </span>
                      <Button
                        size="sm"
                        variant="ghost"
                        onClick={() => viewBudgetDetails(budget.id)}
                      >
                        <Eye className="w-4 h-4" />
                      </Button>
                    </div>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div>
                      <p className="text-sm text-gray-500">Total Budget</p>
                      <p className="text-lg font-semibold text-gray-900">
                        {formatCurrency(budget.total_budget)}
                      </p>
                    </div>
                    <div>
                      <p className="text-sm text-gray-500">Estimated Cost</p>
                      <p className="text-lg font-semibold text-gray-900">
                        {formatCurrency(budget.estimated_cost)}
                      </p>
                    </div>
                    <div>
                      <p className="text-sm text-gray-500">Actual Cost</p>
                      <p className="text-lg font-semibold text-gray-900">
                        {formatCurrency(budget.actual_cost)}
                      </p>
                    </div>
                    <div>
                      <p className="text-sm text-gray-500">Variance</p>
                      <p className={`text-lg font-semibold ${
                        budget.actual_cost <= budget.total_budget ? 'text-green-600' : 'text-red-600'
                      }`}>
                        {formatCurrency(budget.total_budget - budget.actual_cost)}
                      </p>
                    </div>
                  </div>

                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div
                      className={`h-2 rounded-full ${
                        budget.actual_cost <= budget.total_budget ? 'bg-green-500' : 'bg-red-500'
                      }`}
                      style={{
                        width: `${Math.min((budget.actual_cost / budget.total_budget) * 100, 100)}%`,
                      }}
                    />
                  </div>
                </div>
              </Card>
            ))
          )}
        </div>
      </div>

      {/* Create Budget Modal */}
      {showModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4 overflow-y-auto">
          <div className="bg-white rounded-lg max-w-4xl w-full p-6 my-8">
            <h2 className="text-xl font-bold mb-4">Create Budget Plan</h2>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <Input
                  label="Plan Name"
                  value={formData.plan_name}
                  onChange={(e) => setFormData({ ...formData, plan_name: e.target.value })}
                  required
                />
                <Select
                  label="Plan Type"
                  value={formData.plan_type}
                  onChange={(e) => setFormData({ ...formData, plan_type: e.target.value as BudgetPlanType })}
                  options={[
                    { value: 'weekly', label: 'Weekly' },
                    { value: 'monthly', label: 'Monthly' },
                  ]}
                  required
                />
                <Input
                  label="Start Date"
                  type="date"
                  value={formData.start_date}
                  onChange={(e) => setFormData({ ...formData, start_date: e.target.value })}
                  required
                />
                <Input
                  label="End Date"
                  type="date"
                  value={formData.end_date}
                  onChange={(e) => setFormData({ ...formData, end_date: e.target.value })}
                  required
                />
                <Input
                  label="Total Budget (UGX)"
                  type="number"
                  step="1000"
                  value={formData.total_budget}
                  onChange={(e) => setFormData({ ...formData, total_budget: e.target.value })}
                  required
                />
              </div>

              <div className="border-t pt-4">
                <div className="flex justify-between items-center mb-4">
                  <h3 className="text-lg font-semibold">Budget Items</h3>
                  <Button type="button" size="sm" onClick={addBudgetItem}>
                    <Plus className="w-4 h-4 mr-2" />
                    Add Item
                  </Button>
                </div>

                <div className="space-y-4 max-h-96 overflow-y-auto">
                  {budgetItems.map((item, index) => (
                    <div key={index} className="flex gap-2 items-end">
                      <Select
                        label="Meal"
                        value={item.meal_id}
                        onChange={(e) => updateBudgetItem(index, 'meal_id', parseInt(e.target.value))}
                        options={[
                          { value: 0, label: 'Select Meal' },
                          ...meals.map((meal) => ({ value: meal.id, label: meal.name })),
                        ]}
                        required
                      />
                      <Input
                        label="Quantity"
                        type="number"
                        min="1"
                        value={item.estimated_quantity}
                        onChange={(e) => updateBudgetItem(index, 'estimated_quantity', parseInt(e.target.value))}
                        required
                      />
                      <Input
                        label="Unit Cost"
                        type="number"
                        step="100"
                        value={item.unit_cost}
                        onChange={(e) => updateBudgetItem(index, 'unit_cost', parseFloat(e.target.value))}
                        required
                      />
                      <Input
                        label="Notes"
                        value={item.notes}
                        onChange={(e) => updateBudgetItem(index, 'notes', e.target.value)}
                      />
                      <Button
                        type="button"
                        variant="danger"
                        size="sm"
                        onClick={() => removeBudgetItem(index)}
                        disabled={budgetItems.length === 1}
                      >
                        <X className="w-4 h-4" />
                      </Button>
                    </div>
                  ))}
                </div>

                <div className="mt-4 p-4 bg-gray-50 rounded-lg">
                  <p className="text-sm text-gray-600">
                    Total Estimated Cost: <span className="font-semibold">{formatCurrency(getTotalEstimatedCost())}</span>
                  </p>
                </div>
              </div>

              <div className="flex space-x-3">
                <Button type="submit" className="flex-1">
                  Create Budget Plan
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

      {/* View Budget Modal */}
      {viewingBudget && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4 overflow-y-auto">
          <div className="bg-white rounded-lg max-w-4xl w-full p-6 my-8">
            <div className="flex justify-between items-start mb-4">
              <div>
                <h2 className="text-xl font-bold">{viewingBudget.plan_name}</h2>
                <p className="text-sm text-gray-500 mt-1">
                  {format(new Date(viewingBudget.start_date), 'MMM dd, yyyy')} -{' '}
                  {format(new Date(viewingBudget.end_date), 'MMM dd, yyyy')}
                </p>
              </div>
              <Button variant="ghost" onClick={() => setViewingBudget(null)}>
                <X className="w-5 h-5" />
              </Button>
            </div>

            <div className="grid grid-cols-3 gap-4 mb-6">
              <div className="p-4 bg-blue-50 rounded-lg">
                <p className="text-sm text-gray-600">Total Budget</p>
                <p className="text-xl font-bold text-gray-900">
                  {formatCurrency(viewingBudget.total_budget)}
                </p>
              </div>
              <div className="p-4 bg-yellow-50 rounded-lg">
                <p className="text-sm text-gray-600">Estimated Cost</p>
                <p className="text-xl font-bold text-gray-900">
                  {formatCurrency(viewingBudget.estimated_cost)}
                </p>
              </div>
              <div className="p-4 bg-green-50 rounded-lg">
                <p className="text-sm text-gray-600">Actual Cost</p>
                <p className="text-xl font-bold text-gray-900">
                  {formatCurrency(viewingBudget.actual_cost)}
                </p>
              </div>
            </div>

            {viewingBudget.items && viewingBudget.items.length > 0 && (
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Meal
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Est. Qty
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Unit Cost
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Est. Total
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Actual Qty
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Actual Cost
                      </th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-200">
                    {viewingBudget.items.map((item) => (
                      <tr key={item.id}>
                        <td className="px-6 py-4 text-sm font-medium text-gray-900">
                          {item.meal_name}
                        </td>
                        <td className="px-6 py-4 text-sm text-gray-500">
                          {item.estimated_quantity}
                        </td>
                        <td className="px-6 py-4 text-sm text-gray-500">
                          {formatCurrency(item.unit_cost)}
                        </td>
                        <td className="px-6 py-4 text-sm text-gray-500">
                          {formatCurrency(item.estimated_quantity * item.unit_cost)}
                        </td>
                        <td className="px-6 py-4 text-sm text-gray-500">
                          {item.actual_quantity || 0}
                        </td>
                        <td className="px-6 py-4 text-sm text-gray-500">
                          {formatCurrency(item.actual_cost || 0)}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>
      )}
    </DashboardLayout>
  );
}
