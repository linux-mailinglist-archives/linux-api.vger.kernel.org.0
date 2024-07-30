Return-Path: <linux-api+bounces-2047-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD9940FE1
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2024 12:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717A2282BC6
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2024 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9D2C1AC;
	Tue, 30 Jul 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFuFjz2G"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2840BF2;
	Tue, 30 Jul 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336511; cv=none; b=aCLAB8+UCHiftsd727/I2E0fIJsJAnMsqdHMFltqTM3GEBYL6X0XQsvxvE+CoFRcWofip1N4gsQYM6pjGAFXqyOKBffL0nR413cwWL4nevnnY5GsJARszhJPmADnchtNMeSZwKlsoxyku2dYtRnc8NWe/kuq9wdBI6uztbUTT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336511; c=relaxed/simple;
	bh=TNPhXVdWWdqvH471+ffDEFdJZliP2Pp3+F2lO3R1SGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ObqkRrmduhXSL2ma0eJqalhw+AAV5GXexya6CUdlpBoH4WQrkbIIwAc2wY3SQTJnushOXyLV+ORt7ke7qKv3jqHi9EinVwUiWEJW45vU17Y7l6rDKIxkLD03+8k4fRjKnjtdMugJPQitMem1RfTcbk6wP0flqlmQ4ydZL6HVKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFuFjz2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D7D2C4AF0B;
	Tue, 30 Jul 2024 10:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722336510;
	bh=TNPhXVdWWdqvH471+ffDEFdJZliP2Pp3+F2lO3R1SGI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=aFuFjz2GaN8sUsnidakjyXsL+p634vYfB1KO/bBG0VnjwBLmP3dDIP0YHDRFvENSi
	 5Z1zzU1FAy2D03//UTeo9FcYErzTndAQfi6POprGZxs0K6gHXWabBaRCuoQa0F9miP
	 nbDdN20we0noVqVwc3hVBhPN2H/X1025i7abZX16PqtnfmQ2yDvWisKC13alrQFBs/
	 pVneUZkymjrR/iWxEmAuSt6hLvmdQl43s5pLIBEF9E0mGySiNL8QLU5OD1DGUEeryz
	 3AvEa1zaFEi3lxhC8q5iInyD1LFISW2R/UCXZxosMxSG7rS4xNARKbj/MNUA3GBcRv
	 9OBM39f1nMJEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FFFC3DA49;
	Tue, 30 Jul 2024 10:48:30 +0000 (UTC)
From: Andy Pan via B4 Relay <devnull+i.andypan.me@kernel.org>
Date: Tue, 30 Jul 2024 10:48:28 +0000
Subject: [PATCH v3] epoll.7: clarify the event distribution under
 edge-triggered mode
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
X-B4-Tracking: v=1; b=H4sIAPvEqGYC/32MSw7CIBQAr9K8tc9Q+kFceQ/jAuirJanQQENsm
 t5d2p0LXc4kMytECpYiXIsVAiUbrXcZqlMBZlDuSWi7zMAZr5ngAmny44g0Y0fRIKtJSdVI1lc
 acjMF6u37+N0fmQcbZx+WY5/K3f46pRJLrCTTqjetuGh5U65bJuXOL4J9lfjfnOfcSKm5Mm0rR
 POVb9v2AdDXc27qAAAA
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 Andy Pan <i@andypan.me>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722336509; l=3564;
 i=i@andypan.me; s=20240727; h=from:subject:message-id;
 bh=RQ2G1MWF+Gce8miWZC1rmQyR2rofTn4FwXJoagbinhk=;
 b=swfU9iV51ich7eMK66hfsEHo6jTqtAOYccC34+zFbEX32wWNIDxb8a41Lyk4wE3/3FDsEoAQ7
 t8oKClRhScuBOgkhMZNlbZKXpJ1YSSbTEdvkPam/GfAPbPV6VY/wj6w
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
Changes in v3:
- Updated the git commit description
- Link to v2: https://lore.kernel.org/r/20240727-epoll-et-desc-v2-1-c99b2ac66775@andypan.me

Changes in v2:
- Added the git commit description based on feedback
- Link to v1: https://lore.kernel.org/r/20240727-epoll-et-desc-v1-1-390bafc678b9@andypan.me
---
 man/man7/epoll.7 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/man/man7/epoll.7 b/man/man7/epoll.7
index 951500131..361d9db99 100644
--- a/man/man7/epoll.7
+++ b/man/man7/epoll.7
@@ -172,6 +172,7 @@ .SS Level-triggered and edge-triggered
 Since even with edge-triggered
 .BR epoll ,
 multiple events can be generated upon receipt of multiple chunks of data,
+that is, an event will be generated upon each receipt of a chunk of data,
 the caller has the option to specify the
 .B EPOLLONESHOT
 flag, to tell

---
base-commit: cbc0a111e4dceea2037c51098de33e6bc8c16a5c
change-id: 20240727-epoll-et-desc-04ea9a590f3b

Best regards,
-- 
Andy Pan <i@andypan.me>



