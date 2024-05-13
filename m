Return-Path: <linux-api+bounces-1507-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F8E8C4598
	for <lists+linux-api@lfdr.de>; Mon, 13 May 2024 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E236728185E
	for <lists+linux-api@lfdr.de>; Mon, 13 May 2024 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDE217E;
	Mon, 13 May 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ep8gjuRL"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248C1B812
	for <linux-api@vger.kernel.org>; Mon, 13 May 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619813; cv=none; b=C1U1+GHwfduaJvh0fyeF1Ecfehm11gq14V06sXIOQKsZzCsxwdYI/XNSWPHDxnQlHqzb/3UQ8kF1cXx4i2k2cj+5OOjlF/Vc5lOWQ8CVne/pqUORywb2n5JgcAkEto5wBEyTKL5mokvSPbJRi/zulgHadWXdRemADYqnLCUkqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619813; c=relaxed/simple;
	bh=264xfPQhqEaDYgR3vlLkTy6+mnzgDvzU7XOtbtYQD2c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:
	 References; b=A7QvWGmWTEiZFo7bNlPjA37SOfXdAMcv6p1FoyaXOY1vnUGP0RdcEJbTJQjN6d7moXmYznoGKXSt0+cIDVlMsHaD/zbt3g7FELQIEnDgG0voMYNabfiTe3XaGzDzmU9iQ9mUbqyBeb8WEfbpGHmLrsapQmcZMT6oPweNmE/dquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ep8gjuRL; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715619804; bh=0RjjGJ9qBfBFLhQpYyzG5//Y/ea7w9QbM84KCn9DrFQ=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=ep8gjuRLtlbguSCBGAITPlZ9jZUPb2tGD5QiffxDzPboE/Oqq90nuk7Aw//61Aw6H4EQGdHI5FlNjoh7zimhBn8AhsPZ6zk4nN9fyXt0+mDTDeuvKFBaSkGUkHHSA8aiembG3Wr7SjJnLgwi4w6bnkQR/Fx22cCVGrp+GfBDTopOlssVIIpWu+NTXss9W/KJuwifQyHfC56NBHKkEW4VttXRd9pMDp24Z92goSMrrWKSmwhlWh8g7i2x5cFuXT1lD79r/GQN7mfO+78R1vd5BhUSUc16avEaOSHvuUfCMkZTlrly40ZDixeBNToZ1PUG/ZVaRKaEAVCwtfKTpVcOgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715619804; bh=azMPhVYMytBUkB+apgGzZ1/5CqS4er7YqwE6XS/WVOj=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=Zybgeh6tVoxULA8Llu/I3FKen+CpwmM65u4khw8c7XabwWvQZEKqLWH5x3CesbfrMRfAHL2QtIyZVhOkULVj9DltZtpSliYv6+watuf6xIh5tqE+4tcIY6JfRXqjSs9a9EdtkYMThRF+rka4fGW7+3ZcaxC3sF4L5eHv/x9+80uxWnl7oXs2mgznZsGOH23vOxYKrHNpJpt/veH7B2EDASFsl4j+1BM86nJU6/2gTZNHUXqmoqC/gpRJYAFp/r1WhYiYrBNNJAQnrDN+kbkQthS0QX4/AGWHZ4HCo1nJSBRd1jjdgdQEsZQdlAbaC9FBZ7/PHM0hZO2mjSFB5NHcrg==
