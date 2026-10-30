KAVO TECHNOLOGIES — COMPLETE WEBSITE PACKAGE

INCLUDED
- Responsive public company website (index.html)
- Private admin dashboard (admin.html)
- Admin content management for portfolio, services and testimonials
- Customer booking inbox
- Image/video upload to Supabase Storage
- Supabase schema and row-level security policies (database-setup.sql)
- WhatsApp booking handoff to +234 802 073 7884
- Luxe Haven demo project link

IMPORTANT: WHAT IS COMPLETE / WHAT NEEDS YOUR ACCOUNT
The website code and backend integration are prepared. It cannot be fully live with a working private admin until you create your own Supabase project and put its URL and browser-safe publishable/anon key into config.js. This package does not create a domain, email mailbox, Supabase account or hosting account for you.

SETUP — DO THIS IN ORDER
1. Create a Supabase account and a new project.
2. In Supabase, open SQL Editor, paste all of database-setup.sql, and run it.
3. In Supabase > Project Settings > API, copy the Project URL and publishable key (or legacy anon key). Do NOT use the service_role/secret key.
4. Open config.js and replace YOUR_SUPABASE_PROJECT_URL and YOUR_SUPABASE_PUBLISHABLE_OR_ANON_KEY.
5. In Supabase > Authentication > Users, create your one administrator user with your chosen email and a strong password.
6. Disable public sign-ups in Supabase Authentication settings. Do not add a public registration page.
7. Deploy the complete folder to Netlify. Open /admin.html and sign in with the admin user you created.
8. Test: submit a booking from the public website; confirm it appears in admin Bookings and WhatsApp opens. Add a test project and upload an image/video.
9. After tests, connect kavotechnologies.com.ng in Netlify Domain management and configure DNS exactly as Netlify instructs.
10. Create/verify your business mailbox with your domain/email provider before publishing it. The current footer email is a placeholder.

SECURITY
- Never place Supabase service_role, secret, or database password in config.js or any frontend file.
- The provided SQL enables Row Level Security. Public users can insert booking requests and read published public content. Admin dashboard operations require an authenticated Supabase user.
- The policies allow any authenticated Supabase user to administer data. Therefore, the crucial single-admin requirement is enforced operationally: create only your one admin user and turn off public sign-ups. Do not invite/create other authenticated users.
- For higher assurance, an additional database admin allowlist policy can be added after you decide the exact admin email/UUID. Do not share your password in chat.
- Public media URLs are viewable by anyone; only authenticated users can upload/update/delete through the dashboard.

ADMIN
Open https://YOUR-SITE.netlify.app/admin.html
Use the single admin account created manually in Supabase.
No public sign-up is provided.

BUSINESS DETAILS
Brand: KAVO Technologies
Tagline: Digital Solutions for a Greater Tomorrow.
WhatsApp: +234 802 073 7884
Domain intended: kavotechnologies.com.ng (availability was reported by you; it has not been purchased/configured here).
Email displayed in footer: hello@kavotechnologies.com.ng (placeholder; activate mailbox before public launch).

CONTENT ACCURACY
Luxe Haven is a demo concept, not a verified client engagement. No invented office address, telephone number, client logos or testimonials are included.
