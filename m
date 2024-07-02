Return-Path: <linux-api+bounces-1825-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77764924653
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 19:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABF41C20AC7
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2324D1BE86C;
	Tue,  2 Jul 2024 17:33:50 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700B1BD50C;
	Tue,  2 Jul 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941630; cv=none; b=LRXSfHLuc2Bp1jm8c/ZglYdN6CWzTt4Cb37Ei4PCZTpsAqeSOaPXHVxtr7Jf8kyV/Agn5EiH12bfk9Rsw160vxsBQ87T2twjuh3NfWGIZ107luo83cXaUm82i+G7+ho34w/ZEhnI+J9nObFBjy1y/qyGZUXhTsNfd0RoagOt2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941630; c=relaxed/simple;
	bh=Z0xtPjIqXFptQeYP2r3VxJ7kkk1vhuKPqDQr1WYTpKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru3gwUbmQBXjPeEcmVzAc4eTC1vIKag1kcX6UkL2wIphhqCFUfBAtRZXZTJATLuWbEtzOZ3yu44Sn9GmRfsJmAxD2R7dipbDEQsblhH9DsH76QRtNCKdXKmnOgpXv1Bz0f4xHFeDxQbn/Pmrxo+oyjl5fnR7xwvsDnJODQQTyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 611CD72C8CC;
	Tue,  2 Jul 2024 20:33:46 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 53DB67CCB3A; Tue,  2 Jul 2024 20:33:46 +0300 (IDT)
Date: Tue, 2 Jul 2024 20:33:46 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
	kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
	david@redhat.com, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240702173346.GA16408@altlinux.org>
References: <20240510140435.3550353-1-vdonnefort@google.com>
 <20240510140435.3550353-4-vdonnefort@google.com>
 <20240630105322.GA17573@altlinux.org>
 <20240630084053.0b506916@rorschach.local.home>
 <9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
 <20240702111807.13d2dd2c@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702111807.13d2dd2c@rorschach.local.home>

On Tue, Jul 02, 2024 at 11:18:07AM -0400, Steven Rostedt wrote:
> On Tue, 2 Jul 2024 10:36:03 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > > I can send a patch this week to update it. Or feel free to send a patch
> > > yourself.  
> > 
> > You need to reserve an unused ioctl Code and Seq# range within:
> > 
> > Documentation/userspace-api/ioctl/ioctl-number.rst
> 
> Ug, it's been so long, I completely forgot about that file.
> 
> Thanks for catching this.
> 
> > 
> > Otherwise this duplicate will confuse all system call instrumentation
> > tooling.
> 
> Agreed, what if we did this then:
> 
> -- Steve
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d..9a97030c6c8d 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -186,6 +186,7 @@ Code  Seq#    Include File                                           Comments
>  'Q'   all    linux/soundcard.h
>  'R'   00-1F  linux/random.h                                          conflict!
>  'R'   01     linux/rfkill.h                                          conflict!
> +'R'   20-2F  linux/trace_mmap.h
>  'R'   C0-DF  net/bluetooth/rfcomm.h
>  'R'   E0     uapi/linux/fsl_mc.h
>  'S'   all    linux/cdrom.h                                           conflict!

Just in case, I've checked the list of ioctls known to strace and can
confirm that there are no users of 'R' ioctl code in 0x20..0x2f range yet.

By the way, this file is definitely not up to date, the 'R' part of it
should have contained the following:

'R'   00-1F  uapi/linux/random.h                                     conflict!
'R'   01-02  uapi/linux/rfkill.h                                     conflict!
'R'   01-0D  uapi/misc/fastrpc.h                                     conflict!
'R'   C0-DF  net/bluetooth/rfcomm.h
'R'   E0     uapi/linux/fsl_mc.h


-- 
ldv

