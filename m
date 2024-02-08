Return-Path: <linux-api+bounces-893-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A58584E4CA
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 17:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAC7B27E34
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D807CF25;
	Thu,  8 Feb 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYhpzvCx"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0F7E789
	for <linux-api@vger.kernel.org>; Thu,  8 Feb 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408836; cv=none; b=BdQxvNa9H7es1G7Nb8K8AMqGQbbS87MZZzZ+AMH6FzoEAVMJmmVDHpQUYTVH28rPQsJmEEOt7FvAnwyrhzjjCxTWby9Zpb4WVLFX0z3ukQn887u8yDdpJnUrW95zuKOlxp26xi1pl6QRVHcHtlKIjxANe8Bu4qTv5N/nfqwvJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408836; c=relaxed/simple;
	bh=fGN+8yem8iK2xAq/g74215xfHKUUWP3ssmQdsWN6nkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UleRCqY7oakD5ytFOnLQPZOsWFcTsDAJINVnhtQ8xwBoF8C7aMIpYXwPUSn4HNSwfgEXoJrkp3Tl224FuvE2a4tCBAx+ozSXu/ecOEQniMaTJtaRKfM7npAoLwEye/W9QyYu9ZuYnxoTb6A3ZsLuu3TWnhpVwFgrViViOIpGszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYhpzvCx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707408831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fGN+8yem8iK2xAq/g74215xfHKUUWP3ssmQdsWN6nkk=;
	b=aYhpzvCx9gY3ddYvDS9d87b55402y+LlxAr4ABbox74Jwivl4K7sO6G5nlyfSmgoTotZTc
	xZVIMuBiPD1w0H+ptY6YwfLJmQ9Ku2pD1WHlaKeI8aOeDvzGcSmLRj5gj7GnOTP0heQ5nf
	FuBLAuDtCI+G8LSj79RyftmeDs3TrIs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-lBOwh8qBM6KbU3EH3hgsWQ-1; Thu,
 08 Feb 2024 11:13:02 -0500
X-MC-Unique: lBOwh8qBM6KbU3EH3hgsWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 155803C28653;
	Thu,  8 Feb 2024 16:12:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.158])
	by smtp.corp.redhat.com (Postfix) with SMTP id 71A841C14B0E;
	Thu,  8 Feb 2024 16:12:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Feb 2024 17:11:21 +0100 (CET)
Date: Thu, 8 Feb 2024 17:11:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208161118.GI19801@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208135344.GD19801@redhat.com>
 <20240208143407.GF19801@redhat.com>
 <20240208-klopapier-aushebeln-446ac80a6e9b@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-klopapier-aushebeln-446ac80a6e9b@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 02/08, Christian Brauner wrote:
>
> > Is prepare_kill_siginfo() correct when we send a signal to the child
> > pid namespace? si_pid = task_tgid_vnr(current) doesn't look right in
> > this case but perhaps I am totally confused.
> >
> > And why do we need it at all? Can't sys_kill() and pidfd_send_signal()
> > just use SEND_SIG_NOINFO?
>
> Yeah, good point. I don't remember as it's been quite a while ago. My
> guess is that it just tried to mirror kill() itself without being aware
> of SEND_SIG_NOINFO. If you don't find anything wrong with this then
> switch it to SEND_SIG_NOINFO in a preparatory patch we can backport,
> please.

Yes, but I still feel I must have missed something. Will read this code
tomorrow.

And another note for the record before I forget this. We can probably
improve and rename access_pidfd_pidns(). Currently it is only used by
pidfd_send_signal() but pidns_install() looks like another user.

Oleg.


