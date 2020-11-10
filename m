Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E32ADCE9
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 18:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgKJR2q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Nov 2020 12:28:46 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:36032
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbgKJR2q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Nov 2020 12:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605029325; bh=77QiCjhR/WkJJBxxl0uVBiHR2j6qU2I5mSEQJBTYfBo=; h=From:To:Cc:Subject:Date:References:From:Subject; b=ZqYcU4euc+CbRx1G0YsYbnJJNddjP5btauKdTRsgS6yqOsHqdK2vhcrqf1NZRGDt4uy2h0iuRfYH4aZPGlz6CqPFmmhKKzc/sxFIDqngH43xUeJTGcaiUWXY1PbW0nU3sFSG5VbTbhffYgyF29N4a+GTDXZ09sR8o490dJrJHqO28Umg5Ee3fW/4v4nyYk6560B7T3br9pYw/deNN5YtApK2fgvAZfia5GvkbrqPlnwFjXXBqmMxfoGYZLUd4m/d0rg+xZODgRNUmyxZJtAuHIrSINV3xYiWn0DeOv271JK0zeKhj9Rs8sOlIX7AmQ2ofsuUqC2zzqBBAVtYnxtVGg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605029325; bh=+i3EIhZhtIwgiIp3YZzf8NYJlP+FOAsOwvzYcitRDlR=; h=From:To:Subject:Date:From:Subject; b=C0zsSWVkcCb9HLbbFAXH4MOsejYoInMHbX76uYA3vUt+pLfRqTw2E3Jd9zHlHBCdcBRffHit6vigt4MGNpcobhOE1oXukHDifZy1pwZGLoVwLjwPb/PJDEy0SPCltTPMONvxwRWgN5qZTVGTQnp/s88qHY98sfkMGg46LNmYvTlCzuSkFKGSt7/FJyC0Yvc92sY1w/+LWbRgia3To46WwMi9g4XiFxObZ0cnas/rW5lTGZmQJh5GYLJAbMl1QdvO53/EgB5L5hfNFyPnzatL4pyDTjmNPMguCK0p8zEtblQqaqvrDQFaDnHM6hEtRuNY0F18oxrBD9ZnTcjip+RqGw==
X-YMail-OSG: fzmBBxMVM1nxMenNWS_ejTrab_SoIaupPuqzRy7lHQSHwRFe3v7ZTqZN1yH_zDo
 U17MUTebcKETGXofpXgtKUFiF5W0pjmVMqu6nsb8n0Lb9wSUzr9BPzPkjIHsYdx.WzwqCLK98WSF
 SOJkZGiCJB4kb8L2JOn1WxoQyOjugLxcYvkW.6JkOYZ3w0eXyOGpy0wYn53yf_8e7Lu3ZGMBHR6U
 dNWX._SCdmg1KfEbyUibT4jUj1xcZnYuDQUIIQbVg7yBHBZivK2aC5ueFQ9K5QfRK.XK.G9P3lYD
 Oc8CyeeIZAZ8xsTqR8lh4TFqQC.Z7zkttvn2vhv47rMLqvSyk4KwuQ_hyBWzucu.p.VCl0oCXK2F
 _QqssunH2aiN3lp4rwuD3qUsxkuxPUeoSdp9SBry9StBH9ALVFj.yCopMC3DpR5zLOkoj2gbhc08
 kgIa0QQJAYnq.XHs5okGXsXwMMekJG_AjTcN0aBj5C24SNKXb9SKsLUuLW4BDnD1c.QRGQyQuWn7
 .qWses21f9ZvmWDGqTXJhct483Wi4pWMXe8m28eUWih17nUpudlJMXX8HBHQFQJEH3M2qziI90Bq
 vmeK4c_DTPEfT6_0oqE5cmlaZqFs_6v432EpuMsT6MQId5gm0leWnOTgZfUlXLs_vkKdljt1Iqcb
 FiDT7Bcrs6nYExbq1y19Q0ibt6StffXcIiBbCZ1g4DNyxruGQI6cMIbp01Q5Ljai6V5v896yiOJV
 mtGU78vWu_M_1wbV5PKD7Ivomp2XhV8JMh9W6Xt49zLbmrVuoManFrWjRCNJWu4A8Rl_0efpGxqQ
 UGSAnpGVKWH7SCc9_ml_lOEjHePFeLjLXvbwRR8LhzJrSL.Znj7j_zgEzDILB8xTLR4EklLDIXag
 YD32mxUxfgDwtMEDupdGphw8fV0qztT6alD2Y6vO6TRD5tZpQZK2xeehxuTh_EIO3.5DYi00StR0
 0l2qx9.5B8_Bo1Fuf90BkYQ_ae9JV.WP.02D_pDkRr5LkNoWG.WRrwMtf_wvUH.AxZfPJbmouHOQ
 eOLOJ8.68Lo86lkJhlzTL_4B8Msgs65BUByGZGVQwamrUo2b4te.A4zzcNWxWrdlb.U5I2lS.ls2
 I9K828c1l9Viq3fuy.weiCn0cUqZurXNTfD90NYa745Kf2LB.lqrNAwW9yn1Vxb11vsp4RTj3I26
 r8wuCPxJzYXNxqSHnsgJA4bu3DUfHTqwPzSq2v8f7wOdVN8GrBGxq02AaF7KlmZZ4iTOAdoKtL3Z
 YGNGVhpwxxp7AXGwGJ4TrPFnb7z40CuIhOftFlAw1diw4EHnEloIxWrgbMeCvHAet3GyX1SAdXgr
 HF4_e9JMu3mvzHXRkGijEiKcvoiWv.zs2SisshDUqDGABqQGsauJFhbGVt5tKpJK1_I7uXrC9w2U
 _d9zVdWZt10EFAF4Gy1i3IHD0HMF_Be1ur0xRgoMsR9lOc9v.6AYwS7lbDh4FAtcMFwYQewYRL2E
 9uzOaRtjmtVObCX36fEcr_KY.rXFqll4qUkJ_0HyucGztg_6G52kn_.Zex8jbNluZJnM14CY6oF0
 0ZFhzouEzKY.rX9kOLwLtIGo7M0OVrzhQag3VBVrnpptI5qP9GMWWoqNl_lCt7WBz5QFBHt_E36W
 VtD7w_kUv32.iffcXS2PCNS7MLKiiAdqVerA0urkLOZaZKyRDslzpiBhAnviPHFuFOnMk4qqM0b3
 PW.qNyqTmLBrGEMGftDeEnDR_WutPUUchNNC9n7DEnRKr7bCgcDvqE0E9bqWPvpquDmwlZrB2Dfz
 rWJB2xESNe5YBLuhmtywzfFryaaTgyeMyAGHV_IwyO9hjd3ygtSLKbvx0dwKDZrtfG7bcFQiOnR9
 zji3SwlfZ4yl71QVkFeSD_dgnHAoxPrpeD1bd69ws3giQaiztzhQYcsvVEdWbRy9M0b9L7fOPq_9
 7rbV2BoisUhDtNZm0ZkqdKZxV_l98z2csHJwb2aD1hU09PB2AOV3nVm.BPTug29wVFFyo2Yncbv0
 w2nvN4glBtByR_vP6WgHLLjGY17RbLGcWGBaKwuN53h8pcPu4dhnzdSx6f9xQ.TARDkvt970j9Ia
 Me8938jpKxw7dfc1OPRb92eN_VDTltExpOlWeI5Lcr7Y1d_hhTDpV4Dg9rHaQ98BNe6_lvZpLL3C
 jHwocD0vxzRqnFm5abQmlpu8BmXH8oycqsABBOoIs0uFSAj5Wz8.B5kDnjMy.NJ6e73eC4.2lKpd
 zWP0BoMsFqfMFORRIOTnkmNRXYSrk73rD3d79aWjKSHQWI.RLziRwIdnd4poIvTqMPdfeEDWGO3w
 bzExOnfRygBp.PDGU45kf3lhe4f0EWJ.Fa65Tq6IDDKD5K_x6TlhgiLZvU399F2CNIubjVB6vGa4
 ET5F68Qb1Du2Tm3l8ivigS.0Bfnb7QAPzqFrUnQDQRXEJJUWvnh5SBTed70D45hVwM.83t6L3lW_
 0dYsqR7NUwUBiRuq8FHOcKFSFfuoZnHR7njDsBxDLm_iEVEy_HZwXEXAjxiHPwtzodNNHCsnISVA
 tAGk7DNigDrGiBdau1C5GJ0z4__9Yls0sSyByJfsm2eeIK3jU.ZYb_BgpOMgHZReWz8pS9Udytx2
 hO8a_Hz5v4F5aeADazKi.o5SFGkCTDbNxW0Ap9VgZaZdao6yKy9AptQMchYx6yVI0rj9_Wr9O8eh
 T5YifLsL3Soox76ze7MghvHh6UpZQ.XZHsIC_cTOR.HF.sh6j7ZzjIqX2JJ7xSAxMSkuzdqcKHjp
 3_OeRdJKhF_3WC0W00dggWVovhUdc0MmrXRJsSmsABmCwdS6lcztYb9g.bhGQfZ2gayTVgxSotbm
 pxBMQM3hdzwdp6P_17dQFYmEx7k0TlmqadSbyGPy1N92iUCSGNEB1dy3hpp_DDW5yNvHPquX_Ecv
 j4S77We2FmJktaVYXRU9rFyPIkadUlAZYO.BDVyahqfvD2hPP8FyKIYdcXwL5zrh4Q.KOs9AJ8AI
 _Rc0SkUBtexH0EZfF3JpdtcId4LUhgg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Nov 2020 17:28:45 +0000
