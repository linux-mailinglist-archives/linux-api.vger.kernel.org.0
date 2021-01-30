Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB7730973B
	for <lists+linux-api@lfdr.de>; Sat, 30 Jan 2021 18:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhA3R2n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 30 Jan 2021 12:28:43 -0500
Received: from sonic311-49.consmr.mail.bf2.yahoo.com ([74.6.131.223]:34508
        "EHLO sonic311-49.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhA3R2m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 30 Jan 2021 12:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612027676; bh=swjFzKWryy3sOX8AFtSHoDzy7h2wolCnmw3X8FGxf9o=; h=Date:From:Reply-To:Subject:References:From:Subject:Reply-To; b=SN6R6vToDBl7Yfd8Og72Gn4Tgs0aYMABGVLzmvDoMNkOXhDuva073rtxYj+wDpe7F3HZU9O/mzt4QmAaE0E0zWKVTnKvFyVcsACVqXqpi2/cchosI5yM1lY5nC6eRBU0htGEvevSZbCjOfpGCxN185MCXvNVS2YVEKFc0H4QhGO0KGfhqvH3L8orFifvrxiQaXg++ZK70vtIBvRmkBPHgUU3piESphIv1oKSWnsUj6L03UAM7KBv8kh1au04T6grQzOMMQ5naL/3R+yEA6+m194YHOSAiauLXZRu/zhAFGbD+tyP9CV+5/XA+H9LFFGzZ/vNyMd2hkhjYxQLOkq2Nw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612027676; bh=DcWVkQoLavCCwH8ygCeMLKLPl96zPEv6TcBAdz1G7fQ=; h=Date:From:Subject:From:Subject:Reply-To; b=sOUiThYtCQibD6sbKnBQhpog0/j93gBq32gt+hB/M6h5bdDuvjYxRtEkm82XR5ufueUwk5V2kTFd4Sgm0WV634G9ihSV9eDpN65924C+0sUdhEkkMzGLzR3ab+KvSU2lJgtRsF9YwnlH8Vb9rt8bzckpK1P5x8XCGWtHBUlogB2BIppbDdlsK5BjrpooPEo5VoEzerya1h30Z7v2AMDEEC2/PMZ3U28i/9OvnCk/+w/JTKJj4SygCeplMUn11bdvyIvJ2W9W4bfrYzXTXn7bL6E80G74NpEGLWqkuazceE9JRwOjouWz92wAtta5S9g/V8NcjKOLUUSYpBafO9O7ug==
X-YMail-OSG: hiwT2m4VM1mP.rhuAY6.TqzhBkYJASeNJzx83eTFg1zOFOUuPJiIlPbBRaVIP2U
 YST1Qo_6KNyDpCYZr2VWVNLmgm0Dn.Nkz6Hu_Zeb2g_H9d.fSiZp3E3VWNdZr9VzfIpmTUfEYCYL
 5qL4_7.Tkg1H6Te1.vijfjantnRdLqBcLlApCIdXCryhQZfMAR48PjKrFWN85PJxkAwgGOpLZ5O7
 uE8k00Qw8twEUY2IwQGzPAq9YbmXo9m7MZyi_Agdr.wdB7x82uGKZaDxUTyNBQCDITJ9C2SJnEuN
 mi38cwpFJ1GVepanOO9lI_qHzSh2ZsPyxNDSCeYnRrSsRwMWBo2qOABOOKmc64PXvaoIpf6ysvx6
 .ZoNH4LiQJr21A6FUPxgfAZFUS6_9oZFNkhsVJUIBpwOyd9hKYqFYGnCA_03E6a4.Std6WS1egsJ
 hheEIAR.hJxkhaaUdf0xLQE8XuX6Ia3n1XyUR5xPj_h.0HrZGrS4QWuSVAgmJUZy.yM3W5eGVvEG
 b54KdJ7UVRIO2ihKdFINQWXcHqFkvObpExsnVhKVDhjzstImi9VcKDFZ4DKdIALbplX9OZMowYca
 lohVTT6VGStw9fWvl.i09aoTgZg0ri.Bw.WNced8zCNG0tsBpPrl0Rp.Cj3BJBdXeNzXqCUZ2xRk
 hi.RjNaCF9uBWNF.g5qqsR0ltAbeoPm3vbkeSdNeZqsLR0smgJJafCQD1hw.44BR6.uZS7TQgcGX
 ijhBeqjGidP4i6LmLEtqheVWd6A4TFIy8tewxM6Fl75KHKDx2BnUJcKxPABiI9YGJwIAk5cQIPdP
 C1mqWJu9DUQiGxe_i9pDKJYCSIgKe_u6fLfj.0tPH85auFqEz3LD7DW09FXakvYA8DJJQJ55Nq88
 IhhjSi6IQZnytbFyESYu9dNQV4ozS39i83c50Kqlm61wJlIENZxlLKKbId98Ix4u21unskI2.irk
 rZKfyX8LbEHqkH5LVFAcwLYNiNYwBvmoKm_ZtGJKu0_D3vOCOy1dwIAp.ydSLoy_7Mvh9Jb.OYK3
 O5pgbrNXMwLuQwBhc59VtAyxw_cV.VODgMD8Kxo8zWxZXSk05OSTE_8MlsQ1CcXyyd7HZFdmLdYP
 WWUkpNlxbRqwBj3_tCruJbJLoKsD.k.sUYbnxWOSoBmers_Izhckm3sGmyO6dc8PCtJ_J9hqGHuN
 IEVuKYrCMTSC7541wSjIoFuGQr8AW9Eq2U3A79AdG8qQf_pYodJ3Yf0KqAsrUBSOIcEJywgfXBbP
 nCushOQCzMl3h678ZVQhdi.Kc.VWh.ehFM1dcKqMneRUyfLz1Cd7bGyn1JI4oGyk3C_7.7SZhvI0
 97OYR724WZVTUdhzhmHQfQgLfVva67sj86T8vmjYO0nlFwQoqVbBzWWBnzF9yEtP6GYt4DxBeJ7n
 NDIm_fsUc3YCkxOP9ZeRZNSrl4uFkVgW507ZtSKk.wMu8.e0riTtmmK6IBZv26T3giizBtPfvxsJ
 9kpCCXJv3vsuGN4xxkzksEwBdkb0Ftg5tcOYDM8kkIJye97EaKC6igMc7A6DCBYcB4OrzvYeq0vC
 su2.RDmmgwMc6rvo9NpnkCbFrX3z41mxIR9cdTBLKq8DvHWDia_iqw3tEkeIHhZtlENXoA9oeIQC
 20VBrQdLdaLLkJ84JtMIegdniNwGyD1rG4NlqVCyS5mONcSu6q65z14zGomCkDA3lZwb7mGYJ5Ul
 XaFcIte5fwCmWO9G6n8_ezpuiYHD6v9JSm.a5CkIL2hxEu_XBnF.FvPiIfNHEZg9JVhqHF6c5KAf
 tIaHP9sED9cz9DVFDv9yJx2joybO2bkMUHRQ9UeKdpt2RrOQJfC7qYycgrxOMJhGWy.zhNgj2vpM
 IK9.7kBxTkrfQoElVyfbsC.WBtbJF.bnggPNhxBl0DdNdwWHW0xsqo99oLd702VdduIRGwkV7Bvc
 A308IxcPfvSzb7MZiHNNNWMil3TxXuj7mneXDiaoXutWPPTGAEzWbim4MuYatekCuXYi0X2Oopt0
 01v0X9IdVZRPxiOJMXed4qgOz0T0NvX0uHJYjmF0uWZg.wtOBxXKRaOM6q1ENYz2lgbYkJnysVv2
 xjAFWGz1ZiH_g0CzchzueLYKCMN.KaAWVZUpzG5Y0ANHRnEqlrlxDff3c7X738BDexm4B3kAgniE
 zuN5mPBWE.twOuPJBk1QDN.mdYFWE7YoIE3tgj4Ty.O3_9q05_OZ8UBrSotvvGFJFAXqNZoC_XAo
 NajSJvkPklhOMGsrubRZ237GDKR1mnuw05Ri98udZDBvDMELiCuPM.rjbMBh0td9wbfG42dYLcMK
 ANzLq.fFaHL6JDYYre78uNEyg3BSR55odgHC5cZHjYjBmrMieqATuEX1w63tqKcA.e386eayKcRZ
 lXEt4HafATOZdMQogxWZ6TNmUBVImGX57JocV9p8oxgV2eK6hOE79_6yCI0U4FF9dgbGEPQIWSRO
 CHg2JNmJCd8nNwOFvRmdruh0phHCjF71F2ZHnCy.VNoNpV8XWRjeIWaulcR3m4PxDr9WQMn9.IfV
 jlSJKFWYMORuvdfFOe7d6DrWmvQKRMgQjPhtkIFAcOy.xzfDJL196A4SBlR8Z4IADG9I3lVRjQ6t
 b9.klInc4SdMjCv7kFJyecVZNEUuwiu7h63CHqDlx2x6aIyGjvNeOlzKF622_rUrYwR0EVIhDtAH
 hwD9LqRkxicHKJEbsJ7v7__GeWNNIUqh016HvdBzbm85K2SgHRh8.pcbdinMPp3NU8X358gss22U
 llGQsfSGwEx6XdrkS9BMmnDacdDeWl4.M49wT9SxKotsL623jMgBwk8tHygZcBVtY91lyQDaEW0h
 wUn4re1OUL7ovuFdrG7yivjElik.acTwgxU.LADnKUAu.dGESOKK7tBFWNt0aVo5jms4a9rtLJb.
 3rVrUBvvgtbqaS.I7oKehMHolLo.wPmdfhIJTmSrpm_Fb4H1HUyGVioiyo9csy_opRdLgoa8dYPd
 _of8xJmqw73PACelgTMLgjIEGR.i_sVeHV1UxB8qoR17oZQeZikSiZXHDDNm1q3xAXJYEiYaSPX7
 GnYrrCilZqu2tedO8S7XFuo5ySbIXNrV9bJvlYeKbL8qWM.paF4YxGS1kYrVoqCGxvXnFyaaXcFi
 .K.r2vX7Tkonll58z9mFdZIwattYyReiGbVFWDinTVRtIkBpjEq1I_CXiEaLi8HX6YlbVEPIswYq
 4TjSIUFB_sYNowGZRmK1ZAP2e3gDJw5cRZb.hHnp1Z8PsvouCB4g3DHXwFihmu1tFGC7CW_6h55b
 o7x2O52F4r5NRPIZGUfZecfLs.2xbPCdmM8CL6e4w3ktkv.mUgsdlD8ZYAQu_iC9a5Ua7zH2Gymn
 DQW65lhqwkqGLodJPebjJI7oNfFdru7ibOl3KfrqbFxv3V2kK8dIpS66mw6POmFvs50Di71A40VC
 0uULsr117fwynZOwhXLP92yJnTXJqjLZHU3EaQVIG_GHc.iRJeEe13Jl4QDEI6spAZ7BErBZmGjs
 emmmA.BcDw5pVMrkxWj5sG.YCANN4SOA3Ew4sy1HhM41R4DiyVcaTf6ldgIvbGs9JJ5hcwKGqv6d
 d6L0nyoly2MVCM4kXflc7ZDiXaYGo3eQ0xAmuLxXxUFHfrQ2y4R0srErIOSFAIzW9hEl.xt33Zcb
 kY2b1GldoSYscaaxd4kLz4K_aHHJ_y2lSPI30d4E2jpNXYxZdGSe5ZGF0_JJrpRqnlWBs.ikO8FZ
 rBoaoeXU442Ryk0qrHocJ8q.2_3kizioEWfXD3JaJBmBq4B4dGlyVMSMee3UDY6dnRjsj3itz0QR
 QpJK8VuFDXnsB.H0LHLA2pBsdop.Q_29aKS0E
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Sat, 30 Jan 2021 17:27:56 +0000
Date:   Sat, 30 Jan 2021 17:25:55 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <mau32@cgjzo.in>
Reply-To: maurhinck4@gmail.com
Message-ID: <1885069889.397995.1612027555601@mail.yahoo.com>
Subject: RE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1885069889.397995.1612027555601.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17648 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck4@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92021 The Maureen Hinckley Foundation All Rights Reserved.
