/**
 * Calculates interest based on a utilization-based kinked interest rate model.
 */
function calculateInterest(principal, utilizationRate, baseRate = 0.02) {
    const kink = 0.8; // 80% utilization
    const multiplier = 0.1; // 10% rate at kink
    const jumpMultiplier = 1.0; // 100% rate after kink
    
    let rate;
    if (utilizationRate <= kink) {
        rate = baseRate + (utilizationRate * multiplier);
    } else {
        rate = baseRate + (kink * multiplier) + ((utilizationRate - kink) * jumpMultiplier);
    }
    
    return principal * rate;
}

module.exports = { calculateInterest };
