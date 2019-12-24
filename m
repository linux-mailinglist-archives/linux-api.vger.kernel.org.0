Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8892F12A47B
	for <lists+linux-api@lfdr.de>; Wed, 25 Dec 2019 00:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLXXRg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Dec 2019 18:17:36 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:43624
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbfLXXRg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Dec 2019 18:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229454; bh=GxEWr5HgHGsSBsXd9YqS3jNBdjUlWzqzucoAC9IGxLI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nJg94cHrGdVg7MLgk2LFrsAmUfqn1OK1bZZznESR75QiOL4o/rJJz4JSvIC+bN3tjQEfPPxd4RblcrhHKv3AKWCxF6dVcLFU1+Gm5dwYapCIxbF9ShqvxLy8CR9pRWWMrvSa9ExQXwlx7xMDji21msCKRwCK1zU1W1l/Z2AzeMmc/33wuz3kCbWPCY3CArX5ak9Kc+roPhvLgxFlxhTuYcziocMXjGCX//nAaXvfWODOweWr0wbYUcdJVXGUjdDMsq0q5GuFaxBalGyHMoDdNmi4ONbZZ1+4fD4vIkQOzTYft4HJG8EfyQRRL+5rXZXItSyZMa4NOEuU+hxoMw1z6w==
X-YMail-OSG: yhRkp1EVM1n09GHHon.Jv8lEu0BSJA9Fq04mc2e.o274Sc8FvcTLuFfiSqongEY
 VnOMiax3CIAxMWfMnHvsjam2.xCKMZBoCHSvCkS1USC2iBVBGnKR52uPc4Vm7.qcukMmNzKX.FwU
 BWE386O9FGxIwjC.uugZN1CbeoZTwd_fuw1lHINFa_Knuvr0gJv4yzmzaW6Ygz32yn6vA9JlqIBc
 Fw0p5YhZySflLoaNodDzpBKtu61DBb_9e_lpEGsX6lCFUdm8n0NXyJsoCK8JrYZHGcCdDyiBo_WZ
 xEBwQjOpOlVJ_mXp0JnyiygFYA5M_GyQbprTELKqlrnHDcg_il0mNTleavypyU5FcAu3mwviEcAb
 3zbw5yuB19eZAbth_.9vsGx1RvLeSalE1r1j1azF2m97nMz5Dmw0sd0VcFl_mrguws9hcirGMl1.
 FOsswYj.gzh9pLxoJu5dbPMTttVnZZmQ3sWpy6yOTH4YGC5eIHsh2t53mJTmQ9XRdJVw4RT4wKyo
 fBx0cDaueJlo2zQACuZaP9ykO2daBiCZK0xvg7D_SO758Mkguvq7wDRnpZDqLWlO.5bdY3Vy4wc0
 uNxtixoo8SRI0isIBQP9JVhMZGWSGhOUsOqAA3PEnFDwqw9200bOsVgfKneUsZHR2oLkvRGJKaG.
 XkRL5rqL8qt7TZmUsxfAuIbpOFB0uMHB_ImyDUQqkEiUrevGXL0MWDnkvo_lqY_MnObLAGDjxh1N
 E8MimzL9BGiQQ0zT1K9pW.l9Iq0EOEHzJ5WzeApomZERauRCaDvCHgmG0r47kVASliGgOH02TxXO
 E7.pKdqbDt.OPY2Cbryo7mtV3XTzCZv2F2gCYlNr8_uTtKd_12PnXeHvWulT0La9_gmmj1CYJblD
 KSfVECSB9Vpw_.l8wIyV_cYFEhKuI5CRjic680wfH3YtzO1zWq5fHDeoXHJpVtF5weYluU.589JO
 6LkDvU9JbmtE8wW4csjhSkYYyotGf1mJ6Ii8JOC1pftpTm.Fp_KQ.IPtUVFQNVWMk6kaYs.TEMN9
 Fl_kZyfTrvjOvLhPiW5Fq6ERAq3XzJ46Y0tiDQ6EGnA1MEIydpyZ7PdG_y5mLpAf.F6nMOErR1mg
 VSQ4J1FOeS6VeI4t_cCnvVOHrGVTF7SZusmJv1tyqbX9Zza3Qp9_5q8VUa96qN_2NXvFpGYmFJGi
 Gnh_GSJX0EFP6l_WilSLbsTZxopfufvVtPNM8P9hldJA9AQAeOmysb6ttoLBtWEQi2iF.kMZaZh6
 v8Ncgi_4wcljXuQmBPcU8VTcLYFVf9ghWqYbM_z6k87r_y_FCqyQAdh.ENVz57ywL6JcPjyHLU_9
 7pj_Vsbrk65jKD8qmy1jwxauWqDfagEMKFxli.9mc8xij_CkuBVdZq4ZL6DxCCjxA1wbQWqiXg74
 fIaD5YlwcYhIgsYx7YamLq8ankfmT5uHBPu4nlWmrBCVP0_pRvn3cMWA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:17:34 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9dd5fcf4860133b7b80cdd3a74c506ac;
          Tue, 24 Dec 2019 23:17:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com
Cc:     casey@schaufler-ca.com, linux-api@vger.kernel.org
Subject: [PATCH v12 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Tue, 24 Dec 2019 15:13:38 -0800
Message-Id: <20191224231339.7130-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231339.7130-1-casey@schaufler-ca.com>
References: <20191224231339.7130-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:'
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-api@vger.kernel.org
---
 fs/proc/base.c      |  1 +
 security/security.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 950c200cb9ad..d13c2cf50e4b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2653,6 +2653,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index 1afe245f3246..e55789fc4cd3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2099,6 +2099,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2126,6 +2130,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "current", &cp);
+			if (rc == -EINVAL || rc == -ENOPROTOOPT)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
-- 
2.20.1

