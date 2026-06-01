import { AlertCircle, Clock, CheckCircle, MapPin, Phone, Users, TrendingUp } from 'lucide-react';

export function RequesterHome() {
  const activeRequests = [
    {
      id: '1',
      type: 'blood',
      urgency: 'critical',
      bloodType: 'O-',
      status: 'matched',
      donorName: 'Ahmed Hassan',
      donorETA: '5 min',
      requestedAt: '10 min ago',
      location: 'Cairo University Hospital'
    }
  ];

  const pastRequests = [
    {
      id: '2',
      type: 'medical',
      date: '2 days ago',
      status: 'completed',
      donorName: 'Sara Mohamed'
    },
    {
      id: '3',
      type: 'blood',
      date: '1 week ago',
      status: 'completed',
      donorName: 'Omar Ali'
    }
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-orange-600 to-red-600 text-white px-4 pt-12 pb-6">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h1 className="text-2xl font-bold mb-1">Emergency Aid</h1>
            <p className="text-orange-100 text-sm">Get help when you need it most</p>
          </div>
          <div className="bg-white/20 backdrop-blur-sm p-3 rounded-full">
            <AlertCircle className="w-7 h-7" />
          </div>
        </div>
      </div>

      {/* Quick Stats */}
      <div className="px-4 -mt-4 mb-6">
        <div className="bg-white rounded-2xl shadow-lg border border-gray-200 p-4">
          <div className="grid grid-cols-3 divide-x divide-gray-200">
            <div className="text-center px-2">
              <p className="text-2xl font-bold text-orange-600">24/7</p>
              <p className="text-xs text-gray-600 mt-1">Available</p>
            </div>
            <div className="text-center px-2">
              <p className="text-2xl font-bold text-green-600">1,247</p>
              <p className="text-xs text-gray-600 mt-1">Active Donors</p>
            </div>
            <div className="text-center px-2">
              <p className="text-2xl font-bold text-blue-600">8 min</p>
              <p className="text-xs text-gray-600 mt-1">Avg Response</p>
            </div>
          </div>
        </div>
      </div>

      {/* Emergency SOS Button */}
      <div className="px-4 mb-6">
        <div className="bg-gradient-to-r from-red-500 to-red-600 rounded-3xl p-6 shadow-2xl border-4 border-red-200">
          <div className="text-center text-white mb-4">
            <h2 className="text-xl font-bold mb-1">Need Immediate Help?</h2>
            <p className="text-red-100 text-sm">Tap below to send emergency request</p>
          </div>
          <button className="w-full bg-white text-red-600 py-4 px-6 rounded-2xl font-bold text-lg flex items-center justify-center gap-3 shadow-lg active:scale-95 transition-transform">
            <AlertCircle className="w-7 h-7" />
            Request Emergency Aid
          </button>
        </div>
      </div>

      {/* Active Requests */}
      {activeRequests.length > 0 && (
        <div className="px-4 mb-6">
          <h2 className="font-bold text-gray-900 text-lg mb-3">Active Request</h2>
          {activeRequests.map((request) => (
            <div key={request.id} className="bg-white rounded-2xl shadow-md border-2 border-green-200 overflow-hidden">
              <div className="bg-green-50 px-4 py-2 border-b border-green-200">
                <div className="flex items-center justify-between">
                  <span className="text-xs font-bold text-green-700">DONOR MATCHED</span>
                  <span className="text-xs text-gray-600">{request.requestedAt}</span>
                </div>
              </div>

              <div className="p-4">
                <div className="flex items-center justify-between mb-4">
                  <div>
                    <span className="px-2 py-1 rounded-lg text-xs font-bold bg-red-600 text-white">
                      {request.urgency.toUpperCase()}
                    </span>
                    {request.bloodType && (
                      <span className="ml-2 px-2 py-1 rounded-lg text-xs font-bold bg-red-100 text-red-700">
                        {request.bloodType}
                      </span>
                    )}
                  </div>
                </div>

                <div className="bg-blue-50 rounded-xl p-4 mb-4">
                  <div className="flex items-center justify-between mb-3">
                    <div className="flex items-center gap-2">
                      <div className="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center text-white font-bold">
                        AH
                      </div>
                      <div>
                        <p className="font-semibold text-gray-900">{request.donorName}</p>
                        <p className="text-xs text-gray-600">Verified Donor</p>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="text-lg font-bold text-blue-600">{request.donorETA}</p>
                      <p className="text-xs text-gray-600">ETA</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 text-sm text-gray-700">
                    <MapPin className="w-4 h-4" />
                    <span>{request.location}</span>
                  </div>
                </div>

                {/* QR Code */}
                <div className="bg-gray-50 rounded-xl p-4 text-center mb-4">
                  <p className="text-xs text-gray-600 mb-2">Show this code to donor</p>
                  <div className="bg-white p-3 rounded-lg inline-block border-2 border-gray-200">
                    <div className="w-24 h-24 bg-gray-200 rounded flex items-center justify-center">
                      <span className="text-xs font-mono text-gray-600">QR-{request.id}</span>
                    </div>
                  </div>
                </div>

                <div className="flex gap-2">
                  <button className="flex-1 bg-green-600 text-white py-3 rounded-xl font-bold flex items-center justify-center gap-2">
                    <Phone className="w-4 h-4" />
                    Call Donor
                  </button>
                  <button className="px-4 py-3 border-2 border-gray-300 rounded-xl font-semibold text-gray-700">
                    Track
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* How It Works */}
      <div className="px-4 mb-6">
        <h2 className="font-bold text-gray-900 text-lg mb-3">How It Works</h2>
        <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-5">
          <div className="space-y-4">
            {[
              { step: '1', title: 'Submit Request', desc: 'Tap SOS and fill emergency details' },
              { step: '2', title: 'AI Matching', desc: 'System finds nearby verified donors' },
              { step: '3', title: 'Get Help', desc: 'Donor arrives with needed assistance' },
              { step: '4', title: 'Confirm', desc: 'Verify with QR code and rate donor' }
            ].map((item) => (
              <div key={item.step} className="flex gap-3">
                <div className="w-8 h-8 bg-red-600 text-white rounded-full flex items-center justify-center font-bold text-sm flex-shrink-0">
                  {item.step}
                </div>
                <div className="flex-1">
                  <p className="font-semibold text-gray-900 text-sm">{item.title}</p>
                  <p className="text-xs text-gray-600">{item.desc}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Past Requests */}
      <div className="px-4 pb-4">
        <h2 className="font-bold text-gray-900 text-lg mb-3">Recent History</h2>
        <div className="bg-white rounded-2xl shadow-sm border border-gray-200 divide-y divide-gray-100">
          {pastRequests.map((request) => (
            <div key={request.id} className="p-4 flex items-center gap-3">
              <div className="bg-green-100 p-2 rounded-lg flex-shrink-0">
                <CheckCircle className="w-5 h-5 text-green-600" />
              </div>
              <div className="flex-1">
                <p className="font-semibold text-gray-900 text-sm">
                  {request.type === 'blood' ? 'Blood Donation' : 'Medical Supplies'}
                </p>
                <p className="text-xs text-gray-600">Helped by {request.donorName}</p>
              </div>
              <span className="text-xs text-gray-500 whitespace-nowrap">{request.date}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
