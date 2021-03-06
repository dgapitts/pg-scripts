-- Extract top 50 queries by elapsed time i.e pg_stat_statements.total_time (before running reset)

-- summary details for top 50 queries by elapsed time
SELECT round((total_time/1000)::numeric,1) as total_sec,  calls, round((total_time/calls)::numeric,2) as average_time_ms, queryid, left(query,120) FROM pg_stat_statements where query NOT IN ('BEGIN','ROLLBACK','COMMIT')  ORDER BY total_time DESC LIMIT 50;

-- low-level metrics for details for top 50 queries by elapsed time
SELECT round((total_time/1000)::numeric,1) as total_sec, calls, shared_blks_hit || ' - ' || shared_blks_read || ' - ' || shared_blks_dirtied || ' - ' || shared_blks_written as SHAREDBLKS_HIT_READ_DIRTIED_WRITTEN, local_blks_hit || ' - ' || local_blks_read || ' - ' || local_blks_dirtied || ' - ' || local_blks_written as LOCALBLKS_HIT_READ_DIRTIED_WRITTEN, temp_blks_read || ' - ' || temp_blks_written as TEMPBLKS_READ_WRITTEN, round(blk_read_time::numeric,2) || ' - ' || round(blk_write_time::numeric,2) as BLKS_READ_WRITE_TIME, queryid, md5(query) FROM pg_stat_statements ORDER BY total_time DESC LIMIT 50;

