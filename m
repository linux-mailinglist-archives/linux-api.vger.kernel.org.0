Return-Path: <linux-api+bounces-868-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1756484C8A9
	for <lists+linux-api@lfdr.de>; Wed,  7 Feb 2024 11:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4590283046
	for <lists+linux-api@lfdr.de>; Wed,  7 Feb 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4314AB3;
	Wed,  7 Feb 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARgaVF76"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF21AB7E6
	for <linux-api@vger.kernel.org>; Wed,  7 Feb 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301815; cv=none; b=hgS0Gde9uuabdNFTz2e2+qO2zXoI45doiXdl45war2tldwBcUPwxyDICaQwvqiwqCMMx1v766bKvF1Qs9emydcMRoBoyCM+RLSi1i4vKLxX98+HKuLrSbyrPTNVoDUnKehbx/XGu+6Z94xSz80EW1hHH5aUtugtG1NIZ+cZG6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301815; c=relaxed/simple;
	bh=SYwYCEnqQYQ+hYirpuiPZCwt/4X5tBxQZJMg02Qkego=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og/rGF1d+XST5+3NuoYecR2cDHyuyFmUEADaSTSGomaM+vY+XhRSQpcOrAnDCxlgjwQSorXsfOw2UPK5nEWNufgrh+kZGjswbCy+Wf/LaX/AlyvQN2zgMJOAzaiRhQhBBasXhsaQ70pARIADLiq0mbnOO1mlFTxRZ75PTCCmhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARgaVF76; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707301811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYwYCEnqQYQ+hYirpuiPZCwt/4X5tBxQZJMg02Qkego=;
	b=ARgaVF76CTFIJgf9PjnVN/eWHehz8Gr6KTHcZ5kdMRopS4fOp7Jv6OGjICjMmngZL+SYx0
	2fTU94hlZrYctVMNKegc8EmooBFDW3y04TLp8P7JIhVyNueRjrLVGCv/uVATNOU7y1TIHM
	53Kn3K5kcSlDZPDNUqYMcKNH1PU07/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-HW9XA8KdNFeMtgpCsj9MIg-1; Wed, 07 Feb 2024 05:30:09 -0500
X-MC-Unique: HW9XA8KdNFeMtgpCsj9MIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 945FD828CEB;
	Wed,  7 Feb 2024 10:30:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.212])
	by smtp.corp.redhat.com (Postfix) with SMTP id E898B112131D;
	Wed,  7 Feb 2024 10:30:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Feb 2024 11:28:52 +0100 (CET)
Date: Wed, 7 Feb 2024 11:28:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240207102849.GA6627@redhat.com>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
 <20240206180607.GB3593@redhat.com>
 <ZcJ13uLxD6rTqqZZ@tycho.pizza>
 <20240206192553.GC3593@redhat.com>
 <20240207-beseitigen-ausfliegen-b2b95de67c4f@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-beseitigen-ausfliegen-b2b95de67c4f@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/07, Christian Brauner wrote:
>
> On Tue, Feb 06, 2024 at 08:25:54PM +0100, Oleg Nesterov wrote:
> > On 02/06, Tycho Andersen wrote:
> >
> > > On Tue, Feb 06, 2024 at 07:06:07PM +0100, Oleg Nesterov wrote:
> > > > Or we can check task->files != NULL rather than PF_EXITING.
> > > >
> > > > To me this looks even better, but looks more confusing without a comment.
> > > > OTOH, imo this needs a comment anyway ;)
> > >
> > > I thought about this, but I didn't really understand the null check in
> > > exit_files();
> >
> > I guess task->files can be NULL at least if it was cloned with
> > kernel_clone_args->no_files == T
>
> Won't this give false positives for vhost workers which do set
> ->no_files but are user workers? IOW, return -ESRCH even though -EBADF
> would be correct in this scenario?

OK, agreed. Lets check PF_EXITING or exit_state.

Oleg.


