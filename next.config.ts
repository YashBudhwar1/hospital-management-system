import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      { hostname: "images.pexels.com" }
    ],
  },

  eslint: {
    ignoreDuringBuilds: true, // Disables ESLint during builds
  },
  typescript: {
    ignoreBuildErrors: true, // Disables TypeScript errors during builds
  },

  reactStrictMode: true,

  compiler: {
    styledComponents: true,
  },
};

export default nextConfig;
