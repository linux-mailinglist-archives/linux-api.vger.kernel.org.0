Return-Path: <linux-api+bounces-885-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D641884E294
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAAC1F29F48
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48E768E1;
	Thu,  8 Feb 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NerDTP6G"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942776C67
	for <linux-api@vger.kernel.org>; Thu,  8 Feb 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400512; cv=none; b=hNzx2blC6d/OkrPZRkChRKG40L13x3eHh3ArcCTtoLEgSA9Zw4c/MSJTNxuDXW/fKNzwAX39fE/j/G8DHdAjwVr8SRPPiy49V/YzGEUbAyYLYDLYeIKOuWVWHwUoj6pHJTEz2x1zxP8rkOMIgnO4+kuHWbHWcCquEenqioE5GEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400512; c=relaxed/simple;
	bh=eBOpj9vr+ze6ckMI+1qnwlUv9z5G8N5Eo92iW2xOv04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWKeeBh4e+M+DHIopW8zLVVObHlEMLOvoX1RJamRGy40VwHsHtJsck4p7rIX6yb3KyAmiDuARnYi8FeIxwjI/Fv1CBMXGKB8TOKK00f47h8XPf/CXg6/AOAT0sqFvsMAZgVxOfG7rQ5VjF8pbww0KeF7hWdfNZlgi/WOmXBUl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NerDTP6G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707400509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/fcEFVTR0rsXTj+Grlw2xqYc8J4he9PWeVGkbhbY1/Q=;
	b=NerDTP6GvpXLhbH2w3V5F+6e1dCCyJk7FcPRVv0HkJoaIpQfk6gRN4J+fhKT0PSz7mYkPm
	B6oJwMBJlzoPNCPPfgBQ7VmvmH8RdJ2PDitOcLCmIjej3uc/6KZ30+z59taBLqq8vjSvcp
	haAOi28IWNnZMl+IJq1ZIull4jNJOwE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-PD0hYRglPcifZwAOdlIWrQ-1; Thu,
 08 Feb 2024 08:55:03 -0500
X-MC-Unique: PD0hYRglPcifZwAOdlIWrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19F061C09839;
	Thu,  8 Feb 2024 13:55:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.158])
	by smtp.corp.redhat.com (Postfix) with SMTP id A1D01492BC7;
	Thu,  8 Feb 2024 13:55:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Feb 2024 14:53:47 +0100 (CET)
Date: Thu, 8 Feb 2024 14:53:45 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208135344.GD19801@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-fragt-prospekt-7866333b15f0@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 02/08, Christian Brauner wrote:
>
> On Wed, Feb 07, 2024 at 12:45:49PM +0100, Oleg Nesterov wrote:
> > +	type = (f.file->f_flags & PIDFD_THREAD) ? PIDTYPE_PID : PIDTYPE_TGID;
> > +	ret = kill_pid_info_type(sig, &kinfo, pid, type);
>
> If the user doesn't provide siginfo then the kernel fills in the info in
> prepare_kill_siginfo() a few lines above. That sets info->si_code to
> SI_USER even for the PIDFD_THREAD case. Whenever the info is filled in
> by the kernel it's not exactly userspace impersonating anything plus we
> know that what we're sending to is a pidfd by the type of the pidfd. So
> it feels like we should fill in SI_TKILL here as well?

Hmm. Agreed, will do, thanks.

But then I think this needs another preparational 1/2 patch.
prepare_kill_siginfo() should have a new arg so that do_tkill() could
use it too.

(offtopic, but may be the "Only allow sending arbitrary signals to yourself"
 check in pidfd_send_signal() needs another helper, do_rt_sigqueueinfo()
 does the same check).

> I would also suggest we update the obsolete comment on top of
> pidfd_send_signal() along the lines of:

Ah, indeed, thanks.

Oleg.


