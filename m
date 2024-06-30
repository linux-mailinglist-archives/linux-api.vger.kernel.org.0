Return-Path: <linux-api+bounces-1809-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD591D42C
	for <lists+linux-api@lfdr.de>; Sun, 30 Jun 2024 23:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25586B20BEC
	for <lists+linux-api@lfdr.de>; Sun, 30 Jun 2024 21:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20547F60;
	Sun, 30 Jun 2024 21:36:31 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E53EA9B;
	Sun, 30 Jun 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783391; cv=none; b=HqmYE3oUvpXwsrbmF93sHg8JUH94ouqio01hFTgt4fj4kJTrls5kUDwUtiHWgTaBu7+JipusgM7QX8bPXomdR4OQeJtCd2jyZ3ePR3r9sMNpeywRN9IVrYD8Krc1aP3R9yLvxOUK46SupOn4WJSaI7VKdoNK2HuFPJUgKzi7hYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783391; c=relaxed/simple;
	bh=ia4RVuCgBczpk1ifE6xgRj55S+Jnfhj9ts2Uhz9veW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eCkGMPem/LFW5SHVWJBIWUw6m51lXnNuSPcZr189ZWdmgN2BfxIylAXA1YosFoP4agva3LbAyhAKMijqkE1Q2l9wF0V2ycwrmm228kvEwswycpfrC2BmFuZceDu5kKunZ2rCFqTJoTdh8mvzLz+iFeniX3IpanDm7hTcm1X5ECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id BD3FC72C8CC;
	Mon,  1 Jul 2024 00:36:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id AB61B7CCB3A; Mon,  1 Jul 2024 00:36:26 +0300 (IDT)
Date: Sun, 30 Jun 2024 21:36:26 +0000
From: "Dmitry V. Levin" <ldv@strace.io>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>,
	David Hildenbrand <david@redhat.com>, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: change TRACE_MMAP_IOCTL_GET_READER to avoid collision
 with TCGETS
Message-ID: <20240630213626.GA23566@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The number that was initially chosen for TRACE_MMAP_IOCTL_GET_READER,
unfortunately, collides with TCGETS on most of architectures.

For example, this is how strace output would look like when
support for this value of TRACE_MMAP_IOCTL_GET_READER is added:

$ strace -e ioctl stty
ioctl(0, TCGETS or TRACE_MMAP_IOCTL_GET_READER, {c_iflag=ICRNL|IXON, c_oflag=NL0|CR0|TAB0|BS0|VT0|FF0|OPOST|ONLCR,
+c_cflag=B38400|CS8|CREAD, c_lflag=ISIG|ICANON|ECHO|ECHOE|ECHOK|IEXTEN|ECHOCTL|ECHOKE, ...}) = 0

Even though ioctl numbers are inherently not unique, TCGETS
is a very traditional one, so let's change the value of
TRACE_MMAP_IOCTL_GET_READER a bit to avoid this collision.

Given that _IO('T', 0x1) is _IOC(_IOC_NONE, 'T', 0x1, 0),
something like _IOC(_IOC_NONE, 'T', 0x1, 0x1) should be OK.

Fixes: cf9f0f7c4c5bb ("tracing: Allow user-space mapping of the ring-buffer")
Signed-off-by: Dmitry V. Levin <ldv@strace.io>
---
 include/uapi/linux/trace_mmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index bd1066754220..cb858f1b8367 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,6 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
-#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+#define TRACE_MMAP_IOCTL_GET_READER		_IOC(_IOC_NONE, 'T', 0x1, 0x1)
 
 #endif /* _TRACE_MMAP_H_ */
-- 
ldv

