#######################################################################################################
######################################### OBJECT 기타 조회쿼리 ########################################
#########################################      INDEX 조회      ########################################
#######################################################################################################

/* ----------------------------------------------------------------------------------------------------
                        SCHEMA에 대한 INDEX 및 INDEX 정의 명령 CREATE문 형식으로 조회
---------------------------------------------------------------------------------------------------- */
select tablename, indexname, indexdef
from pg_indexes
where schemaname = '스키마명'
order by tablename, indexname;

ex) select tablename, indexname, indexdef from pg_indexes where schemaname = 'wavdb' order by tablename, indexname;
            tablename            |            indexname             |                                                                        indexdef
---------------------------------+----------------------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------
 import_le_xml                   | idx_import_le_xml                | CREATE INDEX idx_import_le_xml ON wavdb.import_le_xml USING btree ("CHNL_CD")
 import_le_xml                   | idx_import_le_xml2               | CREATE INDEX idx_import_le_xml2 ON wavdb.import_le_xml USING btree ("CHNL_CD", "PRO_CD")
 import_le_xml                   | pk_import_le_xml                 | CREATE UNIQUE INDEX pk_import_le_xml ON wavdb.import_le_xml USING btree ("CHNL_CD", "PRO_DATE", "PRO_CD", "PRO_SEQ")
 import_le_xml_back              | idx_import_le_xml2_back          | CREATE INDEX idx_import_le_xml2_back ON wavdb.import_le_xml_back USING btree ("BACK_NO", "CHNL_CD", "PRO_CD")
 import_le_xml_back              | idx_import_le_xml_back           | CREATE INDEX idx_import_le_xml_back ON wavdb.import_le_xml_back USING btree ("BACK_NO", "CHNL_CD")
 import_le_xml_back              | pk_import_le_xml_back            | CREATE UNIQUE INDEX pk_import_le_xml_back ON wavdb.import_le_xml_back USING btree ("BACK_NO", "CHNL_CD", "PRO_DATE", "PRO_CD", "PRO_SEQ")
 import_pc_xml                   | pk_import_pc_xml                 | CREATE UNIQUE INDEX pk_import_pc_xml ON wavdb.import_pc_xml USING btree ("SERVICE_ID")
 import_pc_xml_back              | pk_import_pc_xml_back            | CREATE UNIQUE INDEX pk_import_pc_xml_back ON wavdb.import_pc_xml_back USING btree ("BACK_NO", "SERVICE_ID")
 import_ps_xml                   | idx_import_ps_xml                | CREATE INDEX idx_import_ps_xml ON wavdb.import_ps_xml USING btree ("SERVICE_ID")

