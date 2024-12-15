// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sun Dec 15 00:38:17 2024
// Host        : MarkLaptop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Mark/Desktop/385FINAL_audio_main/FINALPROJECT/FINALPROJECT.gen/sources_1/ip/blk_mem_gen_1/blk_mem_gen_1_sim_netlist.v
// Design      : blk_mem_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_1,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_1
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [12:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [12:0]addra;
  wire clka;
  wire [7:0]douta;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [12:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [12:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "13" *) 
  (* C_ADDRB_WIDTH = "13" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.3264 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_1.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_1.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "6200" *) 
  (* C_READ_DEPTH_B = "6200" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "6200" *) 
  (* C_WRITE_DEPTH_B = "6200" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_1_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[12:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[12:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 45328)
`pragma protect data_block
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
ASkJtUT1vqdAIsvXLA==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
