Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0732216A
	for <lists+linux-api@lfdr.de>; Sat, 18 May 2019 05:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfERDsX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 May 2019 23:48:23 -0400
Received: from web1.siteocity.com ([67.227.147.204]:44760 "EHLO
        web1.siteocity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfERDsW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 May 2019 23:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=felipegasper.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jC2pzib8Rq8RDjX2koQw8+8PZ+U/nFGIGBi9LwADKV0=; b=Y1BmTae6ZDK4oj5rbucA28kWmF
        4ntpgJeqsTbTcdu4KLgb1HeFk/8tN7C8LhYK+9KCjlEQqiO9NqRHzKgZGPFrKD0G0AbunVkmUiXWz
        FDkX82sTi8Mx6YVQOvLhxIk3O13WB8O6ZREewvD3Xil2JwF1Z4oovA9aXE2530gbMDn3WzAwwNCmO
        JyUcO/VRnCPQ1E3cQHM8OgQBrtgbSHwGkaa2CcqoJkwnHCg+sH7oCX5zbLSXEUJWnwYsE2w7/4AHN
        5yfNPmDnyTtipB+rvwTCC4yGIB3ZJNfkAbmb/STKetFO1pNuTSfjCy8ik+vx9uiU3N1FQHIQx6v5k
        Zco85oYw==;
Received: from fgasper by web1.siteocity.com with local (Exim 4.92)
        (envelope-from <fgasper@web1.siteocity.com>)
        id 1hRqKa-0004Vm-BF; Fri, 17 May 2019 22:48:21 -0500
From:   Felipe Gasper <felipe@felipegasper.com>
To:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v2] net: Add UNIX_DIAG_UID to Netlink UNIX socket diagnostics.
Date:   Fri, 17 May 2019 22:48:20 -0500
Message-Id: <20190518034820.16500-1-felipe@felipegasper.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=0.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - web1.siteocity.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1438 994] / [47 12]
X-AntiAbuse: Sender Address Domain - web1.siteocity.com
X-Get-Message-Sender-Via: web1.siteocity.com: authenticated_id: fgasper/from_h
X-Authenticated-Sender: web1.siteocity.com: felipe@felipegasper.com
X-Source: 
X-Source-Args: 
X-Source-Dir: /home/fgasper
X-From-Rewrite: unmodified, already matched
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Author: Felipe Gasper <felipe@felipegasper.com>
Date:   Fri May 17 16:54:40 2019 -0500

   net: Add UNIX_DIAG_UID to Netlink UNIX socket diagnostics.

   This adds the ability for Netlink to report a socket’s UID along with the
   other UNIX diagnostic information that is already available. This will
   allow diagnostic tools greater insight into which users control which socket.

   Signed-off-by: Felipe Gasper <felipe@felipegasper.com>

diff --git a/include/uapi/linux/unix_diag.h b/include/uapi/linux/unix_diag.h
index 5c502fd..a198857 100644
--- a/include/uapi/linux/unix_diag.h
+++ b/include/uapi/linux/unix_diag.h
@@ -20,6 +20,7 @@ struct unix_diag_req {
 #define UDIAG_SHOW_ICONS	0x00000008	/* show pending connections */
 #define UDIAG_SHOW_RQLEN	0x00000010	/* show skb receive queue len */
 #define UDIAG_SHOW_MEMINFO	0x00000020	/* show memory info of a socket */
+#define UDIAG_SHOW_UID		0x00000040	/* show socket's UID */
 
 struct unix_diag_msg {
 	__u8	udiag_family;
@@ -40,6 +41,7 @@ enum {
 	UNIX_DIAG_RQLEN,
 	UNIX_DIAG_MEMINFO,
 	UNIX_DIAG_SHUTDOWN,
+	UNIX_DIAG_UID,
 
 	__UNIX_DIAG_MAX,
 };
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 3183d9b..e40f348 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -4,9 +4,11 @@
 #include <linux/unix_diag.h>
 #include <linux/skbuff.h>
 #include <linux/module.h>
+#include <linux/uidgid.h>
 #include <net/netlink.h>
 #include <net/af_unix.h>
 #include <net/tcp_states.h>
+#include <net/sock.h>
 
 static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
 {
@@ -110,6 +112,12 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 	return nla_put(nlskb, UNIX_DIAG_RQLEN, sizeof(rql), &rql);
 }
 
+static int sk_diag_dump_uid(struct sock *sk, struct sk_buff *nlskb)
+{
+	uid_t uid = from_kuid_munged(sk_user_ns(sk), sock_i_uid(sk));
+	return nla_put(nlskb, UNIX_DIAG_UID, sizeof(uid_t), &uid);
+}
+
 static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_req *req,
 		u32 portid, u32 seq, u32 flags, int sk_ino)
 {
@@ -156,6 +164,10 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_r
 	if (nla_put_u8(skb, UNIX_DIAG_SHUTDOWN, sk->sk_shutdown))
 		goto out_nlmsg_trim;
 
+	if ((req->udiag_show & UDIAG_SHOW_UID) &&
+	    sk_diag_dump_uid(sk, skb))
+		goto out_nlmsg_trim;
+
 	nlmsg_end(skb, nlh);
 	return 0;
 
