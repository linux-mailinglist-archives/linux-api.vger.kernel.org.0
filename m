Return-Path: <linux-api+bounces-703-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AAE83EFC4
	for <lists+linux-api@lfdr.de>; Sat, 27 Jan 2024 20:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2588D1C22DD6
	for <lists+linux-api@lfdr.de>; Sat, 27 Jan 2024 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BF22E637;
	Sat, 27 Jan 2024 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ntn2G73/"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7252D78A
	for <linux-api@vger.kernel.org>; Sat, 27 Jan 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383971; cv=none; b=XeDN1NiP/0m0X1CqCmG5JI5JMSqyTqyKfNwHtMVn9H2+Mn3C0KvAVQ+usNixI9hDI/aXiiZ5C5XKX+4gue6Qb4XDJfSNrrhej5iST0JO5L3QVxU3Ak9/AHfSNXyRpVglD+oHVfw+697aPxIHL4nuJPtyvwaurv9IH5DgTjMp28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383971; c=relaxed/simple;
	bh=O+26wNDTbnhxQ0dT1QMv9vCHeo7qkq4db2h6R0uH6/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrX0IY/om0GIUVipNZJ6cUXbNqqaLeTZcs26dCaZAGNXAL/RAkUmUm56grIqcVtYQSuLNzHiT2Ut1ZLDzGNjxMyQDpNzGDhoNsLfsHAxgIf4The5+UKjL8u1nqjsEOiVtShUKMV/Wv4F5qVC0P6LLui4OLK5WOrLSvDyi9a9Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ntn2G73/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706383968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+26wNDTbnhxQ0dT1QMv9vCHeo7qkq4db2h6R0uH6/8=;
	b=Ntn2G73/g+Bo52fL0Lt5LOPz0Cf1N3T/RCteT61i7JbC0B8g+/0bVSHwZi6IwgMPe7+il7
	upwGySCWxP3exVIq2QcP7935YQdyv3IBCRQsV5wgBzcHllmDvJ8cYHejftY5S7GZajw1SB
	maxPhBg7gAu4t/quL54QGVGPh0oIIcA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-L4jdJzmyMMmfUpsmAq3A2A-1; Sat,
 27 Jan 2024 14:32:44 -0500
X-MC-Unique: L4jdJzmyMMmfUpsmAq3A2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 012BC28C976D;
	Sat, 27 Jan 2024 19:32:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.4])
	by smtp.corp.redhat.com (Postfix) with SMTP id 74A4C40C9444;
	Sat, 27 Jan 2024 19:32:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 27 Jan 2024 20:31:30 +0100 (CET)
Date: Sat, 27 Jan 2024 20:31:27 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240127193127.GC13787@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbU7d0dpTY08JgIl@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 01/27, Tycho Andersen wrote:
>
> > > > exit_notify() is called after exit_files(). pidfd_getfd() returns
> > > > ESRCH if the exiting thread completes release_task(), otherwise it
> > > > returns EBADF because ->files == NULL. This too doesn't really
> > > > depend on PIDFD_THREAD.
> > >
> > > Yup, understood. It just seems like an inconsistency we might want to
> > > fix.
> >
> > Not sure this worth "fixing"...
>
> Yep, maybe not. Just wanted to point it out.

On the second thought I am starting to understand your concern...

Indeed, in this case -EBADF is technically correct but it can confuse
the user which doesn't or can't know that this task/thread is exiting,
because EBADF looks as if the "int fd" argument was wrong.

Sorry I missed your point before.

Oleg.


