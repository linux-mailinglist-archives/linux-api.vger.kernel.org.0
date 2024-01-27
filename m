Return-Path: <linux-api+bounces-705-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D595283F024
	for <lists+linux-api@lfdr.de>; Sat, 27 Jan 2024 22:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810AF285B79
	for <lists+linux-api@lfdr.de>; Sat, 27 Jan 2024 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371A199D0;
	Sat, 27 Jan 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOgzVJxC"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7F19BA2
	for <linux-api@vger.kernel.org>; Sat, 27 Jan 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706389894; cv=none; b=RnnH61py0m3CGshehAHL6v8oz667mhI7jjvmTHtZOsQd98ZcY+vXCoKPYzHymqOQaLbG8BsKxBKwpo3buKzPhxC5TyvfPp2Xi25H5OcUVOc5GcwcGWXorMvCa/vYBt/BBufT4WU+4T1IKePfPuKkc9NJxqQAaNwhrqQs9cpMwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706389894; c=relaxed/simple;
	bh=e9ssbtj5/gqXRUdezTmszQ5A3hRAEynVyD59GYaJgEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJS8Lqno7OXQIPCPKyMPl+WmsUUyux34L2QJDW3q3JcfpPFB+nlnnc97TSHEJ+KRxj1ZF7t9n7NRv1UteRQ5LZyMQAwiZk4pFpwjVH462xG5FLmnePI7RNH0/kZ8EXjDypG5suHrtEhtap8PAdR/PlEOek+lEeAMCUuc2iqE/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOgzVJxC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706389891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxDG8FbkrxGkzjJwUDG8WjeC4k+DKoBsMZSfq3CWFgY=;
	b=hOgzVJxCuPWI9wQ8IoS3JpVRkKuIjXAx7EHWEa0FADjgKZFnTtwWYTq9mMfoqxw2aTb16/
	I62dDoo89iwKP9EONMdRdk5H9agAnb8ao8S/72mHMvEQDtc12Fo5C2yc83QTA1XzkUnVHh
	ktDg8Xs+bP2vstIci7/MvkwU/ragofs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-GEniBBKxMF2e41sgRC3b0w-1; Sat, 27 Jan 2024 16:11:29 -0500
X-MC-Unique: GEniBBKxMF2e41sgRC3b0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 150571013768;
	Sat, 27 Jan 2024 21:11:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.37])
	by smtp.corp.redhat.com (Postfix) with SMTP id A1C5E1121306;
	Sat, 27 Jan 2024 21:11:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 27 Jan 2024 22:10:14 +0100 (CET)
Date: Sat, 27 Jan 2024 22:10:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240127210634.GE13787@redhat.com>
References: <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbVrRgIvudX242ZU@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 01/27, Tycho Andersen wrote:
>
> On Sat, Jan 27, 2024 at 08:31:27PM +0100, Oleg Nesterov wrote:
> >
> > On the second thought I am starting to understand your concern...
> >
> > Indeed, in this case -EBADF is technically correct but it can confuse
> > the user which doesn't or can't know that this task/thread is exiting,
> > because EBADF looks as if the "int fd" argument was wrong.
> >
> > Sorry I missed your point before.
>
> No worries. I realized it's not so hard to fix with your new
> xxx_exited() helper from the PIDFD_THREAD patch, so maybe worth
> cleaning up after all?

OK, lets discuss this later.

I'll (hopefully) send v2 on top of

	pidfd: cleanup the usage of __pidfd_prepare's flags
	pidfd: don't do_notify_pidfd() if !thread_group_empty()

on Monday, will be busy tomorrow (family duties ;)

Oleg.


