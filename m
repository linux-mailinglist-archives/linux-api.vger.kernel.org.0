Return-Path: <linux-api+bounces-1807-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC89091D14D
	for <lists+linux-api@lfdr.de>; Sun, 30 Jun 2024 12:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F3D28236E
	for <lists+linux-api@lfdr.de>; Sun, 30 Jun 2024 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260413AA35;
	Sun, 30 Jun 2024 10:53:32 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378BA4084C;
	Sun, 30 Jun 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744812; cv=none; b=V41OZ2DXIVX88wb/RnuOTLsAYFS9G+Lm9rnOJvgEpidHoA1VT58AB/FXzBDJRsIrRkXhxxrvxSk0PVY3/u41FgLo9Ljvpkj6JH5Ypswzl33AZO40kEeRpHb2jYecz1WsOfn4rN+QPhvrHyVBNXu7X0cK5WVU4YKpADPOv6FQxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744812; c=relaxed/simple;
	bh=IZTq1zvuarLg033WSFXregmEl+OW1UuBIvBKnYOUUHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urGDtVB5pxxlatJ05CEuobCCj1wnFOEhqgHlVkhFNGkf9nfQ5bzMr5su0i3lK91pW0aSswDjoPLeOiWLIFh7KI27L16TK59IPaxbuhP7fVHvEvf/f0NYxrryZGis5leRnOnHECqEPo6Thd3zJGssCDqUbF+OdC3KmQ9kg9kMABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 3C94472C8F5;
	Sun, 30 Jun 2024 13:53:23 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 2F08D7CCB3A; Sun, 30 Jun 2024 13:53:23 +0300 (IDT)
Date: Sun, 30 Jun 2024 13:53:23 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240630105322.GA17573@altlinux.org>
References: <20240510140435.3550353-1-vdonnefort@google.com>
 <20240510140435.3550353-4-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510140435.3550353-4-vdonnefort@google.com>

On Fri, May 10, 2024 at 03:04:32PM +0100, Vincent Donnefort wrote:
[...]
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> index b682e9925539..bd1066754220 100644
> --- a/include/uapi/linux/trace_mmap.h
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -43,4 +43,6 @@ struct trace_buffer_meta {
>  	__u64	Reserved2;
>  };
>  
> +#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
> +

I'm sorry but among all the numbers this one was probably the least
fortunate choice because it collides with TCGETS on most of architectures.

For example, this is how strace output would look like when
TRACE_MMAP_IOCTL_GET_READER support is added:

$ strace -e ioctl stty
ioctl(0, TCGETS or TRACE_MMAP_IOCTL_GET_READER, {c_iflag=ICRNL|IXON, c_oflag=NL0|CR0|TAB0|BS0|VT0|FF0|OPOST|ONLCR, c_cflag=B38400|CS8|CREAD, c_lflag=ISIG|ICANON|ECHO|ECHOE|ECHOK|IEXTEN|ECHOCTL|ECHOKE, ...}) = 0

Even though ioctl numbers are inherently not unique, TCGETS is
a very traditional one, so it would be great if you could change
TRACE_MMAP_IOCTL_GET_READER to avoid this collision.

Given that _IO('T', 0x1) is _IOC(_IOC_NONE, 'T', 0x1, 0),
something like _IOC(_IOC_NONE, 'T', 0x1, 0x1) should be OK.


-- 
ldv

