import { useState } from 'react';
import { AlertCircle, MapPin, Camera, Upload, Phone, Clock, CheckCircle } from 'lucide-react';

export function EmergencyRequestForm() {
  const [step, setStep] = useState<'form' | 'submitted'>('form');
  const [formData, setFormData] = useState({
    type: 'blood',
    urgency: 'critical',
    bloodType: '',
    description: '',
    contactName: '',
    contactPhone: '',
    location: 'Current Location (Auto-detected)'
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setStep('submitted');
  };

  if (step === 'submitted') {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center p-4">
        <div className="bg-white rounded-lg shadow-lg p-8 max-w-md w-full text-center">
          <div className="bg-green-100 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4">
            <CheckCircle className="w-12 h-12 text-green-600" />
          </div>
          <h2 className="text-2xl font-bold text-gray-900 mb-2">Request Submitted!</h2>
          <p className="text-gray-600 mb-6">
            Your emergency request has been broadcast to nearby donors. You should receive responses shortly.
          </p>

          {/* Status tracking */}
          <div className="bg-gray-50 rounded-lg p-4 mb-6 text-left">
            <h3 className="font-semibold text-gray-900 mb-3">Status Updates</h3>
            <div className="space-y-3">
              <div className="flex items-start gap-3">
                <div className="bg-green-600 text-white p-1 rounded-full mt-0.5">
                  <CheckCircle className="w-4 h-4" />
                </div>
                <div className="flex-1">
                  <p className="font-medium text-gray-900">Request Created</p>
                  <p className="text-sm text-gray-500">Just now</p>
                </div>
              </div>
              <div className="flex items-start gap-3">
                <div className="bg-blue-600 text-white p-1 rounded-full mt-0.5 animate-pulse">
                  <Clock className="w-4 h-4" />
                </div>
                <div className="flex-1">
                  <p className="font-medium text-gray-900">Broadcasting to Donors</p>
                  <p className="text-sm text-gray-500">Finding matches within 5km...</p>
                </div>
              </div>
              <div className="flex items-start gap-3">
                <div className="bg-gray-300 text-white p-1 rounded-full mt-0.5">
                  <AlertCircle className="w-4 h-4" />
                </div>
                <div className="flex-1">
                  <p className="font-medium text-gray-400">Awaiting Response</p>
                  <p className="text-sm text-gray-400">Estimated wait: 2-5 min</p>
                </div>
              </div>
            </div>
          </div>

          {/* QR Code placeholder */}
          <div className="bg-gray-100 p-6 rounded-lg mb-6">
            <p className="text-sm text-gray-600 mb-3">Show this QR code to the donor when they arrive</p>
            <div className="bg-white p-4 rounded-lg inline-block">
              <div className="w-32 h-32 bg-gray-200 rounded flex items-center justify-center">
                <div className="text-xs text-gray-500 text-center">
                  QR CODE<br/>#{Math.random().toString(36).substring(7).toUpperCase()}
                </div>
              </div>
            </div>
          </div>

          <div className="flex gap-2">
            <button
              onClick={() => setStep('form')}
              className="flex-1 px-4 py-2 border border-gray-300 rounded-lg font-medium text-gray-700 hover:bg-gray-50 transition-colors"
            >
              New Request
            </button>
            <button className="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg font-medium hover:bg-red-700 transition-colors">
              Track Donors
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-red-600 text-white p-4">
        <div className="max-w-2xl mx-auto">
          <div className="flex items-center gap-3">
            <div className="bg-white/20 p-2 rounded-full">
              <AlertCircle className="w-6 h-6" />
            </div>
            <div>
              <h1 className="font-bold text-lg">Emergency Request</h1>
              <p className="text-sm text-red-100">Fill the form below to get immediate help</p>
            </div>
          </div>
        </div>
      </div>

      {/* Form */}
      <div className="max-w-2xl mx-auto p-4">
        <form onSubmit={handleSubmit} className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
          {/* Emergency Type */}
          <div className="mb-6">
            <label className="block font-semibold text-gray-900 mb-3">Emergency Type *</label>
            <div className="grid grid-cols-3 gap-3">
              {[
                { value: 'blood', label: 'Blood Donation', icon: '🩸' },
                { value: 'medical', label: 'Medical Supplies', icon: '💊' },
                { value: 'rescue', label: 'Emergency Rescue', icon: '🚑' }
              ].map((type) => (
                <button
                  key={type.value}
                  type="button"
                  onClick={() => setFormData({ ...formData, type: type.value })}
                  className={`p-4 rounded-lg border-2 transition-all ${
                    formData.type === type.value
                      ? 'border-red-600 bg-red-50'
                      : 'border-gray-200 hover:border-gray-300'
                  }`}
                >
                  <div className="text-3xl mb-2">{type.icon}</div>
                  <div className="text-sm font-medium text-gray-900">{type.label}</div>
                </button>
              ))}
            </div>
          </div>

          {/* Urgency Level */}
          <div className="mb-6">
            <label className="block font-semibold text-gray-900 mb-3">Urgency Level *</label>
            <div className="flex gap-3">
              {[
                { value: 'critical', label: 'Critical', color: 'red' },
                { value: 'high', label: 'High', color: 'orange' },
                { value: 'medium', label: 'Medium', color: 'amber' }
              ].map((urgency) => (
                <button
                  key={urgency.value}
                  type="button"
                  onClick={() => setFormData({ ...formData, urgency: urgency.value })}
                  className={`flex-1 py-3 px-4 rounded-lg font-medium transition-all ${
                    formData.urgency === urgency.value
                      ? `bg-${urgency.color}-600 text-white`
                      : `border-2 border-${urgency.color}-300 text-${urgency.color}-600 hover:bg-${urgency.color}-50`
                  }`}
                  style={{
                    backgroundColor: formData.urgency === urgency.value
                      ? urgency.color === 'red' ? '#dc2626'
                      : urgency.color === 'orange' ? '#ea580c'
                      : '#d97706'
                      : 'transparent',
                    borderColor: urgency.color === 'red' ? '#fca5a5'
                      : urgency.color === 'orange' ? '#fdba74'
                      : '#fcd34d',
                    color: formData.urgency === urgency.value ? 'white'
                      : urgency.color === 'red' ? '#dc2626'
                      : urgency.color === 'orange' ? '#ea580c'
                      : '#d97706'
                  }}
                >
                  {urgency.label}
                </button>
              ))}
            </div>
          </div>

          {/* Blood Type (conditional) */}
          {formData.type === 'blood' && (
            <div className="mb-6">
              <label className="block font-semibold text-gray-900 mb-3">Blood Type Needed *</label>
              <div className="grid grid-cols-4 gap-2">
                {['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((type) => (
                  <button
                    key={type}
                    type="button"
                    onClick={() => setFormData({ ...formData, bloodType: type })}
                    className={`py-2 px-4 rounded-lg font-medium transition-all ${
                      formData.bloodType === type
                        ? 'bg-red-600 text-white'
                        : 'border-2 border-gray-200 text-gray-700 hover:border-red-300'
                    }`}
                  >
                    {type}
                  </button>
                ))}
              </div>
            </div>
          )}

          {/* Description */}
          <div className="mb-6">
            <label className="block font-semibold text-gray-900 mb-2">Description *</label>
            <textarea
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              placeholder="Describe the emergency situation in detail..."
              className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-600 focus:border-transparent resize-none"
              rows={4}
              required
            />
            <p className="text-sm text-gray-500 mt-1">AI will analyze this to determine priority</p>
          </div>

          {/* Contact Information */}
          <div className="grid grid-cols-2 gap-4 mb-6">
            <div>
              <label className="block font-semibold text-gray-900 mb-2">Contact Name *</label>
              <input
                type="text"
                value={formData.contactName}
                onChange={(e) => setFormData({ ...formData, contactName: e.target.value })}
                placeholder="Your name"
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-600 focus:border-transparent"
                required
              />
            </div>
            <div>
              <label className="block font-semibold text-gray-900 mb-2">Phone Number *</label>
              <div className="relative">
                <Phone className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="tel"
                  value={formData.contactPhone}
                  onChange={(e) => setFormData({ ...formData, contactPhone: e.target.value })}
                  placeholder="+20 123 456 7890"
                  className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-600 focus:border-transparent"
                  required
                />
              </div>
            </div>
          </div>

          {/* Location */}
          <div className="mb-6">
            <label className="block font-semibold text-gray-900 mb-2">Location</label>
            <div className="flex gap-2">
              <div className="flex-1 relative">
                <MapPin className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="text"
                  value={formData.location}
                  readOnly
                  className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg bg-gray-50"
                />
              </div>
              <button
                type="button"
                className="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition-colors whitespace-nowrap"
              >
                Use GPS
              </button>
            </div>
          </div>

          {/* Photo Upload */}
          <div className="mb-6">
            <label className="block font-semibold text-gray-900 mb-2">Attach Photo (Optional)</label>
            <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center hover:border-red-400 transition-colors cursor-pointer">
              <Upload className="w-8 h-8 text-gray-400 mx-auto mb-2" />
              <p className="text-sm text-gray-600">Click to upload or drag and drop</p>
              <p className="text-xs text-gray-500 mt-1">Medical reports, prescription, or proof of emergency</p>
            </div>
          </div>

          {/* Warning */}
          <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6 flex gap-3">
            <AlertCircle className="w-5 h-5 text-yellow-600 flex-shrink-0 mt-0.5" />
            <div className="text-sm text-yellow-800">
              <p className="font-medium mb-1">Important Notice</p>
              <p>False emergency requests may result in account suspension. Only submit genuine emergencies.</p>
            </div>
          </div>

          {/* Submit Button */}
          <button
            type="submit"
            className="w-full bg-red-600 text-white py-3 px-6 rounded-lg font-bold text-lg hover:bg-red-700 transition-colors shadow-lg"
          >
            🚨 Submit Emergency Request
          </button>
        </form>
      </div>
    </div>
  );
}