X-YMail-OSG: zuNt6q8VM1l0_BhXtl1RS9rl.HbOUkXz77QF2kiJfebNPiT39t98jU9lIiq5MX7
 wgcndv2WSJTK0vppJFMvxolkosaUDNq_RTnRvQZeZkfnq_MaU.y6MUyYEwa9tQ.FsWpYzhDwt06F
 wDP6Ubn7IqP7tzHbgE7JcpDJgC1SLe2ePo3FFZEzn3gsOSDON.Qezb3xhHCYifnWwHdvEshSacwN
 jNLaJbCrM.NCus1ji7LXqG2zcMA7kNj3uTMSXgGmMATiV9dfawgFvq36fWeDPOoSUGmx10fbb.7r
 Vy60QIrVWlk2OVSfhBf65dZTrEhqdHmg_u8HqqZNnYLAcK1UEobgc9wZOZaFTctwT46yBcHnjHfG
 Et9wQcXUtTlaFEnahRcJl1ZskUa7tJLbWjTRV_XAhuxLzbZJoHe42fnUPmE7bufoUTZ_dUjcfo0X
 IZEt84caRs5dvMKYbyAAv3XUyhTdcVLcJww2DzHkzk9JV2Xu090TfrfxLPorfuMpvMvU08cMCud9
 fMsRkkAoiMyUbzKcHAFhqFmmfZLk3BSiz28aAkrkKfhZAlFvktm8.bGvilMiAsZPBzIBoWueWftA
 J7HOSpLbD8oFam8369ntd38oA465Xc_oJ4X.W35chdn.qQoRSbDZvxQhs0D2JoquHVSPGOxS5tjP
 DXESattY61.kXJpqfqoosX9R3YLuEVLMRgkzl_eryhTyICSrFYEzQUH9_7EhXXGLASk.BCXf0mkv
 w_JoQmoFx1optnRlXT89nFYZvgdCghdUU21DiyUoJwhA5_uNOY0j7rnlZoajxaYqlwxdk_Vq_aSD
 _Lnehtau_HSyyH9BYJLIiB8UEwzQEzSDd6KtMK8v7Bj3Gs.Rj9MdHF4CJrU3QoSsnY8z8t7l83fk
 KfZwavQSXRUE2gEp870hdBKy3f5_IU3SPVxKcX9BOrWNHQFzA5redJWuVotZ7qZUDjBmgT6V_SOv
 ayKfU_aZcNWyZLFFyVppz09fEGt3yarwSNy0P0Jmu6kGZVE9IcrpC7mVzITYJ5QpLon0lk.2Ux6_
 JcmADIZrUV_CPiRJCm8i3Vt6c9rOPxbDC5RT_RenWf5IJiKhY3Ucb6dBgznzKuuTxLaZmHVeEsLs
 WNCMvjb84avWRjT61GRi2FlM_HLXwDXLENSwqbpkWSkkiufXr_Grtu37c0s3GS0xjixSfNE32XAR
 VKkAVDxQQWPbt.2StFLg0bbfRKsWiU8gEQg51wUlfjs.KxBdtic8pwlycfbTSMTFp_oNkjYX2ZZ6
 hjzOcVdhtbjDbCdgA4pJbR1N3.UyaOyOEzbhXb76GwzXDQ.MH9y2RhEkgKWxzcHuYBlKaVWlpOuS
 K3zuxxjfpOiQfnVv7YutXUfaxD7tIp4.jRBKvwi7NPQdN7SQ09dlIICUTSsnRdKOeTio3RVikPgY
 sJNoZjh3Zi2jYkUry95g428hKArck2By3uoTMGJlKaWJi1Q2A8.DR09DXC7yLugmgCajziaTVBOu
 atgI5WEucYLgfl4WdEr7GOMdbws1UHMq8mStj.7PVG_I93u.fFf7lz7CbQiJIUg7fi0oQuqvgdCu
 MIBlf2SmiG19gthjUvRSYT.e6_jSzV.WQlD8.QVlS16kJSyQ5ziTZ_YzWoT99Y8j8kTKBD3e8uO9
 en5ONW5ncLXWaMm2YLkLf3tnjwAemOhpcwF8AMY056RYUKaym4OhfYcxJfFGsbLhSpJbAsGpJz0a
 1IIVVYjV1faL_EAq.cW2MppG74uYdju7q0st7RuT0EKLV2f3p6wP2.PuCtmNevrxknlW7rycsA_F
 iE9vabeShz7sxpX9MIyiZMRXGc3f_lWXiT3BJ09R3Na8l7ZR3DQ9Mm7q.YIPb2RJqF1pbWkoImtx
 OCE5y5OLsSFhwEjqOGekHt8rCU_WW96fv4WYx6d67wTHGKQz_DGaBlPBd33tOimL0dcoLn3er349
 Y9VPb_pncWbHmAk.Woi7aECzXn0x1fXrYFd4GWaT4Y0tQUFJNA2OfyqHsbhlNIsLPASDJvx.c9C7
 eD6Tfjtp7Hv34cGJz.QDlCXuuxLfwx0u5mbJb2alnw8EArq8nTbM_xePCHf2Bdg3jAMmDn1tamNq
 9CaJPHzFuInDoeK.c1izpR2sw_Rsj8kDQaJJ6c45KIFhjVNo3Vk7ry3l2vJmiYPE8AA_slNc6pHr
 GnI_76RLamtmY2SwgreI7WwcnkjC6jrCrGqF6085NfdlRcnzQLQM0CDpoVqexy4uT8bVz6E6JNI6
 Dy1yZsokvExm2tl5y_fdj3mLKaXXLFRFVB6b5mrK8ZtisBHPRwDqACK3D9guyuN5tQ9gS_ukPFZA
 B
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b38e5669-04b5-4ba7-b399-a2f92cbae551
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 May 2024 17:03:24 +0000
Received: by hermes--production-gq1-59c575df44-2njcf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cad3b826ef9d8e34576611626bd7335b;
          Mon, 13 May 2024 17:03:18 +0000 (UTC)
