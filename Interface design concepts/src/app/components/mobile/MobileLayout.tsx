import { ReactNode } from 'react';
import { Home, MapPin, Bell, User, AlertCircle } from 'lucide-react';

interface MobileLayoutProps {
  children: ReactNode;
  activeTab: string;
  onTabChange: (tab: string) => void;
  userType: 'donor' | 'requester';
}

export function MobileLayout({ children, activeTab, onTabChange, userType }: MobileLayoutProps) {
  const donorTabs = [
    { id: 'home', label: 'Home', icon: Home },
    { id: 'map', label: 'Map', icon: MapPin },
    { id: 'notifications', label: 'Alerts', icon: Bell },
    { id: 'profile', label: 'Profile', icon: User },
  ];

  const requesterTabs = [
    { id: 'home', label: 'Home', icon: Home },
    { id: 'emergency', label: 'SOS', icon: AlertCircle },
    { id: 'history', label: 'History', icon: Bell },
    { id: 'profile', label: 'Profile', icon: User },
  ];

  const tabs = userType === 'donor' ? donorTabs : requesterTabs;

  return (
    <div className="h-screen flex flex-col bg-gray-50 max-w-md mx-auto">
      {/* Content Area */}
      <div className="flex-1 overflow-y-auto pb-20">
        {children}
      </div>

      {/* Bottom Navigation */}
      <div className="fixed bottom-0 left-0 right-0 max-w-md mx-auto bg-white border-t border-gray-200 shadow-lg">
        <div className="grid grid-cols-4 h-16">
          {tabs.map((tab) => {
            const Icon = tab.icon;
            const isActive = activeTab === tab.id;
            const isEmergency = tab.id === 'emergency';

            if (isEmergency) {
              return (
                <button
                  key={tab.id}
                  onClick={() => onTabChange(tab.id)}
                  className="relative flex flex-col items-center justify-center"
                >
                  <div className="absolute -top-8 bg-red-600 text-white p-4 rounded-full shadow-2xl hover:bg-red-700 transition-all active:scale-95">
                    <Icon className="w-8 h-8" />
                  </div>
                  <span className="text-xs font-medium text-red-600 mt-8">{tab.label}</span>
                </button>
              );
            }

            return (
              <button
                key={tab.id}
                onClick={() => onTabChange(tab.id)}
                className={`flex flex-col items-center justify-center transition-colors ${
                  isActive ? 'text-red-600' : 'text-gray-400'
                }`}
              >
                <Icon className="w-6 h-6" />
                <span className="text-xs mt-1 font-medium">{tab.label}</span>
              </button>
            );
          })}
        </div>
      </div>
    </div>
  );
}
