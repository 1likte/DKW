/** @type {import('tailwindcss').Config} */
import { theme } from './src/styles/theme';

export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: theme.colors.primary,
        success: theme.colors.success,
        warning: theme.colors.warning,
        danger: theme.colors.danger,
        dark: theme.colors.dark,
        light: theme.colors.light,
        gray: theme.colors.light, // Using light as gray since we're in dark mode
      },
      fontFamily: theme.fonts,
      boxShadow: theme.shadows,
      borderRadius: theme.radii,
      zIndex: theme.zIndices,
      screens: {
        'xs': '475px',
        'sm': '640px',
        'md': '768px',
        'lg': '1024px',
        'xl': '1280px',
        '2xl': '1536px',
        'ipad': '768px',
        'ipad-pro': '1024px',
        'ipad-landscape': '1024px',
        'mobile': '375px',
        'mobile-large': '414px',
        'desktop': '1366px',
        'desktop-large': '1920px',
      },
      spacing: {
        '18': '4.5rem',
        '88': '22rem',
        '128': '32rem',
        'sidebar': '280px',
        'sidebar-collapsed': '80px',
        'order-panel': '360px',
      },
      height: {
        'screen-90': '90vh',
        'screen-85': '85vh',
        'screen-80': '80vh',
      },
      maxHeight: {
        'screen-90': '90vh',
        'screen-85': '85vh',
        'screen-80': '80vh',
      },
      transitionProperty: {
        'width': 'width',
        'height': 'height',
        'spacing': 'margin, padding',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms')({
      strategy: 'class',
    }),
    require('@tailwindcss/typography'),
  ],
};
