#!/bin/bash

# Phase 0 Validation Helper Script
# Run this to start validation

echo "🚀 Starting Phase 0: State Widget Validation"
echo ""
echo "Step 1: Running Flutter app..."
echo ""

cd /Users/btc001a/Downloads/Flutter/erp_app

# Run the app
flutter run

# After app closes, show next steps
echo ""
echo "✅ App closed. Next steps:"
echo ""
echo "1. Did you test CRM → Leads screen?"
echo "2. Did you test all three states (loading, error, empty)?"
echo "3. Fill out validation notes in .agent/PHASE_0_VALIDATION.md"
echo ""
echo "📝 Quick checklist:"
echo "   [ ] Loading state looks good"
echo "   [ ] Error state works (retry button)"
echo "   [ ] Empty state works (add button)"
echo "   [ ] Colors match app theme"
echo "   [ ] Messages are helpful"
echo ""
echo "🎯 Make your decision:"
echo "   ✅ If 7+ checks: Proceed to Phase 1"
echo "   🟡 If 4-6 checks: Make tweaks"
echo "   🔴 If <4 checks: Reconsider"
echo ""
echo "📚 Full guide: .agent/PHASE_0_VALIDATION.md"
echo ""
