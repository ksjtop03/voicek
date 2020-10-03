/* ----------------------------------------------------------------------------------------------------
                                           TRIGGER 조회
---------------------------------------------------------------------------------------------------- */

select tgname, prosrc from pg_trigger, pg_proc where pg_proc.oid=pg_trigger.tgfoid and pg_trigger.tgname = '트리거명'; 

ex) select tgname, prosrc from pg_trigger, pg_proc where pg_proc.oid=pg_trigger.tgfoid and pg_trigger.tgname = 'trg_eai_ims_idms_compn_gear_info'; 