Message-ID: <763db426-6f60-4d36-b3f9-b316008889f7@schaufler-ca.com>
Date: Mon, 13 May 2024 10:03:16 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [RFC PATCH] LSM, net: Add SO_PEERCONTEXT for peer LSM data
To: LSM List <linux-security-module@vger.kernel.org>, netdev@vger.kernel.org,
 linux-api@vger.kernel.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <763db426-6f60-4d36-b3f9-b316008889f7.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22321 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

We recently introduced system calls to access process attributes that
are used by Linux Security Modules (LSM). An important aspect of these
system calls is that they provide the LSM attribute data in a format
that identifies the LSM to which the data applies. Another aspect is that
it can be used to provide multiple instances of the attribute for the
case where more than one LSM supplies the attribute.

We wish to take advantage of this format for data about network peers.
The existing mechanism, SO_PEERSEC, provides peer security data as a
text string. This is sufficient when the LSM providing the information
is known by the user of SO_PEERSEC, and there is only one LSM providing
the information. It fails, however, if the user does not know which
LSM is providing the information.

Discussions about extending SO_PEERSEC to accomodate either the new
format or some other encoding scheme invariably lead to the conclusion
that doing so would lead to tears. Hence, we introduce SO_PEERCONTEXT
which uses the same API data as the LSM system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  1 +
 arch/mips/include/uapi/asm/socket.h   |  1 +
 arch/parisc/include/uapi/asm/socket.h |  1 +
 arch/sparc/include/uapi/asm/socket.h  |  1 +
 include/linux/lsm_hook_defs.h         |  2 +
 include/linux/security.h              | 18 ++++++++
 include/uapi/asm-generic/socket.h     |  1 +
 net/core/sock.c                       |  4 ++
 security/apparmor/lsm.c               | 39 ++++++++++++++++
 security/security.c                   | 86 +++++++++++++++++++++++++++++++++++
 security/selinux/hooks.c              | 35 ++++++++++++++
 security/smack/smack_lsm.c            | 25 ++++++++++
 12 files changed, 214 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..e49ed0a765ce 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -139,6 +139,7 @@
 
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
+#define SO_PEERCONTEXT		78
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 60ebaed28a4c..e647f065b3c9 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -150,6 +150,7 @@
 
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
+#define SO_PEERCONTEXT		78
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index be264c2b1a11..4f48bef863bc 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -131,6 +131,7 @@
 
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
+#define SO_PEERCONTEXT		0x404C
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 682da3714686..b54c56056323 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -132,6 +132,7 @@
 
 #define SO_PASSPIDFD             0x0055
 #define SO_PEERPIDFD             0x0056
+#define SO_PEERCONTEXT           0x0057
 
 #if !defined(__KERNEL__)
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 27e6384ec779..d923acb40c20 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -336,6 +336,8 @@ LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
 LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
 	 sockptr_t optval, sockptr_t optlen, unsigned int len)
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeerctx_stream, struct socket *sock,
+	 sockptr_t optval, sockptr_t optlen, unsigned int len)
 LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
 	 struct sk_buff *skb, u32 *secid)
 LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
