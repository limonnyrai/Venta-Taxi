-- Venta Taxi: облачная авторизация и сохранение данных
-- Выполни этот SQL в Supabase Dashboard -> SQL Editor.

create table if not exists public.venta_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  app_state jsonb not null default jsonb_build_object(
    'passenger', jsonb_build_object('orders', jsonb_build_array(), 'history', jsonb_build_array()),
    'driver', jsonb_build_object('available', false, 'orders', jsonb_build_array(), 'active', null, 'history', jsonb_build_array())
  ),
  updated_at timestamptz not null default now()
);

alter table public.venta_profiles enable row level security;

revoke all on table public.venta_profiles from anon, authenticated;
grant select, insert, update on table public.venta_profiles to authenticated;

drop policy if exists "Users can read their own Venta profile" on public.venta_profiles;
drop policy if exists "Users can create their own Venta profile" on public.venta_profiles;
drop policy if exists "Users can update their own Venta profile" on public.venta_profiles;

create policy "Users can read their own Venta profile"
on public.venta_profiles for select
to authenticated
using ((select auth.uid()) = id);

create policy "Users can create their own Venta profile"
on public.venta_profiles for insert
to authenticated
with check ((select auth.uid()) = id);

create policy "Users can update their own Venta profile"
on public.venta_profiles for update
to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);
