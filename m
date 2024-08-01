Return-Path: <linux-api+bounces-2083-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A208944A83
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 13:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C182E1F23365
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2D18EFE0;
	Thu,  1 Aug 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYttf/Vh"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497C18E051;
	Thu,  1 Aug 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512319; cv=none; b=Onk20I9tpxHaFA+VsdWiBabgqP9TvdVYeB6eCldUpQ9AUzLORPB5QrTb53UH7FI/QQFqdy/EQ1aZqY0q6OVBissa/Z6X9/N0l+jpl2VdTX9z+w3/RI4D7iJZDlFjNnYV6tvUltcV2XMBxgdnLHwnWQbWuMLbMz95uv1YfL9gKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512319; c=relaxed/simple;
	bh=1SNNIWjIPN0Ph6PhE9lbIySQ1K/EEKSmmgNERjxwNJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eVDQI5jHbPIKcYwB+Y/hf0H7B+g/jF6/kh6mtDvdTldapc/RC+b0mN2IsVfrnIl9ze50ML2B3ONZqAQVfz4PZ78OYHlwMH8O4DvA2Gozx/6FaDdkq1Z8Cu+CYQ2c6+VoHLptpagNRruYGaZo3Eb/ypDLRbIRuX3hi3uEFNr3yqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYttf/Vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3499C32786;
	Thu,  1 Aug 2024 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722512319;
	bh=1SNNIWjIPN0Ph6PhE9lbIySQ1K/EEKSmmgNERjxwNJo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MYttf/Vh6sS+tSpGpV4RtaZqEAKAN+7vTVRe/UDZFCDPFtcQdf/pUeg2cDZByF6Zm
	 zIZKdgLPK7SUK7W1NzT8GDnHmVuvOgQKWbP+M8pHXo+2SBYbM6ORzW0y6FrPFZ0u3X
	 RAybL2Xta5E8guaMPpdPU5upB4iE2GkLtBDT5131wPVp3cK/gliYsZV2JtNF8Pu0L7
	 qlYnXhWzn8IcqYfXjepFJH8IvmEEAXjTrswGZpebnmMNAfoGEGwU6AF91lvWXqa1PE
	 puV/gaGhtLYGpXT2CjOF6M3SlqpRqr6Zbm1xP40AMXFexPR/tJ2dGj6Kh+keOZyopV
	 0iKH1vjxbOR9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B5C3DA64;
	Thu,  1 Aug 2024 11:38:38 +0000 (UTC)
From: Andy Pan via B4 Relay <devnull+i.andypan.me@kernel.org>
Date: Thu, 01 Aug 2024 11:38:38 +0000
Subject: [PATCH v5] epoll.7: clarify the event distribution under
 edge-triggered mode
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
X-B4-Tracking: v=1; b=H4sIAL1zq2YC/33MSwrCMBSF4a1IxkbyatI4ch/i4Ca51YC2JSnBI
 t270ZFUdHgOfP+DZEwRM9lvHiRhiTkOfR3NdkP8Bfoz0hjqJoIJxYwwFMfheqU40YDZU6YQLDS
 WddKRasaEXby/e8dT3ZeYpyHN73zhr/dXqXDKqbTMQee1aZ09QB/mEfrdDckrVcRfLir31joBX
 mtjmi8uP7hkay4r1wAtd9wrxsIXV5+cr7mq3KBruXUh4Iovy/IETQ0URGgBAAA=
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 "mtk.manpages" <mtk.manpages@gmail.com>, Andy Pan <panjf2000@gmail.com>, 
 Andy Pan <i@andypan.me>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722512318; l=4107;
 i=i@andypan.me; s=20240727; h=from:subject:message-id;
 bh=MQ5HY+djEcOUkyc3//Gy9QeWdH92Y0lvTNWhhNdHpuM=;
 b=bj8+L7WKxSWuGv0Td3rKfSutq1+e1Pg+EkFv4fGFVYs/P3dm/NNq/+PjPsKZ6MB2pxflIN5fN
 Xd3QbqMkE1gA6PNHNj5j8BB17ADGVusWEEDL1zQR8qCNvCRCvZ7sUJe
X-Developer-Key: i=i@andypan.me; a=ed25519;
 pk=ZLGY5dzAGPy8bpSKbl9Jfyp/Ud0eac0BY5cKedQXMcw=
