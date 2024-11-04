module.exports = {
  // ... existing config ...
  theme: {
    extend: {
      perspective: {
        '1000': '1000px',
      },
      animation: {
        'pulse': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
      },
    },
  },
} 