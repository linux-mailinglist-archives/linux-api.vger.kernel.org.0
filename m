Return-Path: <linux-api+bounces-1050-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D99085D87A
	for <lists+linux-api@lfdr.de>; Wed, 21 Feb 2024 13:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C40E1F22C0D
	for <lists+linux-api@lfdr.de>; Wed, 21 Feb 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2888657AC;
	Wed, 21 Feb 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEPAsSHk"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E6529AB
	for <linux-api@vger.kernel.org>; Wed, 21 Feb 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520212; cv=none; b=gvkbP4mzqdq+EhMzkV/g9kJ2/fprTjMvE+MqGEECJwJz6skk1V/yfkbbCd/7Sc+Jk0sLproIdgBn2sC/6rNcgnMiImupxcYROCdV3+ClvYWAByHOGHM540vpmlwarNxwMXBMqNZsqAVtMz8LveXp8YTa5EMF+xYpky6bZiDCocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520212; c=relaxed/simple;
	bh=pg1mcNVSjCSg//U1qEGOAKr/92rgrkQahsiIB89xZPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax9jvMBl4gQCXJV2Cxh4WmSOVgMtTfZQwNyPjvSJOvvDoDPn41d29Z06ydkCsaxTLOTY0QHypXAhYOAK8Nd5glZHfDV5klF2IazcrSm3vk5PsDylfhccmovYucmk1wRElKa52P4G5xslxBY5DFceaycxn2HY7ZzhVxXWZ+De9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEPAsSHk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708520210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeM6ln5GPe+54z6KZr8QF1BPN1lbild34z3N9RGW30M=;
	b=IEPAsSHkxwjrob/U7rIZb3j6dvdmcNAU6wAtrt72QCsu93JXfssWe6T/UIELIpdgDYgLeY
	oe/qN14DENRKZKDbPJpkaN6bhSm6dnYDnvslsjCQGVzCyiLpka/88YfEeAJXm+AK0eTEfn
	4Y4BfU77uCOss34areqIyYGEOqHnDtU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-bWiMgYo1NRyg3lvkXBfQGQ-1; Wed, 21 Feb 2024 07:56:46 -0500
X-MC-Unique: bWiMgYo1NRyg3lvkXBfQGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AB5B8630C0;
	Wed, 21 Feb 2024 12:56:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.78])
	by smtp.corp.redhat.com (Postfix) with SMTP id D677C8CE8;
	Wed, 21 Feb 2024 12:56:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 21 Feb 2024 13:55:28 +0100 (CET)
Date: Wed, 21 Feb 2024 13:55:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240221125525.GA16773@redhat.com>
References: <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
 <20240220090255.GA7783@redhat.com>
 <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
 <20240220110012.GB7783@redhat.com>
 <20240220-anlegen-feinmechaniker-3c2cfcc3ec01@brauner>
 <20240220162201.GD7783@redhat.com>
 <20240221-zapfhahn-pulsschlag-e8f9d919c350@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-zapfhahn-pulsschlag-e8f9d919c350@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 02/21, Christian Brauner wrote:
>
> On Tue, Feb 20, 2024 at 05:22:02PM +0100, Oleg Nesterov wrote:
> >
> > > > > +       /* Currently unused. */
> > > > > +       if (info)
> > > > > +               return -EINVAL;
> > > >
> > > > Well, to me this looks like the unnecessary restriction... And why?
> > >
> > > Because right now we aren't sure that it's used
> >
> > Yes, but...
> >
> > > and we aren't sure what use-cases are there.
> >
> > the same use-cases as for rt_sigqueueinfo() ?
>
> Specifically for pidfd_send_signal() I mean. To me it seems very
> unlikely that anyone would be opening a pidfd to itself

Ah, with this, I do agree. And that is why (I think) we can remove
the "task_pid(current) != pid" check in the "info != NULL" branch.

Oleg.