X-Endpoint-Received: by B4 Relay for i@andypan.me/20240727 with auth_id=190
X-Original-From: Andy Pan <i@andypan.me>
Reply-To: i@andypan.me

From: Andy Pan <i@andypan.me>

For the moment, the edge-triggered epoll generates an event for each
receipt of a chunk of data, that is to say, epoll_wait() will return
and tell us a monitored file descriptor is ready whenever there is a
new activity on that FD since we were last informed about that FD.
This is not a real _edge_ implementation for epoll, but it's been
working this way for years and plenty of projects are relying on it
to eliminate the overhead of one system call of read(2) per wakeup event.

There are several renowned open-source projects relying on this feature
for notification function (with eventfd): register eventfd with EPOLLET
and avoid calling read(2) on the eventfd when there is wakeup event (eventfd being written).
Examples: nginx [1], netty [2], tokio [3], libevent [4], ect. [5]
These projects are widely used in today's Internet infrastructures.
Thus, changing this behavior of epoll ET will fundamentally break them
and cause a significant negative impact.
Linux has changed it for pipe before [6], breaking some Android libraries,
which had got "reverted" somehow. [7] [8]

Nevertheless, the paragraph in the manual pages describing this
characteristic of epoll ET seems ambiguous, I think a more explict
sentence should be used to clarify it. We're improving the notification
mechanism for libuv recently by exploiting this feature with eventfd,
which brings us a significant performance boost. [9]

Therefore, we (as well as the maintainers of nginx, netty, tokio, etc.)
would have a sense of security to build an enhanced notification function
based on this feature if there is a guarantee of retaining this implementation
of epoll ET for the backward compatibility in the man pages.

[1]: https://github.com/nginx/nginx/blob/efc6a217b92985a1ee211b6bb7337cd2f62deb90/src/event/modules/ngx_epoll_module.c#L386-L457
[2]: https://github.com/netty/netty/pull/9192
[3]: https://github.com/tokio-rs/mio/blob/309daae21ecb1d46203a7dbc0cf4c80310240cba/src/sys/unix/waker.rs#L111-L143
[4]: https://github.com/libevent/libevent/blob/525f5d0a14c9c103be750f2ca175328c25505ea4/event.c#L2597-L2614
[5]: https://github.com/libuv/libuv/pull/4400#issuecomment-2123798748
[6]: https://lkml.iu.edu/hypermail/linux/kernel/2010.1/04363.html
[7]: https://github.com/torvalds/linux/commit/3a34b13a88caeb2800ab44a4918f230041b37dd9
[8]: https://github.com/torvalds/linux/commit/3b844826b6c6affa80755254da322b017358a2f4
[9]: https://github.com/libuv/libuv/pull/4400#issuecomment-2103232402

Signed-off-by: Andy Pan <i@andypan.me>
---
Changes in v5:
- Update the sentence of clarifying the epoll ET
- Link to v4: https://lore.kernel.org/r/20240731-epoll-et-desc-v4-1-7eb819bdde0d@andypan.me

Changes in v4:
- Move the added sentence elsewhere to make more sense
- Link to v3: https://lore.kernel.org/r/20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me

Changes in v3:
- Updated the git commit description
- Link to v2: https://lore.kernel.org/r/20240727-epoll-et-desc-v2-1-c99b2ac66775@andypan.me

Changes in v2:
- Added the git commit description based on feedback
- Link to v1: https://lore.kernel.org/r/20240727-epoll-et-desc-v1-1-390bafc678b9@andypan.me
---
 man/man7/epoll.7 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man/man7/epoll.7 b/man/man7/epoll.7
index 951500131..86e5f8363 100644
--- a/man/man7/epoll.7
+++ b/man/man7/epoll.7
@@ -121,7 +121,8 @@ .SS Level-triggered and edge-triggered
 meanwhile the remote peer might be expecting a response based on the
 data it already sent.
 The reason for this is that edge-triggered mode
-delivers events only when changes occur on the monitored file descriptor.
+delivers events only when changes occur on the monitored file descriptor,
+that is, an event will be generated upon each receipt of a chunk of data.
 So, in step
 .B 5
 the caller might end up waiting for some data that is already present inside

---
base-commit: cbc0a111e4dceea2037c51098de33e6bc8c16a5c
change-id: 20240727-epoll-et-desc-04ea9a590f3b

Best regards,
-- 
Andy Pan <i@andypan.me>



