import { MapPin, Navigation, Filter, Droplet, Heart, Activity } from 'lucide-react';

export function DonorMap() {
  const emergencies = [
    { id: 1, type: 'blood', urgency: 'critical', lat: 30, lng: 31, count: 2 },
    { id: 2, type: 'medical', urgency: 'high', lat: 32, lng: 30, count: 1 },
    { id: 3, type: 'rescue', urgency: 'medium', lat: 28, lng: 32, count: 3 }
  ];

  return (
    <div className="h-screen flex flex-col bg-gray-50">
      {/* Header */}
      <div className="bg-white px-4 pt-12 pb-4 border-b border-gray-200 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h1 className="text-xl font-bold text-gray-900">Emergency Map</h1>
          <button className="bg-blue-600 text-white p-2 rounded-lg">
            <Filter className="w-5 h-5" />
          </button>
        </div>

        {/* Filter Pills */}
        <div className="flex gap-2 overflow-x-auto pb-2">
          {[
            { label: 'All', active: true },
            { label: 'Blood', active: false },
            { label: 'Medical', active: false },
            { label: 'Rescue', active: false }
          ].map((filter, idx) => (
            <button
              key={idx}
              className={`px-4 py-2 rounded-full text-sm font-medium whitespace-nowrap transition-colors ${
                filter.active
                  ? 'bg-red-600 text-white'
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              {filter.label}
            </button>
          ))}
        </div>
      </div>

      {/* Map */}
      <div className="flex-1 relative bg-gray-200">
        {/* Map Background */}
        <div className="absolute inset-0">
          <div className="w-full h-full flex items-center justify-center text-gray-400">
            <MapPin className="w-16 h-16" />
          </div>
        </div>

        {/* Distance Circles */}
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-48 h-48 border-2 border-blue-400 border-dashed rounded-full opacity-30"></div>
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-72 h-72 border-2 border-blue-300 border-dashed rounded-full opacity-20"></div>

        {/* Emergency Pins */}
        <div className="absolute top-20 left-16">
          <div className="relative">
            <div className="bg-red-600 text-white p-3 rounded-full shadow-2xl animate-pulse">
              <Droplet className="w-6 h-6" />
            </div>
            <div className="absolute -top-1 -right-1 bg-white text-red-600 text-xs font-bold w-5 h-5 rounded-full flex items-center justify-center border-2 border-red-600">
              2
            </div>
          </div>
        </div>

        <div className="absolute top-40 right-12">
          <div className="bg-orange-500 text-white p-3 rounded-full shadow-2xl">
            <Heart className="w-6 h-6" />
          </div>
        </div>

        <div className="absolute bottom-32 left-1/3">
          <div className="relative">
            <div className="bg-amber-500 text-white p-3 rounded-full shadow-2xl">
              <Activity className="w-6 h-6" />
            </div>
            <div className="absolute -top-1 -right-1 bg-white text-amber-600 text-xs font-bold w-5 h-5 rounded-full flex items-center justify-center border-2 border-amber-600">
              3
            </div>
          </div>
        </div>

        {/* User Location Pin */}
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
          <div className="bg-blue-600 text-white p-4 rounded-full shadow-2xl border-4 border-white">
            <Navigation className="w-6 h-6" />
          </div>
        </div>

        {/* Bottom Sheet Preview */}
        <div className="absolute bottom-0 left-0 right-0 bg-white rounded-t-3xl shadow-2xl p-4">
          <div className="w-12 h-1.5 bg-gray-300 rounded-full mx-auto mb-4"></div>

          <div className="flex items-start gap-3 mb-3">
            <div className="bg-red-600 text-white p-2 rounded-lg flex-shrink-0">
              <Droplet className="w-5 h-5" />
            </div>
            <div className="flex-1">
              <div className="flex items-center gap-2 mb-1">
                <span className="px-2 py-0.5 rounded text-xs font-bold bg-red-600 text-white">CRITICAL</span>
                <span className="px-2 py-0.5 rounded text-xs font-bold bg-red-100 text-red-700">O-</span>
              </div>
              <p className="font-semibold text-gray-900 text-sm mb-1">Urgent blood transfusion needed</p>
              <div className="flex items-center gap-4 text-xs text-gray-600">
                <span className="flex items-center gap-1">
                  <MapPin className="w-3 h-3" />
                  Cairo Hospital
                </span>
                <span className="font-semibold text-blue-600">1.2 km away</span>
              </div>
            </div>
          </div>

          <div className="flex gap-2">
            <button className="flex-1 bg-red-600 text-white py-3 rounded-xl font-bold flex items-center justify-center gap-2">
              <Navigation className="w-4 h-4" />
              Navigate
            </button>
            <button className="px-4 py-3 border-2 border-gray-300 rounded-xl font-semibold text-gray-700">
              View All
            </button>
          </div>
        </div>
      </div>

      {/* Legend */}
      <div className="absolute top-28 right-4 bg-white rounded-2xl shadow-lg p-3 text-xs">
        <div className="space-y-2">
          <div className="flex items-center gap-2">
            <div className="w-3 h-3 rounded-full bg-red-600"></div>
            <span className="text-gray-700">Critical</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-3 h-3 rounded-full bg-orange-500"></div>
            <span className="text-gray-700">High</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-3 h-3 rounded-full bg-amber-500"></div>
            <span className="text-gray-700">Medium</span>
          </div>
        </div>
      </div>

      {/* Recenter Button */}
      <button className="absolute bottom-56 right-4 bg-white text-blue-600 p-3 rounded-full shadow-lg border border-gray-200">
        <Navigation className="w-6 h-6" />
      </button>
    </div>
  );
}
