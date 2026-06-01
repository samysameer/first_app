import { useState } from 'react';
import { Heart, AlertCircle, Shield, ArrowRight, Smartphone, Monitor } from 'lucide-react';
import { DonorDashboard } from './components/DonorDashboard';
import { EmergencyRequestForm } from './components/EmergencyRequestForm';
import { AdminDashboard } from './components/AdminDashboard';
import { MobileLayout } from './components/mobile/MobileLayout';
import { DonorHome } from './components/mobile/DonorHome';
import { DonorMap } from './components/mobile/DonorMap';
import { DonorNotifications } from './components/mobile/DonorNotifications';
import { DonorProfile } from './components/mobile/DonorProfile';
import { RequesterHome } from './components/mobile/RequesterHome';
import { EmergencyFormMobile } from './components/mobile/EmergencyFormMobile';

type UserRole = 'donor' | 'requester' | 'admin' | null;
type ViewMode = 'desktop' | 'mobile' | null;

export default function App() {
  const [userRole, setUserRole] = useState<UserRole>(null);
  const [viewMode, setViewMode] = useState<ViewMode>(null);
  const [mobileTab, setMobileTab] = useState('home');

  // View Mode Selection
  if (!viewMode) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-red-50 via-white to-blue-50 flex items-center justify-center p-4">
        <div className="max-w-4xl w-full text-center">
          <div className="flex items-center justify-center gap-3 mb-6">
            <div className="bg-red-600 p-3 rounded-full">
              <Heart className="w-8 h-8 text-white" />
            </div>
            <h1 className="text-4xl font-bold text-gray-900">Donation & Emergency Aid</h1>
          </div>
          <p className="text-lg text-gray-600 mb-12">Choose your platform</p>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <button
              onClick={() => setViewMode('mobile')}
              className="bg-white rounded-2xl shadow-xl border-2 border-gray-200 hover:border-red-600 hover:shadow-2xl transition-all p-12 text-center group"
            >
              <div className="bg-red-100 w-20 h-20 rounded-full flex items-center justify-center mb-6 mx-auto group-hover:bg-red-600 transition-colors">
                <Smartphone className="w-10 h-10 text-red-600 group-hover:text-white transition-colors" />
              </div>
              <h2 className="text-3xl font-bold text-gray-900 mb-3">Mobile App</h2>
              <p className="text-gray-600 mb-4">Full mobile experience for donors and requesters</p>
              <div className="flex items-center justify-center text-red-600 font-medium group-hover:gap-2 transition-all">
                <span>Launch Mobile App</span>
                <ArrowRight className="w-5 h-5 opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>
            </button>

            <button
              onClick={() => setViewMode('desktop')}
              className="bg-white rounded-2xl shadow-xl border-2 border-gray-200 hover:border-blue-600 hover:shadow-2xl transition-all p-12 text-center group"
            >
              <div className="bg-blue-100 w-20 h-20 rounded-full flex items-center justify-center mb-6 mx-auto group-hover:bg-blue-600 transition-colors">
                <Monitor className="w-10 h-10 text-blue-600 group-hover:text-white transition-colors" />
              </div>
              <h2 className="text-3xl font-bold text-gray-900 mb-3">Desktop View</h2>
              <p className="text-gray-600 mb-4">Admin dashboard and detailed analytics</p>
              <div className="flex items-center justify-center text-blue-600 font-medium group-hover:gap-2 transition-all">
                <span>Open Desktop View</span>
                <ArrowRight className="w-5 h-5 opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>
            </button>
          </div>

          <div className="mt-12 text-sm text-gray-500">
            <p>Future University in Egypt × Parsam Research Group</p>
            <p className="mt-1">Supervised by: Dr. Mohamed Saeed Elsabry</p>
          </div>
        </div>
      </div>
    );
  }

  // Mobile App
  if (viewMode === 'mobile') {
    // Role Selection for Mobile
    if (!userRole) {
      return (
        <div className="min-h-screen bg-gradient-to-br from-red-50 via-white to-blue-50 flex items-center justify-center p-4">
          <div className="max-w-md w-full">
            <button
              onClick={() => setViewMode(null)}
              className="mb-6 text-gray-600 flex items-center gap-2"
            >
              <ArrowRight className="w-4 h-4 rotate-180" />
              Back
            </button>

            <div className="text-center mb-8">
              <div className="flex items-center justify-center gap-3 mb-4">
                <div className="bg-red-600 p-3 rounded-full">
                  <Heart className="w-8 h-8 text-white" />
                </div>
                <h1 className="text-2xl font-bold text-gray-900">Mobile App</h1>
              </div>
              <p className="text-gray-600">Select your role to continue</p>
            </div>

            <div className="space-y-4">
              <button
                onClick={() => setUserRole('donor')}
                className="w-full bg-white rounded-2xl shadow-lg border-2 border-gray-200 hover:border-red-600 hover:shadow-xl transition-all p-6 text-left group"
              >
                <div className="flex items-center gap-4">
                  <div className="bg-red-100 p-4 rounded-xl group-hover:bg-red-600 transition-colors">
                    <Heart className="w-8 h-8 text-red-600 group-hover:text-white transition-colors" />
                  </div>
                  <div className="flex-1">
                    <h2 className="text-xl font-bold text-gray-900 mb-1">I'm a Donor</h2>
                    <p className="text-sm text-gray-600">Help people in emergencies</p>
                  </div>
                  <ArrowRight className="w-6 h-6 text-gray-400" />
                </div>
              </button>

              <button
                onClick={() => setUserRole('requester')}
                className="w-full bg-white rounded-2xl shadow-lg border-2 border-gray-200 hover:border-orange-600 hover:shadow-xl transition-all p-6 text-left group"
              >
                <div className="flex items-center gap-4">
                  <div className="bg-orange-100 p-4 rounded-xl group-hover:bg-orange-600 transition-colors">
                    <AlertCircle className="w-8 h-8 text-orange-600 group-hover:text-white transition-colors" />
                  </div>
                  <div className="flex-1">
                    <h2 className="text-xl font-bold text-gray-900 mb-1">I Need Help</h2>
                    <p className="text-sm text-gray-600">Request emergency assistance</p>
                  </div>
                  <ArrowRight className="w-6 h-6 text-gray-400" />
                </div>
              </button>
            </div>
          </div>
        </div>
      );
    }

    // Donor Mobile App
    if (userRole === 'donor') {
      return (
        <MobileLayout activeTab={mobileTab} onTabChange={setMobileTab} userType="donor">
          {mobileTab === 'home' && <DonorHome />}
          {mobileTab === 'map' && <DonorMap />}
          {mobileTab === 'notifications' && <DonorNotifications />}
          {mobileTab === 'profile' && <DonorProfile />}
        </MobileLayout>
      );
    }

    // Requester Mobile App
    if (userRole === 'requester') {
      return (
        <MobileLayout activeTab={mobileTab} onTabChange={setMobileTab} userType="requester">
          {mobileTab === 'home' && <RequesterHome />}
          {mobileTab === 'emergency' && <EmergencyFormMobile onBack={() => setMobileTab('home')} />}
          {mobileTab === 'history' && <RequesterHome />}
          {mobileTab === 'profile' && <DonorProfile />}
        </MobileLayout>
      );
    }
  }

  // Desktop View - Role Selection
  if (!userRole) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-red-50 via-white to-blue-50 flex items-center justify-center p-4">
        <div className="max-w-5xl w-full">
          <button
            onClick={() => setViewMode(null)}
            className="mb-6 text-gray-600 flex items-center gap-2"
          >
            <ArrowRight className="w-4 h-4 rotate-180" />
            Back
          </button>

          <div className="text-center mb-12">
            <div className="flex items-center justify-center gap-3 mb-4">
              <div className="bg-red-600 p-3 rounded-full">
                <Heart className="w-8 h-8 text-white" />
              </div>
              <h1 className="text-4xl font-bold text-gray-900">Donation & Emergency Aid</h1>
            </div>
            <p className="text-lg text-gray-600">Connecting donors with people in need through AI-powered real-time matching</p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <button
              onClick={() => setUserRole('donor')}
              className="bg-white rounded-xl shadow-lg border-2 border-gray-200 hover:border-red-600 hover:shadow-xl transition-all p-8 text-left group"
            >
              <div className="bg-red-100 w-16 h-16 rounded-full flex items-center justify-center mb-4 group-hover:bg-red-600 transition-colors">
                <Heart className="w-8 h-8 text-red-600 group-hover:text-white transition-colors" />
              </div>
              <h2 className="text-2xl font-bold text-gray-900 mb-2">I'm a Donor</h2>
              <p className="text-gray-600 mb-4">Help people in emergency situations</p>
              <div className="flex items-center text-red-600 font-medium group-hover:gap-2 transition-all">
                <span>Start Helping</span>
                <ArrowRight className="w-5 h-5 opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>
            </button>

            <button
              onClick={() => setUserRole('requester')}
              className="bg-white rounded-xl shadow-lg border-2 border-gray-200 hover:border-orange-600 hover:shadow-xl transition-all p-8 text-left group"
            >
              <div className="bg-orange-100 w-16 h-16 rounded-full flex items-center justify-center mb-4 group-hover:bg-orange-600 transition-colors">
                <AlertCircle className="w-8 h-8 text-orange-600 group-hover:text-white transition-colors" />
              </div>
              <h2 className="text-2xl font-bold text-gray-900 mb-2">I Need Help</h2>
              <p className="text-gray-600 mb-4">Submit an emergency request</p>
              <div className="flex items-center text-orange-600 font-medium group-hover:gap-2 transition-all">
                <span>Request Aid</span>
                <ArrowRight className="w-5 h-5 opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>
            </button>

            <button
              onClick={() => setUserRole('admin')}
              className="bg-white rounded-xl shadow-lg border-2 border-gray-200 hover:border-blue-600 hover:shadow-xl transition-all p-8 text-left group"
            >
              <div className="bg-blue-100 w-16 h-16 rounded-full flex items-center justify-center mb-4 group-hover:bg-blue-600 transition-colors">
                <Shield className="w-8 h-8 text-blue-600 group-hover:text-white transition-colors" />
              </div>
              <h2 className="text-2xl font-bold text-gray-900 mb-2">Admin Panel</h2>
              <p className="text-gray-600 mb-4">Monitor system activity</p>
              <div className="flex items-center text-blue-600 font-medium group-hover:gap-2 transition-all">
                <span>View Dashboard</span>
                <ArrowRight className="w-5 h-5 opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>
            </button>
          </div>

          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
            <h3 className="text-xl font-bold text-gray-900 mb-4 text-center">Key Features</h3>
            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
              <div className="text-center">
                <div className="text-3xl mb-2">📍</div>
                <p className="font-medium text-gray-900">Real-time Location Matching</p>
                <p className="text-sm text-gray-600 mt-1">Find donors within 2-10km radius</p>
              </div>
              <div className="text-center">
                <div className="text-3xl mb-2">🤖</div>
                <p className="font-medium text-gray-900">AI-Powered Prioritization</p>
                <p className="text-sm text-gray-600 mt-1">Smart urgency classification</p>
              </div>
              <div className="text-center">
                <div className="text-3xl mb-2">🔔</div>
                <p className="font-medium text-gray-900">Instant Notifications</p>
                <p className="text-sm text-gray-600 mt-1">Push alerts to matched donors</p>
              </div>
              <div className="text-center">
                <div className="text-3xl mb-2">✅</div>
                <p className="font-medium text-gray-900">QR Verification</p>
                <p className="text-sm text-gray-600 mt-1">Secure donor-requester matching</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Desktop View - Render Interface
  return (
    <div className="relative">
      <button
        onClick={() => setUserRole(null)}
        className="absolute top-4 left-4 z-50 bg-white px-4 py-2 rounded-lg shadow-md border border-gray-200 hover:bg-gray-50 transition-colors font-medium text-gray-700"
      >
        ← Back to Menu
      </button>

      {userRole === 'donor' && <DonorDashboard />}
      {userRole === 'requester' && <EmergencyRequestForm />}
      {userRole === 'admin' && <AdminDashboard />}
    </div>
  );
}