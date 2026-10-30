-- KAVO Technologies Supabase schema
-- Run this in Supabase Dashboard > SQL Editor.
-- Then create ONE admin user manually in Authentication > Users.
-- Disable public sign-ups in Authentication settings after creating that user.

create extension if not exists pgcrypto;

create table if not exists public.bookings (
 id uuid primary key default gen_random_uuid(),
 name text not null,
 email text,
 phone text not null,
 service text not null,
 budget text,
 preferred_date date,
 details text,
 created_at timestamptz not null default now()
);
create table if not exists public.projects (
 id uuid primary key default gen_random_uuid(),
 title text not null,
 description text not null,
 project_url text,
 image_url text,
 video_url text,
 published boolean not null default false,
 created_at timestamptz not null default now()
);
create table if not exists public.services (
 id uuid primary key default gen_random_uuid(),
 title text not null,
 description text not null,
 icon text,
 published boolean not null default true,
 sort_order integer not null default 0,
 created_at timestamptz not null default now()
);
create table if not exists public.testimonials (
 id uuid primary key default gen_random_uuid(),
 client_name text not null,
 role text,
 quote text not null,
 published boolean not null default false,
 created_at timestamptz not null default now()
);

alter table public.bookings enable row level security;
alter table public.projects enable row level security;
alter table public.services enable row level security;
alter table public.testimonials enable row level security;

-- Public visitors may submit enquiries; only authenticated admin may read/manage them.
drop policy if exists "Public can submit bookings" on public.bookings;
create policy "Public can submit bookings" on public.bookings for insert to anon, authenticated with check (
 length(trim(name)) between 1 and 100 and length(trim(phone)) between 5 and 40
 and length(trim(service)) between 1 and 120
);
drop policy if exists "Admin manages bookings" on public.bookings;
create policy "Admin manages bookings" on public.bookings for all to authenticated using (auth.uid() is not null) with check (auth.uid() is not null);

-- Public read only for published content; authenticated administrator can manage all content.
drop policy if exists "Public reads published projects" on public.projects;
create policy "Public reads published projects" on public.projects for select to anon, authenticated using (published = true);
drop policy if exists "Admin manages projects" on public.projects;
create policy "Admin manages projects" on public.projects for all to authenticated using (auth.uid() is not null) with check (auth.uid() is not null);

drop policy if exists "Public reads published services" on public.services;
create policy "Public reads published services" on public.services for select to anon, authenticated using (published = true);
drop policy if exists "Admin manages services" on public.services;
create policy "Admin manages services" on public.services for all to authenticated using (auth.uid() is not null) with check (auth.uid() is not null);

drop policy if exists "Public reads published testimonials" on public.testimonials;
create policy "Public reads published testimonials" on public.testimonials for select to anon, authenticated using (published = true);
drop policy if exists "Admin manages testimonials" on public.testimonials;
create policy "Admin manages testimonials" on public.testimonials for all to authenticated using (auth.uid() is not null) with check (auth.uid() is not null);

-- Public portfolio media bucket. Upload/update/delete requires authenticated admin.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('portfolio-media','portfolio-media',true,104857600,array['image/jpeg','image/png','image/webp','image/gif','video/mp4','video/webm','video/quicktime'])
on conflict (id) do update set public=true, file_size_limit=104857600;
drop policy if exists "Public reads portfolio media" on storage.objects;
create policy "Public reads portfolio media" on storage.objects for select to anon, authenticated using (bucket_id='portfolio-media');
drop policy if exists "Authenticated uploads portfolio media" on storage.objects;
create policy "Authenticated uploads portfolio media" on storage.objects for insert to authenticated with check (bucket_id='portfolio-media' and auth.uid() is not null);
drop policy if exists "Authenticated updates portfolio media" on storage.objects;
create policy "Authenticated updates portfolio media" on storage.objects for update to authenticated using (bucket_id='portfolio-media' and auth.uid() is not null) with check (bucket_id='portfolio-media' and auth.uid() is not null);
drop policy if exists "Authenticated deletes portfolio media" on storage.objects;
create policy "Authenticated deletes portfolio media" on storage.objects for delete to authenticated using (bucket_id='portfolio-media' and auth.uid() is not null);

-- Seed initial services once. Remove these rows in the dashboard if you prefer an empty list.
insert into public.services(title,description,icon,sort_order) values
('Website Design & Development','Modern, responsive websites that build trust, showcase your business and turn visitors into customers.','⌘',1),
('Custom Software','Purpose-built digital platforms, dashboards and business tools that simplify everyday operations.','▦',2),
('AI & Automation','Smarter workflows and AI-powered experiences that help reduce repetitive work and improve service.','✳',3),
('Booking & Business Systems','Online booking, tracking, customer portals and practical systems that keep your business connected.','◈',4),
('Branding & Digital Design','Distinctive visual identities and digital assets that help your brand communicate with confidence.','✎',5)
on conflict do nothing;
