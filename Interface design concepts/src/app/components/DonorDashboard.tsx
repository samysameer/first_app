import { useState } from 'react';
import { MapPin, Navigation, Bell, Award, Heart, Droplet, Activity, Clock, Star } from 'lucide-react';

interface EmergencyRequest {
  id: string;
  type: 'blood' | 'medical' | 'rescue';
  urgency: 'critical' | 'high' | 'medium';
  distance: number;
  bloodType?: string;
  description: string;
  location: string;
  time: string;
  requester: string;
}

export function DonorDashboard() {
  const [activeTab, setActiveTab] = useState<'feed' | 'map'>('feed');
  const [isAvailable, setIsAvailable] = useState(true);

  const mockRequests: EmergencyRequest[] = [
    {
      id: '1',
      type: 'blood',
      urgency: 'critical',
      distance: 1.2,
      bloodType: 'O-',
      description: 'Urgent blood transfusion needed for road accident victim',
      location: 'Cairo University Hospital',
      time: '2 min ago',
      requester: 'Dr. Ahmed Hassan'
    },
    {
      id: '2',
      type: 'medical',
      urgency: 'high',
      distance: 3.5,
      description: 'Medical supplies needed for emergency surgery',
      location: 'Dar El Fouad Hospital',
      time: '8 min ago',
      requester: 'Fatma Ali'
    },
    {
      id: '3',
      type: 'rescue',
      urgency: 'medium',
      distance: 5.8,
      description: 'Elderly person needs help at home',
      location: 'Maadi, Street 9',
      time: '15 min ago',
      requester: 'Mohamed Samir'
    }
  ];

  const getUrgencyColor = (urgency: string) => {
    switch (urgency) {
      case 'critical': return 'bg-red-600';
      case 'high': return 'bg-orange-500';
      case 'medium': return 'bg-amber-500';
      default: return 'bg-gray-500';
    }
  };

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'blood': return <Droplet className="w-5 h-5" />;
      case 'medical': return <Heart className="w-5 h-5" />;
      case 'rescue': return <Activity className="w-5 h-5" />;
      default: return <MapPin className="w-5 h-5" />;
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-red-600 text-white p-4">
        <div className="max-w-6xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="bg-white/20 p-2 rounded-full">
              <Heart className="w-6 h-6" />
            </div>
            <div>
              <h1 className="font-bold text-lg">Donor Dashboard</h1>
              <p className="text-sm text-red-100">Blood Type: O+ | Active Donor</p>
            </div>
          </div>
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-2 bg-white/20 px-4 py-2 rounded-full">
              <Award className="w-5 h-5" />
              <span className="font-semibold">12 Lives Saved</span>
            </div>
            <button className="bg-white/20 p-2 rounded-full relative">
              <Bell className="w-6 h-6" />
              <span className="absolute -top-1 -right-1 bg-yellow-400 text-red-600 text-xs font-bold w-5 h-5 rounded-full flex items-center justify-center">3</span>
            </button>
          </div>
        </div>
      </div>

      {/* Status Toggle */}
      <div className="bg-white border-b shadow-sm">
        <div className="max-w-6xl mx-auto p-4 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className={`w-3 h-3 rounded-full ${isAvailable ? 'bg-green-500' : 'bg-gray-400'} animate-pulse`}></div>
            <span className="font-medium">{isAvailable ? 'Available for emergencies' : 'Not available'}</span>
          </div>
          <button
            onClick={() => setIsAvailable(!isAvailable)}
            className={`px-6 py-2 rounded-full font-medium transition-colors ${
              isAvailable
                ? 'bg-gray-200 text-gray-700 hover:bg-gray-300'
                : 'bg-green-600 text-white hover:bg-green-700'
            }`}
          >
            {isAvailable ? 'Go Offline' : 'Go Online'}
          </button>
        </div>
      </div>

      {/* Navigation Tabs */}
      <div className="bg-white border-b">
        <div className="max-w-6xl mx-auto flex">
          <button
            onClick={() => setActiveTab('feed')}
            className={`flex-1 py-3 font-medium transition-colors ${
              activeTab === 'feed'
                ? 'text-red-600 border-b-2 border-red-600'
                : 'text-gray-500 hover:text-gray-700'
            }`}
          >
            Emergency Feed
          </button>
          <button
            onClick={() => setActiveTab('map')}
            className={`flex-1 py-3 font-medium transition-colors ${
              activeTab === 'map'
                ? 'text-red-600 border-b-2 border-red-600'
                : 'text-gray-500 hover:text-gray-700'
            }`}
          >
            Map View
          </button>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-6xl mx-auto p-4">
        {activeTab === 'feed' && (
          <div className="space-y-4">
            {/* Stats Cards */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
              <div className="bg-white p-4 rounded-lg shadow-sm border border-gray-200">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-gray-500 text-sm">Active Requests</p>
                    <p className="text-2xl font-bold text-gray-900">24</p>
                  </div>
                  <div className="bg-red-100 p-3 rounded-full">
                    <Activity className="w-6 h-6 text-red-600" />
                  </div>
                </div>
              </div>
              <div className="bg-white p-4 rounded-lg shadow-sm border border-gray-200">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-gray-500 text-sm">Avg Response Time</p>
                    <p className="text-2xl font-bold text-gray-900">8 min</p>
                  </div>
                  <div className="bg-blue-100 p-3 rounded-full">
                    <Clock className="w-6 h-6 text-blue-600" />
                  </div>
                </div>
              </div>
              <div className="bg-white p-4 rounded-lg shadow-sm border border-gray-200">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-gray-500 text-sm">Donor Rating</p>
                    <p className="text-2xl font-bold text-gray-900">4.9</p>
                  </div>
                  <div className="bg-yellow-100 p-3 rounded-full">
                    <Star className="w-6 h-6 text-yellow-600" />
                  </div>
                </div>
              </div>
            </div>

            {/* Emergency Requests */}
            {mockRequests.map((request) => (
              <div key={request.id} className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden hover:shadow-md transition-shadow">
                <div className="p-4">
                  <div className="flex items-start justify-between mb-3">
                    <div className="flex items-start gap-3">
                      <div className={`${getUrgencyColor(request.urgency)} text-white p-2 rounded-lg`}>
                        {getTypeIcon(request.type)}
                      </div>
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-1">
                          <span className={`px-2 py-1 rounded-full text-xs font-bold text-white ${getUrgencyColor(request.urgency)}`}>
                            {request.urgency.toUpperCase()}
                          </span>
                          {request.bloodType && (
                            <span className="px-2 py-1 rounded-full text-xs font-bold bg-red-100 text-red-700">
                              {request.bloodType}
                            </span>
                          )}
                          <span className="text-xs text-gray-500">{request.time}</span>
                        </div>
                        <p className="font-medium text-gray-900 mb-1">{request.description}</p>
                        <div className="flex items-center gap-4 text-sm text-gray-600">
                          <span className="flex items-center gap-1">
                            <MapPin className="w-4 h-4" />
                            {request.location}
                          </span>
                          <span className="font-medium text-blue-600">{request.distance} km away</span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div className="flex gap-2 mt-3 pt-3 border-t">
                    <button className="flex-1 bg-red-600 text-white py-2 px-4 rounded-lg font-medium hover:bg-red-700 transition-colors flex items-center justify-center gap-2">
                      <Navigation className="w-4 h-4" />
                      Accept & Navigate
                    </button>
                    <button className="px-4 py-2 border border-gray-300 rounded-lg font-medium text-gray-700 hover:bg-gray-50 transition-colors">
                      Details
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}

        {activeTab === 'map' && (
          <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
            <div className="relative h-[600px] bg-gray-200">
              {/* Map placeholder with pins */}
              <div className="absolute inset-0 flex items-center justify-center">
                <div className="text-center">
                  <MapPin className="w-16 h-16 text-gray-400 mx-auto mb-2" />
                  <p className="text-gray-600 font-medium">Interactive Map View</p>
                  <p className="text-sm text-gray-500 mt-1">Emergency requests within 10km radius</p>
                </div>
              </div>

              {/* Mock pins */}
              <div className="absolute top-20 left-32 bg-red-600 text-white p-2 rounded-full shadow-lg animate-pulse">
                <Droplet className="w-6 h-6" />
              </div>
              <div className="absolute top-40 right-40 bg-orange-500 text-white p-2 rounded-full shadow-lg">
                <Heart className="w-6 h-6" />
              </div>
              <div className="absolute bottom-32 left-1/3 bg-amber-500 text-white p-2 rounded-full shadow-lg">
                <Activity className="w-6 h-6" />
              </div>

              {/* Distance radius circles */}
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-64 h-64 border-2 border-blue-400 border-dashed rounded-full opacity-30"></div>
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-96 h-96 border-2 border-blue-300 border-dashed rounded-full opacity-20"></div>

              {/* Center marker (donor location) */}
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-blue-600 text-white p-3 rounded-full shadow-xl border-4 border-white">
                <MapPin className="w-6 h-6" />
              </div>
            </div>

            {/* Map controls */}
            <div className="p-4 border-t bg-gray-50 flex items-center justify-between">
              <div className="flex gap-4 text-sm">
                <div className="flex items-center gap-2">
                  <div className="w-3 h-3 rounded-full bg-red-600"></div>
                  <span>Critical</span>
                </div>
                <div className="flex items-center gap-2">
                  <div className="w-3 h-3 rounded-full bg-orange-500"></div>
                  <span>High</span>
                </div>
                <div className="flex items-center gap-2">
                  <div className="w-3 h-3 rounded-full bg-amber-500"></div>
                  <span>Medium</span>
                </div>
              </div>
              <button className="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition-colors">
                Refresh Location
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