Received: by smtp410.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3b996d132bda857859cdbbdd029f861c;
          Tue, 10 Nov 2020 17:28:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>
Subject: [RFC PATCH] docs: ABI: ABI documentation for procfs attribute files
 used by multiple LSMs
Message-ID: <30c36660-3694-0c0d-d472-8f3b3ca4098e@schaufler-ca.com>
Date:   Tue, 10 Nov 2020 09:28:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <30c36660-3694-0c0d-d472-8f3b3ca4098e.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Provide basic ABI descriptions for the process attribute entries
that are shared between multiple Linux security modules.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
=C2=A0Documentation/ABI/testing/procfs-attr-current | 20 ++++++++++++++++=
++++
 Documentation/ABI/testing/procfs-attr-exec    | 20 ++++++++++++++++++++
 Documentation/ABI/testing/procfs-attr-prev    | 19 +++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/ABI/testing/procfs-attr-current b/Documentatio=
n/ABI/testing/procfs-attr-current
new file mode 100644
index 000000000000..198b9fe1c8e8
--- /dev/null
+++ b/Documentation/ABI/testing/procfs-attr-current
@@ -0,0 +1,20 @@
+What:		/proc/*/attr/current
+Contact:	linux-security-module@vger.kernel.org,
+		selinux@vger.kernel.org,
+		apparmor@lists.ubuntu.com
+Description:	The current security information used by a Linux
+		security module (LSM) that is active on the system.
+		The details of permissions required to read from
+		this interface and hence obtain the security state
+		of the task identified is LSM dependent.
+		A process cannot write to this interface unless it
+		refers to itself.
+		The other details of permissions required to write to
+		this interface and hence change the security state of
+		the task identified are LSM dependent.
+		The format of the data used by this interface is LSM
+		dependent.
+		SELinux, Smack and AppArmor provide this interface.
+Users:		SELinux user-space
+		Smack user-space
+		AppArmor user-space
diff --git a/Documentation/ABI/testing/procfs-attr-exec b/Documentation/A=
BI/testing/procfs-attr-exec
new file mode 100644
index 000000000000..34593866a7ab
--- /dev/null
+++ b/Documentation/ABI/testing/procfs-attr-exec
@@ -0,0 +1,20 @@
+What:		/proc/*/attr/exec
+Contact:	linux-security-module@vger.kernel.org,
+		selinux@vger.kernel.org,
+		apparmor@lists.ubuntu.com
+Description:	The security information to be used on the process
+		by a Linux security module (LSM) active on the system
+		after a subsequent exec() call.
+		The details of permissions required to read from
+		this interface and hence obtain the security state
+		of the task identified is LSM dependent.
+		A process cannot write to this interface unless it
+		refers to itself.
+		The other details of permissions required to write to
+		this interface and hence change the security state of
+		the task identified are LSM dependent.
+		The format of the data used by this interface is LSM
+		dependent.
+		SELinux and AppArmor provide this interface.
+Users:		SELinux user-space
+		AppArmor user-space
diff --git a/Documentation/ABI/testing/procfs-attr-prev b/Documentation/A=
BI/testing/procfs-attr-prev
new file mode 100644
index 000000000000..f990b3595839
--- /dev/null
+++ b/Documentation/ABI/testing/procfs-attr-prev
@@ -0,0 +1,19 @@
+What:		/proc/*/attr/prev
+Contact:	linux-security-module@vger.kernel.org,
+		selinux@vger.kernel.org,
+		apparmor@lists.ubuntu.com
+Description:	The security information used on the process by
+		a Linux security module (LSM) active on the system
+		prior to the most recent exec() call.
+		The details of permissions required to read from
+		this interface is LSM dependent.
+		A process cannot write to this interface unless it
+		refers to itself.
+		The other details of permissions required to write to
+		this interface are LSM dependent.
+		The format of the data used by this interface is LSM
+		dependent.
+		SELinux and AppArmor provide this interface.
+Users:		SELinux user-space
+		AppArmor user-space
+


