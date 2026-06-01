import { User, Heart, Award, Settings, ChevronRight, MapPin, Phone, Mail, Calendar, Droplet, Star, LogOut, Shield } from 'lucide-react';

export function DonorProfile() {
  const stats = [
    { label: 'Lives Saved', value: '12', icon: Heart, color: 'red' },
    { label: 'Badges Earned', value: '8', icon: Award, color: 'yellow' },
    { label: 'Response Rate', value: '95%', icon: Star, color: 'blue' }
  ];

  const menuItems = [
    { icon: User, label: 'Edit Profile', action: 'edit', color: 'blue' },
    { icon: Droplet, label: 'Donation History', action: 'history', color: 'red' },
    { icon: Award, label: 'Badges & Achievements', action: 'badges', color: 'yellow' },
    { icon: MapPin, label: 'Location Settings', action: 'location', color: 'green' },
    { icon: Settings, label: 'App Settings', action: 'settings', color: 'gray' },
    { icon: Shield, label: 'Privacy & Security', action: 'privacy', color: 'purple' }
  ];

  return (
    <div className="min-h-screen bg-gray-50 pb-4">
      {/* Header */}
      <div className="bg-gradient-to-r from-red-600 to-red-700 text-white px-4 pt-12 pb-8">
        <div className="flex items-center justify-between mb-6">
          <h1 className="text-xl font-bold">Profile</h1>
          <button className="text-white/90">
            <Settings className="w-6 h-6" />
          </button>
        </div>

        {/* Profile Card */}
        <div className="bg-white/10 backdrop-blur-sm rounded-3xl p-6">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-20 h-20 bg-gradient-to-br from-white/30 to-white/10 rounded-full flex items-center justify-center border-4 border-white/20">
              <User className="w-10 h-10 text-white" />
            </div>
            <div className="flex-1">
              <h2 className="text-2xl font-bold mb-1">Ahmed Hassan</h2>
              <div className="flex items-center gap-2">
                <span className="bg-white/20 px-3 py-1 rounded-full text-sm font-semibold">Blood Type: O+</span>
                <div className="flex items-center gap-1 bg-green-500/30 px-2 py-1 rounded-full">
                  <div className="w-2 h-2 bg-green-300 rounded-full animate-pulse"></div>
                  <span className="text-xs font-semibold">Active</span>
                </div>
              </div>
            </div>
          </div>

          {/* Contact Info */}
          <div className="space-y-2 text-sm text-white/90">
            <div className="flex items-center gap-2">
              <Phone className="w-4 h-4" />
              <span>+20 123 456 7890</span>
            </div>
            <div className="flex items-center gap-2">
              <Mail className="w-4 h-4" />
              <span>ahmed.hassan@email.com</span>
            </div>
            <div className="flex items-center gap-2">
              <MapPin className="w-4 h-4" />
              <span>Cairo, Egypt</span>
            </div>
            <div className="flex items-center gap-2">
              <Calendar className="w-4 h-4" />
              <span>Member since Jan 2025</span>
            </div>
          </div>
        </div>
      </div>

      {/* Stats Grid */}
      <div className="px-4 -mt-6 mb-6">
        <div className="bg-white rounded-2xl shadow-lg border border-gray-200 p-4">
          <div className="grid grid-cols-3 divide-x divide-gray-200">
            {stats.map((stat, idx) => {
              const Icon = stat.icon;
              const colorClasses = {
                red: 'bg-red-100 text-red-600',
                yellow: 'bg-yellow-100 text-yellow-600',
                blue: 'bg-blue-100 text-blue-600'
              };
              return (
                <div key={idx} className="px-3 text-center">
                  <div className={`w-10 h-10 ${colorClasses[stat.color as keyof typeof colorClasses]} rounded-lg flex items-center justify-center mx-auto mb-2`}>
                    <Icon className="w-5 h-5" />
                  </div>
                  <p className="text-xl font-bold text-gray-900">{stat.value}</p>
                  <p className="text-xs text-gray-600 mt-1">{stat.label}</p>
                </div>
              );
            })}
          </div>
        </div>
      </div>

      {/* Impact Summary */}
      <div className="px-4 mb-6">
        <div className="bg-gradient-to-r from-green-50 to-emerald-50 rounded-2xl p-4 border border-green-200">
          <div className="flex items-center justify-between mb-2">
            <h3 className="font-bold text-gray-900">Your Impact</h3>
            <Award className="w-5 h-5 text-green-600" />
          </div>
          <p className="text-2xl font-bold text-green-700 mb-1">12 Lives Saved</p>
          <p className="text-sm text-gray-600">You're in the top 5% of donors in Cairo!</p>
          <div className="mt-3 bg-white/50 rounded-full h-2 overflow-hidden">
            <div className="bg-green-600 h-full w-3/4"></div>
          </div>
          <p className="text-xs text-gray-600 mt-1">3 more donations to unlock Gold Donor badge</p>
        </div>
      </div>

      {/* Menu Items */}
      <div className="px-4 mb-6">
        <div className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
          {menuItems.map((item, idx) => {
            const Icon = item.icon;
            const colorClasses = {
              blue: 'bg-blue-100 text-blue-600',
              red: 'bg-red-100 text-red-600',
              yellow: 'bg-yellow-100 text-yellow-600',
              green: 'bg-green-100 text-green-600',
              gray: 'bg-gray-100 text-gray-600',
              purple: 'bg-purple-100 text-purple-600'
            };
            return (
              <button
                key={idx}
                className="w-full p-4 flex items-center gap-3 hover:bg-gray-50 transition-colors border-b last:border-b-0 border-gray-100"
              >
                <div className={`p-2 rounded-lg ${colorClasses[item.color as keyof typeof colorClasses]}`}>
                  <Icon className="w-5 h-5" />
                </div>
                <span className="flex-1 text-left font-medium text-gray-900">{item.label}</span>
                <ChevronRight className="w-5 h-5 text-gray-400" />
              </button>
            );
          })}
        </div>
      </div>

      {/* Logout Button */}
      <div className="px-4">
        <button className="w-full bg-white border-2 border-red-600 text-red-600 py-3 px-4 rounded-xl font-bold flex items-center justify-center gap-2 hover:bg-red-50 transition-colors">
          <LogOut className="w-5 h-5" />
          Logout
        </button>
      </div>
    </div>
  );
}
