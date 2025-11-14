Return-Path: <linux-api+bounces-5277-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081BC5DBF4
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 16:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490D23BC994
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C232ED52;
	Fri, 14 Nov 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dzwdz.net header.i=@dzwdz.net header.b="efW28XaQ"
X-Original-To: linux-api@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8632ED27
	for <linux-api@vger.kernel.org>; Fri, 14 Nov 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132233; cv=none; b=muFFsoDBT8+UaWfWy18I4u60OeSC7ks3tfGUpm0SpAqp7s2J0jzjf7I0dQ6Yz+F54Oxbwa5raD79iy8ioILGYcbhCQF4mOyiS5q376oiPFXxaHx77vlHGVFUtvAHHGxe8yIhuh/3ubM/NhbOcdLUWGm9t3oV+bTMCArBO6c36M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132233; c=relaxed/simple;
	bh=W2Gcv0qFNa2nw3WotZuVReW5CUB2KVmI6C0Q/QkZuzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVwaWpYItM3CHQdfWaggPYDpN430d69gZm0rnOuAL6F44xXdY7pIF7fkoYj4/pNyNiBFSo4D2mMHs9+p+gMyim9WQlek8c8B/F0nxLgkzwyX8/TPYyPC27VeGRO+2wY0WX95DETpim3QL9V/ZLy+Rkibkk+JWfyA3gkDRQSqflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dzwdz.net; spf=pass smtp.mailfrom=dzwdz.net; dkim=pass (2048-bit key) header.d=dzwdz.net header.i=@dzwdz.net header.b=efW28XaQ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dzwdz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dzwdz.net
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dzwdz.net; s=key1;
	t=1763132229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfJpda/GGjCKTqmdx5tIqUG7cVkIF4M2WisIV8rj7eg=;
	b=efW28XaQn8IGCIkFrIM+a6O7ao0/VLNlpBw1wAwafzWc++KLFVtGR9qmVEMIn8jFYqNdsj
	Di9s9pACROiVBRJZuUNLu49IatpWr9Q7xuLMQbYTzJ+1qbykd6GCilY74EGKzxqH1OAwsb
	NzxsrogZuaJYE9rWgDMpQYbitA7FAtKTX4g5sAyIj/EJtRLjPw86abBBlu72rXej5oabtV
	WHUBwUQ6GUq/CazE3arVCq0JZdDwngq/Tj5ioGpDqtFx3/eHGnyRkjSj2e/4CZ8HLIhKHH
	eIRVKOtJxQwLGF/a6n0EannOwL5ij7zeDzkhhgljDPNzM/PZoo43+NULJ7LAOg==
From: =?UTF-8?q?Jakub=20G=C5=82ogowski?= <not@dzwdz.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: =?UTF-8?q?Jakub=20G=C5=82ogowski?= <not@dzwdz.net>,
	linux-man@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	ej@inai.de
Subject: [PATCH 2/2] man/man7/ip.7: Reword IP_PKTINFO's description
Date: Fri, 14 Nov 2025 15:29:31 +0100
Message-ID: <38cfae87620d99ab0fa15f1970ef18d4ab5ff5a5.1763130571.git.not@dzwdz.net>
In-Reply-To: <cover.1763130571.git.not@dzwdz.net>
References: <cover.1763130571.git.not@dzwdz.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I've heavily cut down the first paragraph (which wasn't really saying
anything), and emphasized the difference between how recvmsg(2) and
sendmsg(2) treat this struct.

"This works only for datagram oriented sockets" is redundant with
"Not supported for SOCK_STREAM", and the mention of sendmsg(2) was moved
down.

I called it a boolean option because that's how these were introduced at
the start of the section.

I've tried rewording ipi_spec_dst's effect on sendmsg to be a bit more
clear.

The only piece of new information which this adds is that you can use
the structure returned by recvmsg with sendmsg, which directly follows
from the preceding text.

RFC 3542, Section 6, directly calls out this usecase for in6_pktinfo:

> Some UDP servers want to respond to client
> requests by sending their reply out the same interface on which the
> request was received and with the source IPv6 address of the reply
> equal to the destination IPv6 address of the request.  To do this the
> application can enable just the IPV6_RECVPKTINFO socket option and
> then use the received control information from recvmsg() as the
> outgoing control information for sendmsg().  The application need not
> examine or modify the in6_pktinfo structure at all.

I'm not sure if this is the best place to document this, as the sendmsg
behavior is unrelated to the IP_PKTINFO sockopt at all.  Maybe some of
the control messages should be broken out to another manpage?

Signed-off-by: Jakub Głogowski <not@dzwdz.net>
---
 man/man7/ip.7 | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/man/man7/ip.7 b/man/man7/ip.7
index a7f118b42..aa2508bc7 100644
--- a/man/man7/ip.7
+++ b/man/man7/ip.7
@@ -783,20 +783,13 @@ .SS Socket options
 .TP
 .BR IP_PKTINFO " (since Linux 2.2)"
 .\" Precisely: since Linux 2.1.68
-Pass an
-.B IP_PKTINFO
-ancillary message that contains a
-.I pktinfo
-structure that supplies some information about the incoming packet.
-This works only for datagram oriented sockets.
-The argument is a flag that tells the socket whether the
-.B IP_PKTINFO
-message should be passed or not.
-The message itself can be sent/retrieved
-only as a control message with a packet using
+If this boolean option is enabled,
 .BR recvmsg (2)
-or
-.BR sendmsg (2).
+outputs an
+.B IP_PKTINFO
+ancillary message containing an
+.I in_pktinfo
+structure.
 .IP
 .in +4n
 .EX
@@ -809,37 +802,37 @@ .SS Socket options
 .EE
 .in
 .IP
-When returned by
-.BR recvmsg (2) ,
+In this context,
 .I ipi_ifindex
 is the unique index of the interface the packet was received on.
 .I ipi_spec_dst
 is the preferred source address for replies to the given packet, and
 .I ipi_addr
-is the destination address in the packet header.
+is the destination address from the packet header.
 These addresses are usually the same,
 but can differ for broadcast or multicast packets.
 Note that, depending on the configured routes,
 .I ipi_spec_dst
 might belong to a different interface from the one that received the packet.
 .IP
-If
-.B IP_PKTINFO
-is passed to
-.BR sendmsg (2)
-and
+This structure can also be passed as an ancillary message to
+.BR sendmsg (2) .
+In that case,
 .\" This field is grossly misnamed
 .I ipi_spec_dst
-is not zero, then it is used as the local source address, for the routing
-table lookup, and for setting up IP source route options.
-When
+is used as the local source address
+(if non-zero),
+including for the purposes of setting up IP source route options.
+It's also used for the routing table lookup, unless
 .I ipi_ifindex
-is not zero, the primary local address of the interface specified by the
-index overwrites
-.I ipi_spec_dst
-for the routing table lookup.
+is non-zero \(en
+then the primary local address of that interface is used there instead.
 .I ipi_addr
 is ignored.
+The structure returned by
+.BR recvmsg (2)
+can be reused,
+which effectively sends a reply to the original packet.
 .IP
 Not supported for
 .B SOCK_STREAM
-- 
2.47.3


