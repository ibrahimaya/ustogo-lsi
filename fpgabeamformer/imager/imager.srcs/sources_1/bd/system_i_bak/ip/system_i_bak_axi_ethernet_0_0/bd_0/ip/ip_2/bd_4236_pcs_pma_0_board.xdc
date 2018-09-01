#--------------------Physical Constraints-----------------
set_property BOARD_PIN {SGMII_RX_P} [get_ports rxp]
set_property BOARD_PIN {SGMII_RX_N} [get_ports rxn]
set_property BOARD_PIN {SGMII_TX_P} [get_ports txp]
set_property BOARD_PIN {SGMII_TX_N} [get_ports txn]
##++ mgt clk LOC constraints not loaded in board flow for custom mode 

set_property BOARD_PIN {mdc} [get_ports ext_mdc]
set_property BOARD_PIN {mdio_i} [get_ports ext_mdio_o]

