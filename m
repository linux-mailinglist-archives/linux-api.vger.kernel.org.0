Return-Path: <linux-api+bounces-1808-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65F91D1A4
	for <lists+linux-api@lfdr.de>; Sun, 30 Jun 2024 14:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B8C1C20FA3
	for <lists+linux-api@lfdr.de>; Sun, 30 Jun 2024 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237E13C689;
	Sun, 30 Jun 2024 12:40:56 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC37E572;
	Sun, 30 Jun 2024 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719751256; cv=none; b=ItngGkuSNZvHkD7llfCdsyM/Deii5bm93Vj7VU/S1YWk1I17K1MwvPZn6zEml39eTOWx5F4YzZN8k1j3D5JSRzUw9tqzg5mAw1DOPHnqaJ44wW4pOL6KboxkfRoAs433ia5pedWNa7l/e6TpTqhoUwwAiBAbF30Fv66v7f/VNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719751256; c=relaxed/simple;
	bh=XueVtoABFp4BgyvUh4hGtMOzXKjORvFjOeyUviTBzdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUGlWMrYnCXJtyDP9cIxFQG7hT6mE8UQtbxRSMrjKabeQdNbNJawT1UBTgxbNTHqXEC0XZUWZeFxo6vgU8F0D2cp5WaVqMmiY0wSRYAqyOqtufU5LHLCLFitRfUclMAtXf6knSP9bbqwwGjkAqMYKZPkMoqPAJMciTjInbG0xKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79949C2BD10;
	Sun, 30 Jun 2024 12:40:54 +0000 (UTC)
Date: Sun, 30 Jun 2024 08:40:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, david@redhat.com,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240630084053.0b506916@rorschach.local.home>
In-Reply-To: <20240630105322.GA17573@altlinux.org>
References: <20240510140435.3550353-1-vdonnefort@google.com>
	<20240510140435.3550353-4-vdonnefort@google.com>
	<20240630105322.GA17573@altlinux.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jun 2024 13:53:23 +0300
"Dmitry V. Levin" <ldv@strace.io> wrote:

> On Fri, May 10, 2024 at 03:04:32PM +0100, Vincent Donnefort wrote:
> [...]
> > diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> > index b682e9925539..bd1066754220 100644
> > --- a/include/uapi/linux/trace_mmap.h
> > +++ b/include/uapi/linux/trace_mmap.h
> > @@ -43,4 +43,6 @@ struct trace_buffer_meta {
> >  	__u64	Reserved2;
> >  };
> >  
> > +#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
> > +  
> 
> I'm sorry but among all the numbers this one was probably the least
> fortunate choice because it collides with TCGETS on most of architectures.

Hmm, that is unfortunate.

> 
> For example, this is how strace output would look like when
> TRACE_MMAP_IOCTL_GET_READER support is added:
> 
> $ strace -e ioctl stty
> ioctl(0, TCGETS or TRACE_MMAP_IOCTL_GET_READER, {c_iflag=ICRNL|IXON, c_oflag=NL0|CR0|TAB0|BS0|VT0|FF0|OPOST|ONLCR, c_cflag=B38400|CS8|CREAD, c_lflag=ISIG|ICANON|ECHO|ECHOE|ECHOK|IEXTEN|ECHOCTL|ECHOKE, ...}) = 0
> 
> Even though ioctl numbers are inherently not unique, TCGETS is
> a very traditional one, so it would be great if you could change
> TRACE_MMAP_IOCTL_GET_READER to avoid this collision.
> 
> Given that _IO('T', 0x1) is _IOC(_IOC_NONE, 'T', 0x1, 0),
> something like _IOC(_IOC_NONE, 'T', 0x1, 0x1) should be OK.

Well, it may not be too late to update this as it hasn't been
officially released in 6.10 yet. It's still only in the -rc and the
library doesn't rely on this yet (I've been holding off until 6.10 was
officially released before releasing the library that uses it).

I can send a patch this week to update it. Or feel free to send a patch
yourself.

Thanks,

-- Steve

