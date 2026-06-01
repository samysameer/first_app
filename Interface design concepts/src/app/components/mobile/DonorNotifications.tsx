import { Bell, Droplet, Heart, Award, CheckCircle, XCircle, Clock } from 'lucide-react';

export function DonorNotifications() {
  const notifications = [
    {
      id: 1,
      type: 'emergency',
      icon: Droplet,
      color: 'red',
      title: 'New Emergency Request',
      message: 'Critical blood donation needed 1.2 km away',
      time: '2 minutes ago',
      unread: true,
      action: true
    },
    {
      id: 2,
      type: 'emergency',
      icon: Heart,
      color: 'orange',
      title: 'High Priority Request',
      message: 'Medical supplies needed at Dar El Fouad Hospital',
      time: '15 minutes ago',
      unread: true,
      action: true
    },
    {
      id: 3,
      type: 'success',
      icon: CheckCircle,
      color: 'green',
      title: 'Request Completed',
      message: 'Thank you for helping Sarah Mohamed! +10 points',
      time: '2 hours ago',
      unread: false,
      action: false
    },
    {
      id: 4,
      type: 'achievement',
      icon: Award,
      color: 'yellow',
      title: 'New Badge Earned!',
      message: 'You\'ve unlocked "Life Saver" - 10 donations completed',
      time: '5 hours ago',
      unread: false,
      action: false
    },
    {
      id: 5,
      type: 'info',
      icon: Bell,
      color: 'blue',
      title: 'Reminder',
      message: 'You can donate blood again starting tomorrow',
      time: '1 day ago',
      unread: false,
      action: false
    },
    {
      id: 6,
      type: 'cancelled',
      icon: XCircle,
      color: 'gray',
      title: 'Request Cancelled',
      message: 'Emergency request #1234 was cancelled by requester',
      time: '2 days ago',
      unread: false,
      action: false
    }
  ];

  const getColorClasses = (color: string, unread: boolean) => {
    const colors = {
      red: unread ? 'bg-red-100 text-red-600' : 'bg-red-50 text-red-500',
      orange: unread ? 'bg-orange-100 text-orange-600' : 'bg-orange-50 text-orange-500',
      green: unread ? 'bg-green-100 text-green-600' : 'bg-green-50 text-green-500',
      yellow: unread ? 'bg-yellow-100 text-yellow-600' : 'bg-yellow-50 text-yellow-500',
      blue: unread ? 'bg-blue-100 text-blue-600' : 'bg-blue-50 text-blue-500',
      gray: 'bg-gray-100 text-gray-500'
    };
    return colors[color as keyof typeof colors] || colors.gray;
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-white px-4 pt-12 pb-4 border-b border-gray-200 sticky top-0 z-10">
        <div className="flex items-center justify-between mb-4">
          <h1 className="text-xl font-bold text-gray-900">Notifications</h1>
          <button className="text-sm font-semibold text-red-600">Mark all read</button>
        </div>

        {/* Tabs */}
        <div className="flex gap-2">
          {['All', 'Emergency', 'Updates'].map((tab, idx) => (
            <button
              key={idx}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                idx === 0
                  ? 'bg-red-600 text-white'
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              {tab}
              {idx === 0 && (
                <span className="ml-2 bg-white/30 px-1.5 py-0.5 rounded text-xs">
                  {notifications.filter(n => n.unread).length}
                </span>
              )}
            </button>
          ))}
        </div>
      </div>

      {/* Notifications List */}
      <div className="px-4 py-4 space-y-3">
        {notifications.map((notification) => {
          const Icon = notification.icon;
          return (
            <div
              key={notification.id}
              className={`bg-white rounded-2xl shadow-sm border-2 transition-all ${
                notification.unread
                  ? 'border-red-200 shadow-md'
                  : 'border-gray-200'
              }`}
            >
              <div className="p-4">
                <div className="flex gap-3">
                  <div className={`p-2.5 rounded-xl flex-shrink-0 ${getColorClasses(notification.color, notification.unread)}`}>
                    <Icon className="w-5 h-5" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start justify-between mb-1">
                      <h3 className="font-bold text-gray-900 text-sm">
                        {notification.title}
                      </h3>
                      {notification.unread && (
                        <div className="w-2 h-2 bg-red-600 rounded-full flex-shrink-0 ml-2 mt-1"></div>
                      )}
                    </div>
                    <p className="text-sm text-gray-600 mb-2 leading-tight">
                      {notification.message}
                    </p>
                    <div className="flex items-center gap-1 text-xs text-gray-500">
                      <Clock className="w-3 h-3" />
                      {notification.time}
                    </div>
                  </div>
                </div>

                {notification.action && (
                  <div className="flex gap-2 mt-3 pt-3 border-t border-gray-100">
                    <button className="flex-1 bg-red-600 text-white py-2.5 rounded-xl font-bold text-sm">
                      View Request
                    </button>
                    <button className="px-4 py-2.5 border-2 border-gray-300 rounded-xl font-semibold text-gray-700 text-sm">
                      Dismiss
                    </button>
                  </div>
                )}
              </div>
            </div>
          );
        })}
      </div>

      {/* Empty State (shown when no notifications) */}
      {notifications.length === 0 && (
        <div className="flex flex-col items-center justify-center h-96 text-center px-8">
          <div className="bg-gray-100 p-6 rounded-full mb-4">
            <Bell className="w-12 h-12 text-gray-400" />
          </div>
          <h3 className="font-bold text-gray-900 text-lg mb-2">No notifications yet</h3>
          <p className="text-gray-600 text-sm">
            You'll be notified when there are emergency requests nearby
          </p>
        </div>
      )}
    </div>
  );
}
