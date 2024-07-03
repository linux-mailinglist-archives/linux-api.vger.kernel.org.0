Return-Path: <linux-api+bounces-1835-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9911F926B8A
	for <lists+linux-api@lfdr.de>; Thu,  4 Jul 2024 00:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0EC1C2173C
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 22:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FADC18E779;
	Wed,  3 Jul 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iYeJHUmc"
X-Original-To: linux-api@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B13136643;
	Wed,  3 Jul 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045612; cv=none; b=axtVdd4ySRD8+4d7E4hJLSnfZsmmtlTkSimtIDpP1C9PvyuRXXq2Q67HB4LbTBTta8S24I4Zm5I9C4U1Qs26rMUBf+3ON16Qt6wCrYyasoNzL7M99Yp7oiqDFO7N2hGf8Yt8L8R8smbuUUGZG6WBHTfEA7KKIbZnqjRfhmK1PuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045612; c=relaxed/simple;
	bh=oypge0eDe1k0diy+whdltG9WV8gATeebYZ5wxQnvQxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bclmlOh3AywcSC3FRGztN+wK3DT61sL9WT6f2xJ7juWopunmrtYjFnwPyr4UO8mFss2/LvL4EfvBEfLeUuxZlmQFIs41yIoUXfMsoFvIuzkMqI/+/gMgdAezB/43L0I8Bh4xRW7PP/RJWYA3YksGbAcFm6ubkun4/KZYVCQ6s2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iYeJHUmc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-beaub-VBQ1L. (unknown [4.155.48.126])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6DDD520B7001;
	Wed,  3 Jul 2024 15:26:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DDD520B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720045610;
	bh=VxOS5jnbA0Lf+6v1MBAkXU6TPJciosuFNl3HvdPNn6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYeJHUmcJAvo9XetcxRm48+P4V1WJQBWYGeMQJIVJk11tNhseVXjjCOLPi+V/wKS9
	 2vKzvOZNl5UoSS+gdJvqbw/oC5yktnm71yqL+g649SzJMcjcbRkw83ATX80eeWuOxA
	 R5dXbgloSUJbwjpZKZ/+eQqNADRGrMf2hQbSngtk=
Date: Wed, 3 Jul 2024 22:26:46 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Dmitry V. Levin" <ldv@strace.io>,
	Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
	kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
	david@redhat.com, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240703222646.GA2025-beaub@linux.microsoft.com>
References: <20240510140435.3550353-1-vdonnefort@google.com>
 <20240510140435.3550353-4-vdonnefort@google.com>
 <20240630105322.GA17573@altlinux.org>
 <20240630084053.0b506916@rorschach.local.home>
 <9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
 <20240702111807.13d2dd2c@rorschach.local.home>
 <cb02f5a0-d6a3-4228-9cbb-473fd392ee48@efficios.com>
 <20240702125126.50a6267c@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702125126.50a6267c@rorschach.local.home>

On Tue, Jul 02, 2024 at 12:51:26PM -0400, Steven Rostedt wrote:
> On Tue, 2 Jul 2024 11:32:53 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > If we use '*' for user events already, perhaps we'd want to consider
> > using the same range for the ring buffer ioctls ? Arguably one is
> > about instrumentation and the other is about ring buffer interaction
> > (data transport), but those are both related to tracing.
> 
> Yeah, but I still rather keep them separate.
> 
> Beau, care to send a patch adding an entry into that ioctl document for
> user events?
> 
> -- Steve

Sure thing, sent one out [1].

Thanks,
-Beau

1. https://lore.kernel.org/linux-doc/20240703222501.1547-1-beaub@linux.microsoft.com/

