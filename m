Return-Path: <linux-api+bounces-1000-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36068584F0
	for <lists+linux-api@lfdr.de>; Fri, 16 Feb 2024 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847871F221E7
	for <lists+linux-api@lfdr.de>; Fri, 16 Feb 2024 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3746C133997;
	Fri, 16 Feb 2024 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8gUlFb7"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B3132472
	for <linux-api@vger.kernel.org>; Fri, 16 Feb 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107221; cv=none; b=ViL3Mc4JeLhXUSzkiOiRW1yb9r56c79SIfv48u3kfE92s6SBZk7g7duNli42BnR4xyoanphtXx6D8BuW2fVJrWUrv80h4F/EK7pTCXSTwvUoo1zvZRN7FAxMCb0DwWw1rGDEDenlFEMHucqB7BWzailnhxEv+jJ/9eI0wRZ+pss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107221; c=relaxed/simple;
	bh=B023sSGDBFQJqmvDlf6apONz6TB5blUVd9P3ksydNeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr6zM+fmSmsDOCcNKC6h4dT0o1aenMmvB7A4bGYeT0KcyU6V8y5IgYFohG0Gt5XyDKKBTyw8S+4yZPLywroUjRcdi2oFOZtXjBcy70ZA/5xpMFbQDABMHeMQdXhJ5gme/71xP1bXk+nf0v4hHQhUqrwzpvSHFEwJyHcu9j2p240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8gUlFb7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708107218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HgOK0yUuaGMKma7nesHwii4yqa8NnnopVqNm88A5WY=;
	b=Q8gUlFb7dUCMAfzHTijv0PaqCYP/z8Yd+UjE4nJyu04NqvO+Ky7qYpNrjkKEqbtctUlcjv
	9H2rkVQdbgBL1gPgN/QRcCLfM1U25S+Ko6ERKhTPLYUEk07Tactxxl9e7XWT4KhJ6KOtQI
	UnvX0jvoLSqrwKVEiklEym//MKQbOqA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-85dBkUWwNw-B9aBvz9mtCQ-1; Fri,
 16 Feb 2024 13:13:35 -0500
X-MC-Unique: 85dBkUWwNw-B9aBvz9mtCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05DE41C04333;
	Fri, 16 Feb 2024 18:13:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.116])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2A0B4112131D;
	Fri, 16 Feb 2024 18:13:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 16 Feb 2024 19:12:17 +0100 (CET)
Date: Fri, 16 Feb 2024 19:12:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240216181214.GA10393@redhat.com>
References: <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/16, Christian Brauner wrote:
>
> > SI_USER means that the target can trust the values of si_pid/si_uid
> > in siginfo.
>
> Bah, what an annoying nonsense. I see that this can be used to emulate
> stuff like SI_TIMER and SI_ASYNCIO. But I very much doubt the value of
> e.g., emulating SI_DETHREAD. Maybe I'm missing something very obvious.

I don't understand...

SI_USER/SI_TKILL means that the signal comes from the userspace (kill/etc),
but siginfo was filled by the kernel so the receiver can trust it.

> So wouldn't be better of just writing this as?
>
> if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
>     (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
>         goto err;
>
> So that we don't have to repeat the same exercise if we extend this to
> anything above PIDTYPE_PGID?

Heh ;)

I swear, this is how I wrote it originally, but then for some reason I
thought it would raise the questions, so I changed it to check PIDTYPE_PGID.

IOW, sure, I agree.

Oleg.


