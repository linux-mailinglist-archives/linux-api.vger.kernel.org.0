Return-Path: <linux-api+bounces-1821-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2ED92422A
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 17:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B1D1F25F96
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F51BBBC6;
	Tue,  2 Jul 2024 15:18:11 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9051BA883;
	Tue,  2 Jul 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933491; cv=none; b=uua3549IAefJUoFHKAaTsT9N+Yc/Tk09g8QfFKi4+WE4byBhDjjZ2nN6/4eRgXAzBCwa0jcnpu37HC/ZpIgADNBk+sciOWWo+0g2OpOQO5Hga2JQxS5b5+wffQQ1YEiY27UCFaOUtCrojlSVPYbRq04CqUymTR28j4m99Lt9YDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933491; c=relaxed/simple;
	bh=4+6bb590DiNQ9QG+pwIJYPGpZqN7VtIX8tkAx55gPe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LktNupwGCbF5HRp4cXrBmnWH4o8pKpdDmk7fHOzAWKfSx5Yl2MMbLxv0ulREmv6IZQgws6Uyw6/7fkgZhqRJGaxmC9P9fmKE5WW2uTrcldxlAI7JDGbACcvF9TquBjWTLF4eX7npThwgLV4w0bz0sP/iCRo5oqfGdviKwfepFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADA0C116B1;
	Tue,  2 Jul 2024 15:18:09 +0000 (UTC)
Date: Tue, 2 Jul 2024 11:18:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, Vincent Donnefort
 <vdonnefort@google.com>, mhiramat@kernel.org, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, david@redhat.com,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240702111807.13d2dd2c@rorschach.local.home>
In-Reply-To: <9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
References: <20240510140435.3550353-1-vdonnefort@google.com>
	<20240510140435.3550353-4-vdonnefort@google.com>
	<20240630105322.GA17573@altlinux.org>
	<20240630084053.0b506916@rorschach.local.home>
	<9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 10:36:03 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > I can send a patch this week to update it. Or feel free to send a patch
> > yourself.  
> 
> You need to reserve an unused ioctl Code and Seq# range within:
> 
> Documentation/userspace-api/ioctl/ioctl-number.rst

Ug, it's been so long, I completely forgot about that file.

Thanks for catching this.

> 
> Otherwise this duplicate will confuse all system call instrumentation
> tooling.

Agreed, what if we did this then:

-- Steve

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d..9a97030c6c8d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -186,6 +186,7 @@ Code  Seq#    Include File                                           Comments
 'Q'   all    linux/soundcard.h
 'R'   00-1F  linux/random.h                                          conflict!
 'R'   01     linux/rfkill.h                                          conflict!
+'R'   20-2F  linux/trace_mmap.h
 'R'   C0-DF  net/bluetooth/rfcomm.h
 'R'   E0     uapi/linux/fsl_mc.h
 'S'   all    linux/cdrom.h                                           conflict!
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index bd1066754220..c102ef35d11e 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,6 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
-#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('R', 0x20)
 
 #endif /* _TRACE_MMAP_H_ */

