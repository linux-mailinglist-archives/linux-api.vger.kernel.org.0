Return-Path: <linux-api+bounces-782-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9A48447D7
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 20:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0F2289FFD
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10D33CFD;
	Wed, 31 Jan 2024 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNW9R984"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398EE381D6
	for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728529; cv=none; b=kbVUgFGxfOiMZA9WDrRBwweFvVmIdGQ/Gd+W3TJIpelLJRIrlr1RJrQyRhUPU2vOi8fmxMJOaGrA+G8l40Q4QYC4/E7r3eAeuYdG8sm5OBCFBN/1AWKaRTLT/bnhTD2lF9zoo0BPEXADbCDSu/SOf61SRd/n3nQ66dQf7JoDJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728529; c=relaxed/simple;
	bh=cwnbPQp+9uko8EtVbCazjAPHmnkyAF3rNBLcULYxO2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjqJCneWn0AO+niZpDNUdeA7klDJAdC7jDV3ZxIIyuQ39el4/OatPMrSdLBiozGun4L/9085KweoUxBVryKSmdz4n0TvgBgxw0UluwgXFsAqN6lk0bhPlfRj8U0kqalhy1RlpUxiuviJW3qItQN5aor9CebFUQ1jcCzm/sBX5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNW9R984; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706728527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pe8VXI62FgPJM3Gsr0bzFElOUfGdcBzcX4YjVIdn94A=;
	b=eNW9R984+Fek9U8UB7ceFZsxirtmv/41Er+Sdg5Po+NajrYcJUHylqBslBMl+8mCW1VL/W
	8gWPCkV8PHI3lD3dcsmKaGZA+ewB7cGEWFOHFZ+MmIY40c0SQ3aOFQ5meFaz1huAisHtkK
	7xqXEoHZ0aAEikMFxM19xypcbcJjyVs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-A2tbhQTfNmC9lE8aMdSxOw-1; Wed, 31 Jan 2024 14:15:23 -0500
X-MC-Unique: A2tbhQTfNmC9lE8aMdSxOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3377F87B2A2;
	Wed, 31 Jan 2024 19:15:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id 54ECDC1ED63;
	Wed, 31 Jan 2024 19:15:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 20:14:08 +0100 (CET)
Date: Wed, 31 Jan 2024 20:14:06 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240131191405.GF2609@redhat.com>
References: <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
 <20240131184829.GE2609@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131184829.GE2609@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Forgot to mention...

And I agree that pidfd_send_signal(flags => PGID/SID) can make
some sense too.

But this a) doesn't depend on PIDFD_THREAD, and b) needs another
patch/discussion.

But again, I am not sure I understood you correctly.

On 01/31, Oleg Nesterov wrote:
>
> On 01/31, Andy Lutomirski wrote:
> >
> > Right now, pidfd_send_signal() sends signals to processes, like so:
> >
> >  * The syscall currently only signals via PIDTYPE_PID which covers
> >  * kill(<positive-pid>, <signal>. It does not signal threads or process
> >  * groups.
> >
> > This patch adds PIDFD_THREAD which, potentially confusingly, doesn't
> > change this (AFAICS).
>
> Yes,
>
> > So at least that should be documented loudly
> > and clearly, IMO.
>
> Please note
>
> 	/* TODO: respect PIDFD_THREAD */
>
> this patch adds into pidfd_send_signal().
>
> See also this part of discussion
>
> 	> > +	/* TODO: respect PIDFD_THREAD */
> 	>
> 	> So I've been thinking about this at the end of last week. Do we need to
> 	> give userspace a way to send a thread-group wide signal even when a
> 	> PIDFD_THREAD pidfd is passed? Or should we just not worry about this
> 	> right now and wait until someone needs this?
>
> 	I don't know. I am fine either way, but I think this needs a separate
> 	patch and another discussion in any case. Anyway should be trivial,
> 	pidfd_send_signal() has the "flags" argument.
>
> with Christian in https://lore.kernel.org/all/20240130112126.GA26108@redhat.com/
>
> Or did I misunderstand you?
>
> Oleg.


