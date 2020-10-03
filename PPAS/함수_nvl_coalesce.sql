-- PPAS
select nvl(split_part(setting, ' ',10),'non_archive') from pg_settings where name in ('archive_command');

-- PostgreSQL
select coalesce(split_part(setting,' ', 10),'non_archive') from pg_settings where name in ('archive_command');