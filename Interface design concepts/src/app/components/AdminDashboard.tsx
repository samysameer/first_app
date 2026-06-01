import { Users, Activity, CheckCircle, AlertTriangle, TrendingUp, MapPin, Clock, Shield } from 'lucide-react';
import { BarChart, Bar, LineChart, Line, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

export function AdminDashboard() {
  const statsData = [
    { name: 'Mon', requests: 45, fulfilled: 38 },
    { name: 'Tue', requests: 52, fulfilled: 47 },
    { name: 'Wed', requests: 38, fulfilled: 35 },
    { name: 'Thu', requests: 65, fulfilled: 58 },
    { name: 'Fri', requests: 48, fulfilled: 44 },
    { name: 'Sat', requests: 72, fulfilled: 65 },
    { name: 'Sun', requests: 55, fulfilled: 51 },
  ];

  const typeDistribution = [
    { name: 'Blood Donation', value: 45, color: '#dc2626' },
    { name: 'Medical Supplies', value: 30, color: '#ea580c' },
    { name: 'Emergency Rescue', value: 25, color: '#d97706' },
  ];

  const recentActivity = [
    { id: 1, type: 'success', message: 'Request #1234 fulfilled by Ahmed Hassan', time: '2 min ago' },
    { id: 2, type: 'warning', message: 'No response for Request #1235 (5 min)', time: '5 min ago' },
    { id: 3, type: 'info', message: 'New donor registered: Fatma Mohamed', time: '8 min ago' },
    { id: 4, type: 'success', message: 'Request #1232 completed successfully', time: '12 min ago' },
    { id: 5, type: 'info', message: 'System health check passed', time: '15 min ago' },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-blue-600 to-blue-800 text-white p-4">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="bg-white/20 p-2 rounded-full">
              <Shield className="w-6 h-6" />
            </div>
            <div>
              <h1 className="font-bold text-lg">Admin Dashboard</h1>
              <p className="text-sm text-blue-100">Real-time monitoring & analytics</p>
            </div>
          </div>
          <div className="flex items-center gap-4">
            <div className="text-right">
              <p className="text-sm text-blue-100">Last updated</p>
              <p className="font-semibold">Just now</p>
            </div>
            <div className="bg-green-500 text-white px-3 py-1 rounded-full text-sm font-medium">
              System Healthy
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto p-4">
        {/* Key Metrics */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center justify-between mb-2">
              <div className="bg-blue-100 p-3 rounded-lg">
                <Users className="w-6 h-6 text-blue-600" />
              </div>
              <span className="text-xs text-green-600 font-medium">+12% this week</span>
            </div>
            <p className="text-gray-500 text-sm">Total Donors</p>
            <p className="text-3xl font-bold text-gray-900">1,247</p>
          </div>

          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center justify-between mb-2">
              <div className="bg-red-100 p-3 rounded-lg">
                <Activity className="w-6 h-6 text-red-600" />
              </div>
              <span className="text-xs text-red-600 font-medium">24 active</span>
            </div>
            <p className="text-gray-500 text-sm">Total Requests</p>
            <p className="text-3xl font-bold text-gray-900">3,842</p>
          </div>

          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center justify-between mb-2">
              <div className="bg-green-100 p-3 rounded-lg">
                <CheckCircle className="w-6 h-6 text-green-600" />
              </div>
              <span className="text-xs text-green-600 font-medium">92% rate</span>
            </div>
            <p className="text-gray-500 text-sm">Fulfilled</p>
            <p className="text-3xl font-bold text-gray-900">3,534</p>
          </div>

          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center justify-between mb-2">
              <div className="bg-orange-100 p-3 rounded-lg">
                <Clock className="w-6 h-6 text-orange-600" />
              </div>
              <span className="text-xs text-green-600 font-medium">-2 min</span>
            </div>
            <p className="text-gray-500 text-sm">Avg Response</p>
            <p className="text-3xl font-bold text-gray-900">8 min</p>
          </div>
        </div>

        {/* Charts Row */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 mb-6">
          {/* Weekly Requests Chart */}
          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center justify-between mb-4">
              <h3 className="font-bold text-gray-900">Weekly Request Trends</h3>
              <TrendingUp className="w-5 h-5 text-green-600" />
            </div>
            <ResponsiveContainer width="100%" height={250}>
              <BarChart data={statsData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="name" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Bar dataKey="requests" fill="#3b82f6" name="Requests" />
                <Bar dataKey="fulfilled" fill="#10b981" name="Fulfilled" />
              </BarChart>
            </ResponsiveContainer>
          </div>

          {/* Request Type Distribution */}
          <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center justify-between mb-4">
              <h3 className="font-bold text-gray-900">Request Type Distribution</h3>
              <Activity className="w-5 h-5 text-blue-600" />
            </div>
            <ResponsiveContainer width="100%" height={250}>
              <PieChart>
                <Pie
                  data={typeDistribution}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  label={({ name, percent }) => `${name}: ${(percent * 100).toFixed(0)}%`}
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {typeDistribution.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Live Activity & Map */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
          {/* Recent Activity Feed */}
          <div className="lg:col-span-1 bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <h3 className="font-bold text-gray-900 mb-4">Recent Activity</h3>
            <div className="space-y-3">
              {recentActivity.map((activity) => (
                <div key={activity.id} className="flex items-start gap-3 pb-3 border-b border-gray-100 last:border-0">
                  <div className={`p-1 rounded-full mt-0.5 ${
                    activity.type === 'success' ? 'bg-green-100' :
                    activity.type === 'warning' ? 'bg-yellow-100' :
                    'bg-blue-100'
                  }`}>
                    {activity.type === 'success' && <CheckCircle className="w-4 h-4 text-green-600" />}
                    {activity.type === 'warning' && <AlertTriangle className="w-4 h-4 text-yellow-600" />}
                    {activity.type === 'info' && <Activity className="w-4 h-4 text-blue-600" />}
                  </div>
                  <div className="flex-1">
                    <p className="text-sm text-gray-900">{activity.message}</p>
                    <p className="text-xs text-gray-500 mt-0.5">{activity.time}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Live Map */}
          <div className="lg:col-span-2 bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
            <div className="p-4 border-b bg-gray-50 flex items-center justify-between">
              <h3 className="font-bold text-gray-900">Live Emergency Map</h3>
              <div className="flex gap-2 text-xs">
                <span className="flex items-center gap-1">
                  <div className="w-2 h-2 rounded-full bg-red-600"></div>
                  Critical (8)
                </span>
                <span className="flex items-center gap-1">
                  <div className="w-2 h-2 rounded-full bg-orange-500"></div>
                  High (12)
                </span>
                <span className="flex items-center gap-1">
                  <div className="w-2 h-2 rounded-full bg-amber-500"></div>
                  Medium (4)
                </span>
              </div>
            </div>
            <div className="relative h-80 bg-gray-200">
              <div className="absolute inset-0 flex items-center justify-center">
                <MapPin className="w-12 h-12 text-gray-400" />
              </div>
              {/* Mock activity pins */}
              <div className="absolute top-16 left-20 bg-red-600 text-white px-2 py-1 rounded-full text-xs font-bold shadow-lg animate-pulse">
                3
              </div>
              <div className="absolute top-32 right-24 bg-orange-500 text-white px-2 py-1 rounded-full text-xs font-bold shadow-lg">
                5
              </div>
              <div className="absolute bottom-20 left-1/3 bg-amber-500 text-white px-2 py-1 rounded-full text-xs font-bold shadow-lg">
                2
              </div>
              <div className="absolute top-1/2 right-1/3 bg-red-600 text-white px-2 py-1 rounded-full text-xs font-bold shadow-lg animate-pulse">
                1
              </div>
            </div>
          </div>
        </div>

        {/* User Management Table */}
        <div className="mt-6 bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <div className="p-4 border-b bg-gray-50 flex items-center justify-between">
            <h3 className="font-bold text-gray-900">Pending Verifications</h3>
            <button className="px-4 py-2 bg-blue-600 text-white rounded-lg text-sm font-medium hover:bg-blue-700 transition-colors">
              View All
            </button>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50 border-b">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">User</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Blood Type</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Location</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {[
                  { name: 'Ahmed Hassan', type: 'Donor', blood: 'O+', location: 'Cairo', status: 'pending' },
                  { name: 'Sara Mohamed', type: 'Donor', blood: 'A+', location: 'Giza', status: 'pending' },
                  { name: 'Omar Ali', type: 'Organization', blood: '-', location: 'Alexandria', status: 'pending' },
                ].map((user, idx) => (
                  <tr key={idx} className="hover:bg-gray-50">
                    <td className="px-6 py-4 text-sm font-medium text-gray-900">{user.name}</td>
                    <td className="px-6 py-4 text-sm text-gray-600">{user.type}</td>
                    <td className="px-6 py-4 text-sm text-gray-600">{user.blood}</td>
                    <td className="px-6 py-4 text-sm text-gray-600">{user.location}</td>
                    <td className="px-6 py-4">
                      <span className="px-2 py-1 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                        Pending
                      </span>
                    </td>
                    <td className="px-6 py-4 text-sm">
                      <button className="text-green-600 hover:text-green-700 font-medium mr-3">Approve</button>
                      <button className="text-red-600 hover:text-red-700 font-medium">Reject</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}