diff --git a/include/linux/security.h b/include/linux/security.h
index a54543ded9fc..d4f449b7deea 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -563,6 +563,8 @@ int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 int security_locked_down(enum lockdown_reason what);
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
+int lsm_fill_socket_ctx(sockptr_t optval, sockptr_t optlen, void *val,
+			size_t val_len, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1552,6 +1554,12 @@ static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,
 {
 	return -EOPNOTSUPP;
 }
+static inline int lsm_fill_socket_ctx(sockptr_t optval, sockptr_t optlen,
+				      void *val, size_t val_len, u64 id,
+				      u64 flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
@@ -1599,6 +1607,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len);
+int security_socket_getpeerctx_stream(struct socket *sock, sockptr_t optval,
+				      sockptr_t optlen, unsigned int len);
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
@@ -1744,6 +1754,14 @@ static inline int security_socket_getpeersec_stream(struct socket *sock,
 	return -ENOPROTOOPT;
 }
 
+static inline int security_socket_getpeerctx_stream(struct socket *sock,
+						    sockptr_t optval,
+						    sockptr_t optlen,
+						    unsigned int len)
+{
+	return -ENOPROTOOPT;
+}
+
 static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
 	return -ENOPROTOOPT;
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8ce8a39a1e5f..e0166ff53670 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -134,6 +134,7 @@
 
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
+#define SO_PEERCONTEXT		78
 
 #if !defined(__KERNEL__)
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 0963689a5950..251346eccfa5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1849,6 +1849,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		return security_socket_getpeersec_stream(sock,
 							 optval, optlen, len);
 
+	case SO_PEERCONTEXT:
+		return security_socket_getpeerctx_stream(sock,
+							 optval, optlen, len);
+
 	case SO_MARK:
 		v.val = READ_ONCE(sk->sk_mark);
 		break;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c478493f3eaf..66d4ecd6afcb 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1357,6 +1357,43 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	return error;
 }
 
+/**
+ * apparmor_socket_getpeerctx_stream - get security context of peer
+ * @sock: socket that we are trying to get the peer context of
+ * @optval: output - buffer to copy peer name to
+ * @optlen: output - size of copied name in @optval
+ * @len: size of @optval buffer
+ * Returns: 0 on success, -errno of failure
+ *
+ * Note: for tcp only valid if using ipsec or cipso on lan
+ */
+static int apparmor_socket_getpeerctx_stream(struct socket *sock,
+					     sockptr_t optval, sockptr_t optlen,
+					     unsigned int len)
+{
+	char *name = NULL;
+	int slen, error = 0;
+	struct aa_label *label;
+	struct aa_label *peer;
+
+	label = begin_current_label_crit_section();
+	peer = sk_peer_label(sock->sk);
+	if (IS_ERR(peer)) {
+		error = PTR_ERR(peer);
+		goto done;
+	}
+	slen = aa_label_asxprint(&name, labels_ns(label), peer,
+				 FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
+				 FLAG_HIDDEN_UNCONFINED, GFP_KERNEL);
+
+	error = lsm_fill_socket_ctx(optval, optlen, name, slen,
+				    LSM_ID_APPARMOR, 0);
+done:
+	end_current_label_crit_section(label);
+	kfree(name);
+	return error;
+}
+
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1466,6 +1503,8 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
+	LSM_HOOK_INIT(socket_getpeerctx_stream,
+		      apparmor_socket_getpeerctx_stream),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
diff --git a/security/security.c b/security/security.c
index e387614cb054..fd4919c28e8f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -874,6 +874,64 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 	return rc;
 }
 
+/**
+ * lsm_fill_socket_ctx - Fill a socket lsm_ctx structure
+ * @optval: a socket LSM context to be filled
+ * @optlen: uctx size
+ * @val: the new LSM context value
+ * @val_len: the size of the new LSM context value
+ * @id: LSM id
+ * @flags: LSM defined flags
+ *
+ * Fill all of the fields in a lsm_ctx structure.  If @optval is NULL
+ * simply calculate the required size to output via @optlen and return
+ * success.
+ *
+ * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
+ * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
+ */
+int lsm_fill_socket_ctx(sockptr_t optval, sockptr_t optlen, void *val,
+			size_t val_len, u64 id, u64 flags)
+{
+	struct lsm_ctx *nctx = NULL;
+	unsigned int nctx_len;
+	int loptlen;
+	int rc = 0;
+
+	if (copy_from_sockptr(&loptlen, optlen, sizeof(int)))
+		return -EFAULT;
+
+	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *));
+	if (nctx_len > loptlen && !sockptr_is_null(optval))
+		rc = -E2BIG;
+
+	/* no buffer - return success/0 and set @uctx_len to the req size */
+	if (sockptr_is_null(optval) || rc)
+		goto out;
+
+	nctx = kzalloc(nctx_len, GFP_KERNEL);
+	if (!nctx) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	nctx->id = id;
+	nctx->flags = flags;
+	nctx->len = nctx_len;
+	nctx->ctx_len = val_len;
+	memcpy(nctx->ctx, val, val_len);
+
+	if (copy_to_sockptr(optval, nctx, nctx_len))
+		rc = -EFAULT;
+
+	kfree(nctx);
+out:
+	if (copy_to_sockptr(optlen, &nctx_len, sizeof(int)))
+		rc = -EFAULT;
+
+	return rc;
+}
+
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
@@ -4743,6 +4801,34 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 	return LSM_RET_DEFAULT(socket_getpeersec_stream);
 }
 
