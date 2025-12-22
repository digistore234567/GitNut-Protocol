import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: __dirname,
  timeout: 60_000,
  retries: process.env.CI ? 2 : 0,
  use: {
    baseURL: process.env.WEB_BASE || "http://localhost:3000",
    headless: true,
  },
  webServer: process.env.CI
    ? undefined
    : {
        command: "pnpm -C apps/web dev -p 3000",
        port: 3000,
        reuseExistingServer: !process.env.CI,
      },
});
