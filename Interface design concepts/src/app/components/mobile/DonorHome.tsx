import { useState } from 'react';
import { Heart, Award, TrendingUp, Droplet, Navigation, MapPin, Clock, ChevronRight, Zap } from 'lucide-react';

export function DonorHome() {
  const [isAvailable, setIsAvailable] = useState(true);

  const urgentRequests = [
    {
      id: '1',
      type: 'blood',
      urgency: 'critical',
      bloodType: 'O-',
      description: 'Urgent blood transfusion for accident victim',
      location: 'Cairo University Hospital',
      distance: 1.2,
      time: '2m ago',
      matchScore: 98
    },
    {
      id: '2',
      type: 'medical',
      urgency: 'high',
      bloodType: null,
      description: 'Emergency medical supplies needed',
      location: 'Dar El Fouad Hospital',
      distance: 3.5,
      time: '8m ago',
      matchScore: 85
    },
    {
      id: '3',
      type: 'blood',
      urgency: 'medium',
      bloodType: 'A+',
      description: 'Blood needed for scheduled surgery',
      location: 'As-Salam Hospital',
      distance: 5.8,
      time: '15m ago',
      matchScore: 72
    }
  ];

  const getUrgencyStyle = (urgency: string) => {
    switch (urgency) {
      case 'critical': return 'bg-red-600 text-white';
      case 'high': return 'bg-orange-500 text-white';
      default: return 'bg-amber-500 text-white';
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-red-600 to-red-700 text-white px-4 pt-12 pb-6">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-3">
            <div className="bg-white/20 p-2 rounded-full">
              <Heart className="w-8 h-8" />
            </div>
            <div>
              <h1 className="text-xl font-bold">Welcome Back!</h1>
              <p className="text-red-100 text-sm">Ahmed Hassan • O+</p>
            </div>
          </div>
          <div className="bg-white/20 backdrop-blur-sm rounded-full px-3 py-1.5 flex items-center gap-1.5">
            <Award className="w-4 h-4" />
            <span className="font-bold text-sm">12</span>
          </div>
        </div>

        {/* Availability Toggle */}
        <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <div className={`w-3 h-3 rounded-full ${isAvailable ? 'bg-green-400 animate-pulse' : 'bg-gray-400'}`}></div>
              <div>
                <p className="font-semibold text-sm">{isAvailable ? 'Available' : 'Not Available'}</p>
                <p className="text-xs text-red-100">Status</p>
              </div>
            </div>
            <button
              onClick={() => setIsAvailable(!isAvailable)}
              className={`relative w-14 h-7 rounded-full transition-colors ${
                isAvailable ? 'bg-green-500' : 'bg-gray-400'
              }`}
            >
              <div className={`absolute top-0.5 w-6 h-6 bg-white rounded-full shadow-md transition-transform ${
                isAvailable ? 'right-0.5' : 'left-0.5'
              }`}></div>
            </button>
          </div>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="px-4 -mt-4 mb-4">
        <div className="bg-white rounded-2xl shadow-lg border border-gray-200 p-4">
          <div className="grid grid-cols-3 divide-x divide-gray-200">
            <div className="text-center px-2">
              <p className="text-2xl font-bold text-red-600">12</p>
              <p className="text-xs text-gray-600 mt-1">Lives Saved</p>
            </div>
            <div className="text-center px-2">
              <p className="text-2xl font-bold text-blue-600">8m</p>
              <p className="text-xs text-gray-600 mt-1">Avg Response</p>
            </div>
            <div className="text-center px-2">
              <p className="text-2xl font-bold text-yellow-600">4.9</p>
              <p className="text-xs text-gray-600 mt-1">Rating</p>
            </div>
          </div>
        </div>
      </div>

      {/* Quick Stats */}
      <div className="px-4 mb-4">
        <div className="bg-gradient-to-r from-blue-50 to-blue-100 rounded-xl p-4 flex items-center justify-between border border-blue-200">
          <div className="flex items-center gap-3">
            <div className="bg-blue-600 p-2 rounded-lg">
              <TrendingUp className="w-5 h-5 text-white" />
            </div>
            <div>
              <p className="font-semibold text-gray-900">This Week</p>
              <p className="text-sm text-gray-600">3 donations completed</p>
            </div>
          </div>
          <ChevronRight className="w-5 h-5 text-blue-600" />
        </div>
      </div>

      {/* Emergency Requests */}
      <div className="px-4 mb-4">
        <div className="flex items-center justify-between mb-3">
          <h2 className="font-bold text-gray-900 text-lg">Nearby Emergencies</h2>
          <div className="bg-red-100 text-red-600 px-2 py-1 rounded-full text-xs font-bold">
            {urgentRequests.length} Active
          </div>
        </div>

        <div className="space-y-3">
          {urgentRequests.map((request) => (
            <div key={request.id} className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
              {/* Header */}
              <div className="p-4">
                <div className="flex items-start justify-between mb-3">
                  <div className="flex items-center gap-2">
                    <span className={`px-2 py-1 rounded-lg text-xs font-bold ${getUrgencyStyle(request.urgency)}`}>
                      {request.urgency.toUpperCase()}
                    </span>
                    {request.bloodType && (
                      <span className="px-2 py-1 rounded-lg text-xs font-bold bg-red-100 text-red-700">
                        {request.bloodType}
                      </span>
                    )}
                  </div>
                  <div className="flex items-center gap-1 bg-green-50 px-2 py-1 rounded-lg">
                    <Zap className="w-3 h-3 text-green-600" />
                    <span className="text-xs font-bold text-green-600">{request.matchScore}%</span>
                  </div>
                </div>

                <p className="font-semibold text-gray-900 mb-3 leading-tight">
                  {request.description}
                </p>

                <div className="space-y-2 text-sm">
                  <div className="flex items-center gap-2 text-gray-600">
                    <MapPin className="w-4 h-4 flex-shrink-0" />
                    <span className="flex-1">{request.location}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2 text-blue-600 font-semibold">
                      <Navigation className="w-4 h-4" />
                      {request.distance} km away
                    </div>
                    <span className="text-xs text-gray-500">{request.time}</span>
                  </div>
                </div>
              </div>

              {/* Actions */}
              <div className="border-t border-gray-100 p-3 flex gap-2">
                <button className="flex-1 bg-red-600 text-white py-3 px-4 rounded-xl font-bold hover:bg-red-700 transition-all active:scale-95 flex items-center justify-center gap-2">
                  <Navigation className="w-4 h-4" />
                  Accept
                </button>
                <button className="px-4 py-3 border-2 border-gray-300 rounded-xl font-semibold text-gray-700 hover:bg-gray-50 transition-colors">
                  Details
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Recent Activity */}
      <div className="px-4 pb-4">
        <h2 className="font-bold text-gray-900 text-lg mb-3">Recent Activity</h2>
        <div className="bg-white rounded-2xl shadow-sm border border-gray-200 divide-y divide-gray-100">
          {[
            { icon: Droplet, color: 'red', title: 'Blood Donation Completed', time: '2 days ago', location: 'Heliopolis Hospital' },
            { icon: Heart, color: 'green', title: 'Request Fulfilled', time: '5 days ago', location: 'Maadi Hospital' },
            { icon: Award, color: 'yellow', title: 'Achievement Unlocked', time: '1 week ago', location: '10 Lives Saved Badge' }
          ].map((activity, idx) => {
            const Icon = activity.icon;
            return (
              <div key={idx} className="p-4 flex items-center gap-3">
                <div className={`bg-${activity.color}-100 p-2 rounded-lg flex-shrink-0`}>
                  <Icon className={`w-5 h-5 text-${activity.color}-600`} style={{
                    color: activity.color === 'red' ? '#dc2626' : activity.color === 'green' ? '#16a34a' : '#ca8a04'
                  }} />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="font-semibold text-gray-900 text-sm">{activity.title}</p>
                  <p className="text-xs text-gray-500">{activity.location}</p>
                </div>
                <span className="text-xs text-gray-400 whitespace-nowrap">{activity.time}</span>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}
