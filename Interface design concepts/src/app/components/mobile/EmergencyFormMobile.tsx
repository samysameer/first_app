import { useState } from 'react';
import { AlertCircle, MapPin, Camera, Phone, ArrowLeft, CheckCircle } from 'lucide-react';

export function EmergencyFormMobile({ onBack }: { onBack: () => void }) {
  const [step, setStep] = useState<'type' | 'details' | 'confirm' | 'submitted'>('type');
  const [formData, setFormData] = useState({
    type: '',
    urgency: 'critical',
    bloodType: '',
    description: '',
    contactName: '',
    contactPhone: ''
  });

  const handleSubmit = () => {
    setStep('submitted');
  };

  if (step === 'submitted') {
    return (
      <div className="min-h-screen bg-gray-50 flex flex-col">
        <div className="flex-1 flex items-center justify-center p-6">
          <div className="text-center max-w-sm">
            <div className="bg-green-100 w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-6 animate-pulse">
              <CheckCircle className="w-14 h-14 text-green-600" />
            </div>
            <h2 className="text-2xl font-bold text-gray-900 mb-3">Request Sent!</h2>
            <p className="text-gray-600 mb-6">
              Broadcasting to nearby donors. You should receive a match within 2-5 minutes.
            </p>

            {/* Progress */}
            <div className="bg-white rounded-2xl p-4 mb-6 text-left shadow-sm border border-gray-200">
              <div className="space-y-3">
                <div className="flex items-center gap-3">
                  <div className="bg-green-600 text-white p-1 rounded-full">
                    <CheckCircle className="w-4 h-4" />
                  </div>
                  <div className="flex-1">
                    <p className="font-medium text-sm text-gray-900">Request Created</p>
                    <p className="text-xs text-gray-500">Just now</p>
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <div className="bg-blue-600 text-white p-1 rounded-full animate-spin">
                    <div className="w-4 h-4"></div>
                  </div>
                  <div className="flex-1">
                    <p className="font-medium text-sm text-gray-900">Finding Donors...</p>
                    <p className="text-xs text-gray-500">Searching within 5km</p>
                  </div>
                </div>
              </div>
            </div>

            <button
              onClick={onBack}
              className="w-full bg-red-600 text-white py-3 px-6 rounded-xl font-bold"
            >
              Back to Home
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      {/* Header */}
      <div className="bg-red-600 text-white px-4 pt-12 pb-4 sticky top-0 z-10">
        <div className="flex items-center gap-3 mb-4">
          <button onClick={onBack} className="text-white">
            <ArrowLeft className="w-6 h-6" />
          </button>
          <div>
            <h1 className="text-xl font-bold">Emergency Request</h1>
            <p className="text-sm text-red-100">
              {step === 'type' && 'Select emergency type'}
              {step === 'details' && 'Provide details'}
              {step === 'confirm' && 'Confirm request'}
            </p>
          </div>
        </div>

        {/* Progress bar */}
        <div className="flex gap-2">
          <div className={`flex-1 h-1 rounded-full ${step !== 'type' ? 'bg-white' : 'bg-white/30'}`}></div>
          <div className={`flex-1 h-1 rounded-full ${step === 'confirm' ? 'bg-white' : 'bg-white/30'}`}></div>
          <div className={`flex-1 h-1 rounded-full bg-white/30`}></div>
        </div>
      </div>

      {/* Content */}
      <div className="flex-1 overflow-y-auto p-4">
        {/* Step 1: Type Selection */}
        {step === 'type' && (
          <div className="space-y-4">
            <h2 className="font-bold text-gray-900 text-lg mb-4">What type of help do you need?</h2>
            {[
              { value: 'blood', emoji: '🩸', title: 'Blood Donation', desc: 'Urgent blood transfusion needed' },
              { value: 'medical', emoji: '💊', title: 'Medical Supplies', desc: 'Medicine or medical equipment' },
              { value: 'rescue', emoji: '🚑', title: 'Emergency Rescue', desc: 'Immediate physical assistance' }
            ].map((type) => (
              <button
                key={type.value}
                onClick={() => {
                  setFormData({ ...formData, type: type.value });
                  setStep('details');
                }}
                className="w-full bg-white rounded-2xl p-5 border-2 border-gray-200 hover:border-red-600 transition-all text-left shadow-sm active:scale-98"
              >
                <div className="flex items-center gap-4">
                  <div className="text-4xl">{type.emoji}</div>
                  <div className="flex-1">
                    <p className="font-bold text-gray-900">{type.title}</p>
                    <p className="text-sm text-gray-600">{type.desc}</p>
                  </div>
                </div>
              </button>
            ))}
          </div>
        )}

        {/* Step 2: Details */}
        {step === 'details' && (
          <div className="space-y-4">
            {/* Urgency */}
            <div>
              <label className="block font-bold text-gray-900 mb-3">Urgency Level</label>
              <div className="grid grid-cols-3 gap-2">
                {[
                  { value: 'critical', label: 'Critical', color: '#dc2626' },
                  { value: 'high', label: 'High', color: '#ea580c' },
                  { value: 'medium', label: 'Medium', color: '#d97706' }
                ].map((urgency) => (
                  <button
                    key={urgency.value}
                    onClick={() => setFormData({ ...formData, urgency: urgency.value })}
                    className={`py-3 rounded-xl font-bold transition-all ${
                      formData.urgency === urgency.value
                        ? 'text-white scale-105'
                        : 'bg-white border-2 border-gray-200'
                    }`}
                    style={{
                      backgroundColor: formData.urgency === urgency.value ? urgency.color : 'white',
                      color: formData.urgency === urgency.value ? 'white' : urgency.color
                    }}
                  >
                    {urgency.label}
                  </button>
                ))}
              </div>
            </div>

            {/* Blood Type (if blood donation) */}
            {formData.type === 'blood' && (
              <div>
                <label className="block font-bold text-gray-900 mb-3">Blood Type Needed</label>
                <div className="grid grid-cols-4 gap-2">
                  {['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((type) => (
                    <button
                      key={type}
                      onClick={() => setFormData({ ...formData, bloodType: type })}
                      className={`py-3 rounded-xl font-bold transition-all ${
                        formData.bloodType === type
                          ? 'bg-red-600 text-white scale-105'
                          : 'bg-white border-2 border-gray-200 text-gray-700'
                      }`}
                    >
                      {type}
                    </button>
                  ))}
                </div>
              </div>
            )}

            {/* Description */}
            <div>
              <label className="block font-bold text-gray-900 mb-2">Description</label>
              <textarea
                value={formData.description}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                placeholder="Describe your emergency situation..."
                className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-red-600 focus:border-transparent resize-none"
                rows={4}
              />
              <p className="text-xs text-gray-500 mt-1">AI will analyze urgency from description</p>
            </div>

            {/* Contact Info */}
            <div>
              <label className="block font-bold text-gray-900 mb-2">Your Name</label>
              <input
                type="text"
                value={formData.contactName}
                onChange={(e) => setFormData({ ...formData, contactName: e.target.value })}
                placeholder="Full name"
                className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-red-600 focus:border-transparent"
              />
            </div>

            <div>
              <label className="block font-bold text-gray-900 mb-2">Phone Number</label>
              <div className="relative">
                <Phone className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                <input
                  type="tel"
                  value={formData.contactPhone}
                  onChange={(e) => setFormData({ ...formData, contactPhone: e.target.value })}
                  placeholder="+20 123 456 7890"
                  className="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-2 focus:ring-red-600 focus:border-transparent"
                />
              </div>
            </div>

            {/* Location */}
            <div>
              <label className="block font-bold text-gray-900 mb-2">Location</label>
              <div className="bg-gray-50 border-2 border-gray-200 rounded-xl p-4 flex items-center gap-3">
                <MapPin className="w-5 h-5 text-blue-600" />
                <div className="flex-1">
                  <p className="font-medium text-gray-900 text-sm">Current Location</p>
                  <p className="text-xs text-gray-500">GPS Auto-detected</p>
                </div>
                <button className="text-blue-600 font-semibold text-sm">Change</button>
              </div>
            </div>

            {/* Photo Upload */}
            <div>
              <label className="block font-bold text-gray-900 mb-2">Photo (Optional)</label>
              <button className="w-full border-2 border-dashed border-gray-300 rounded-xl p-6 flex flex-col items-center gap-2 hover:border-red-400 transition-colors">
                <Camera className="w-8 h-8 text-gray-400" />
                <p className="text-sm font-medium text-gray-600">Add Photo</p>
                <p className="text-xs text-gray-500">Medical report or proof</p>
              </button>
            </div>

            <button
              onClick={handleSubmit}
              className="w-full bg-red-600 text-white py-4 px-6 rounded-xl font-bold text-lg shadow-lg active:scale-95 transition-transform"
            >
              🚨 Submit Emergency Request
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