+/**
+ * security_socket_getpeerctx_stream() - Get the remote peer label
+ * @sock: socket
+ * @optval: destination buffer
+ * @optlen: size of peer label copied into the buffer
+ * @len: maximum size of the destination buffer
+ *
+ * This hook allows the security module to provide peer socket security state
+ * for unix or connected tcp sockets to userspace via getsockopt
+ * SO_GETPEERCONTEXT.  For tcp sockets this can be meaningful if the socket
+ * is associated with an ipsec SA.
+ *
+ * Return: Returns 0 if all is well, otherwise, typical getsockopt return
+ *         values.
+ */
+int security_socket_getpeerctx_stream(struct socket *sock, sockptr_t optval,
+				      sockptr_t optlen, unsigned int len)
+{
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeerctx_stream,
+			     list)
+		return hp->hook.socket_getpeerctx_stream(sock, optval, optlen,
+							 len);
+
+	return LSM_RET_DEFAULT(socket_getpeerctx_stream);
+}
+
 /**
  * security_socket_getpeersec_dgram() - Get the remote peer label
  * @sock: socket
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 83d30579e568..3c34cbc2b197 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5221,6 +5221,39 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	return err;
 }
 
+static int selinux_socket_getpeerctx_stream(struct socket *sock,
+					    sockptr_t optval, sockptr_t optlen,
+					    unsigned int len)
+{
+	int err = 0;
+	char *scontext = NULL;
+	u32 scontext_len;
+	struct sk_security_struct *sksec = selinux_sock(sock->sk);
+	u32 peer_sid = SECSID_NULL;
+
+	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
+	    sksec->sclass == SECCLASS_TCP_SOCKET ||
+	    sksec->sclass == SECCLASS_SCTP_SOCKET)
+		peer_sid = sksec->peer_sid;
+	if (peer_sid == SECSID_NULL)
+		return -ENOPROTOOPT;
+
+	err = security_sid_to_context(peer_sid, &scontext,
+				      &scontext_len);
+	if (err)
+		return err;
+	if (scontext_len > len) {
+		err = -ERANGE;
+		goto out_len;
+	}
+
+	err = lsm_fill_socket_ctx(optval, optlen, scontext, scontext_len,
+				  LSM_ID_SELINUX, 0);
+out_len:
+	kfree(scontext);
+	return err;
+}
+
 static int selinux_socket_getpeersec_dgram(struct socket *sock,
 					   struct sk_buff *skb, u32 *secid)
 {
@@ -7345,6 +7378,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_sock_rcv_skb, selinux_socket_sock_rcv_skb),
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 			selinux_socket_getpeersec_stream),
+	LSM_HOOK_INIT(socket_getpeerctx_stream,
+			selinux_socket_getpeerctx_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
 	LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3380a9e91fb8..dd0ea4da7eeb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4297,6 +4297,30 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	return rc;
 }
 
+/**
+ * smack_socket_getpeerctx_stream - pull in packet label
+ * @sock: the socket
+ * @optval: user's destination
+ * @optlen: size thereof
+ * @len: max thereof
+ *
+ * returns zero on success, an error code otherwise
+ */
+static int smack_socket_getpeerctx_stream(struct socket *sock,
+					  sockptr_t optval, sockptr_t optlen,
+					  unsigned int len)
+{
+	struct socket_smack *ssp;
+	size_t slen;
+	char *rcp = "";
+
+	ssp = smack_sock(sock->sk);
+	if (ssp->smk_packet)
+		rcp = ssp->smk_packet->smk_known;
+	slen = strlen(rcp) + 1;
+
+	return lsm_fill_socket_ctx(optval, optlen, rcp, slen, LSM_ID_SMACK, 0);
+}
 
 /**
  * smack_socket_getpeersec_dgram - pull in packet label
@@ -5206,6 +5230,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(socket_sendmsg, smack_socket_sendmsg),
 	LSM_HOOK_INIT(socket_sock_rcv_skb, smack_socket_sock_rcv_skb),
 	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
+	LSM_HOOK_INIT(socket_getpeerctx_stream, smack_socket_getpeerctx_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
 #ifdef SMACK_IPV6_PORT_LABELING


