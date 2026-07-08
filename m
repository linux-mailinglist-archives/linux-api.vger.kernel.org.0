Return-Path: <linux-api+bounces-6803-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9VrjM6u1Tmo/SwIAu9opvQ
	(envelope-from <linux-api+bounces-6803-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 22:40:11 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC972A45E
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 22:40:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TMBaSeMQ;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6803-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6803-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF0A311D959
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486813E51CB;
	Wed,  8 Jul 2026 20:35:46 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94153E4C87
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 20:35:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542946; cv=none; b=ZqRxRmQiFytRWkAtHXfgSBKv4XCS89E2/13QUhxltj2sENMbFUofHJgd6gJwmVrwwImejiW5mblx5IGlFAYVDP3mxT9zYaIO+24AECHwvJ+GldNCNc5lex4fhVuBbaQJZSmr8s8G3BHGCpai4smCn3ENHGj+tD1ScYRtjl/oK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542946; c=relaxed/simple;
	bh=dNCH3GBqXQ8BeQwtL9quBRN8WK05Wh+x5HVAqi882XU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y6CO5+aTb2u96k6oFDpiidYPSGbY2n9nt9Sq26PYevhhkRn9QJCwkLhGLmAPDwrZJnpUyZQ4HhWuXDQTaHjYVgtHtf2ydQRXUSRnkOlVlcYslcAxyFNSd3bTfL2W4OEKvzCIotklkpNkXgxZVHVKM3aaBdin+ZNjwJrPFTY/btw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMBaSeMQ; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783542943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GdmhhnDmpRS1ZdiDos4jfG6fHjForej54rE9mVQS0Q=;
	b=TMBaSeMQht4ZrPOkbaLReDegRus2lYrivc56V3P4lPLceI1szIdEdycT52wKX5AMfQBsTN
	4YvP6P2VAwL5Se1uGwcT7j7dQJOJJT7lvXFEPr+9aM5Uz7VdobRNB0U4tMCYknzQx3oqE1
	/Ea+Imgw8ZSZEAmkUHTuWPcjSniuQu8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-KBF1YK9DMuaxt0-_1DuQlw-1; Wed,
 08 Jul 2026 16:35:42 -0400
X-MC-Unique: KBF1YK9DMuaxt0-_1DuQlw-1
X-Mimecast-MFC-AGG-ID: KBF1YK9DMuaxt0-_1DuQlw_1783542940
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 673951955DCF;
	Wed,  8 Jul 2026 20:35:40 +0000 (UTC)
Received: from localhost (unknown [10.44.33.4])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 724961774;
	Wed,  8 Jul 2026 20:35:39 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  Amir Goldstein <amir73il@gmail.com>,  Al Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
In-Reply-To: <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 8 Jul 2026 21:45:01 +0200")
References: <20260708095831.3381978-1-gscrivan@redhat.com>
	<CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
	<878q7l8y4y.fsf@redhat.com>
	<CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
	<87wlv57dt1.fsf@redhat.com>
	<CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
	<87o6gh79yi.fsf@redhat.com>
	<CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
Date: Wed, 08 Jul 2026 22:35:38 +0200
Message-ID: <87fr1t6wyt.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6803-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,zeniv.linux.org.uk,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:amir73il@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29AC972A45E

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Wed, 8 Jul 2026 at 17:55, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>>
>> > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> >
>> >> Amir suggested to add that functionality when I've asked for some
>> >> feedback before sending the patch here.  I am fine to drop it if this is
>> >> the consensus although I see its utility from user space.
>> >
>> > How about a completely different interface:
>> >
>> > int get_fd_opt(const char *name, unsigned int index, unsigned int flags);
>> >
>> > Enumerating layers would be as easy as passing an index stating from
>> > zero and stopping when -ERANGE is received.
>> >
>> > It would work for all filesystems that use files as options.  No more
>> > fs specific ioctls.
>>
>> Is a new syscall really justified for such a narrow use case?
>
> That's the reason I advocate pseudo fs based solutions.  Let's see, we
> had a proposal to use openat(), something. like:
>
> openat(base_fd, "mount/options/lowerdir+/0", O_ALT | O_PATH);
>
> Meaning that O_ALT switches to an alternative/meta namespace that is
> based on the given fd and in that meta namespace the tree under mount/
> represents the attributes of the mount that base_fd is on.
>
> See this post from Linus as well:
>
>   https://lore.kernel.org/all/CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com/
>
> The statmount api took a different route, but for getting an O_PATH
> file this would be a very natural interface without added syscalls.

I don't argue against such an API, I only argue that I am probably not
the best person to drive such a significant change :-)

Would you be OK with the ioctl as a solution that works today, and
duplicate it when an alternative API materializes?

Thanks,
Giuseppe


