Ghana forest reserve ordinance mapping dataset, 1870-1957

Purpose
This CSV is a source-grounded starter dataset for mapping forest-reserve creation/status years against the colonial legal framework in RStudio. It is designed for historical GIS and legal history work, not as a final gazette register.

Method
Rows were included only where an open source or project source gave a reserve name and a creation/status/gazetting year between 1870 and 1957. I did not invent missing years. The legal authority column is mapped at the ordinance/pathway level because individual Gazette order numbers were not available for most reserves in the open sources checked.

How to use
- For mapping, use creation_or_status_year as the temporal field.
- Use legal_mapping_confidence and verification_status to filter map layers.
- Use r_join_key to join this table to your spatial polygons or manually geocoded points.
- Use source_note to decide which rows need archival checking before publication.

Important limitation
The dataset is not a complete list of Ghana's 266 gazetted forest reserves. It contains verified rows available from the project files and open internet sources checked in this pass. A complete dataset will require the Gold Coast Gazette, Forestry Department annual reports by year, Forest Reserve Orders, and Ghana Forestry Commission gazette registers.

Legal interpretation
- Pre-1927 rows are mapped to Native Jurisdiction/Native Administration by-law or chiefly/customary reservation pathways because the Forests Ordinance came in 1927.
- Rows from 1927 to 1957 are mapped mainly to the Forests Ordinance, 1927, including its mechanisms for Gazette notice, settlement/enquiry, orders, traditional authority by-laws, and management of reserves.
- Achimota is treated separately because land acquisition and forest classification involved both public-land acquisition and the later forest-reserve framework.

Suggested next archival checks
1. Gold Coast Gazette notices/orders for each reserve.
2. Forestry Department annual reports, especially 1927-1939.
3. Native Authority by-laws for Akyem Abuakwa, Akyem Kotoku, and other forest-zone states.
4. Forest Reserve settlement reports and maps.
5. Ghana Forestry Commission reserve register and district compartment maps.
