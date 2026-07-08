Return-Path: <linux-api+bounces-6796-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oD+rOFlsTmrIMQIAu9opvQ
	(envelope-from <linux-api+bounces-6796-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 17:27:21 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9F728007
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 17:27:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=P6k2jwoj;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6796-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6796-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 998C23026ADA
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D273A9017;
	Wed,  8 Jul 2026 15:20:54 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72B2FD1B5
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 15:20:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524054; cv=none; b=kM9wueEAeYOxn3P/kinSCdyUU5CgxTCMekLaiy2uETcZ9DBhZk9U8ciKUHeQZmH+SOPxyLSqTeL1EP9k/jO+OxIiyXnTxcm3ZGJsnEWn9x/T/7snqXkElFtYqBoEgAViJExoCFOH4y7XxMM3o+dBJSMzX5j7SMVSk2R41vITWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524054; c=relaxed/simple;
	bh=egXNSArxmifD0d1+HC2SRs4++zil4J0Ar3ohlCyBw8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OLFHVkYs5emoxe/xyXbB9tDbx7erg53j17WJs6sBsLkFHZRjrLk/9+RZbecyZsXjT5mDaW2+ft9pwPMJep5Ljv8XT4ZHecCYcEQUWoMkb+Y1BGQzaW4i6wYE9A/bBxmnI9ljk67cbF9v+xbYLk9BrkEwo2h0F0DCmAwqX9noga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6k2jwoj; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783524047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HURSYDykY8k1L24raC+Jwe3BrV0VQrzse+Bwrd/cOZI=;
	b=P6k2jwojHxI51JIUnvnH5jB87KTgaJ0kqslqgI1yMarcFZUpLILtkfomdMzA+6DeHSdP4c
	i9/39LuriH5iMvEHcQDjNCqA3ENAYHR6NSXkWXkb8Tt971YOWjOlb4SE+3AzSY5ElCsdn/
	BL8z6n5ucrQpC7AGHKPKbc14j8f45tM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-vDRzEdaNORW7ILXOiYMtLQ-1; Wed,
 08 Jul 2026 11:20:42 -0400
X-MC-Unique: vDRzEdaNORW7ILXOiYMtLQ-1
X-Mimecast-MFC-AGG-ID: vDRzEdaNORW7ILXOiYMtLQ_1783524042
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F1D8195604D;
	Wed,  8 Jul 2026 15:20:41 +0000 (UTC)
Received: from localhost (unknown [10.44.33.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B25A81955F7B;
	Wed,  8 Jul 2026 15:20:40 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-erofs@lists.ozlabs.org,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] erofs: add ioctl to retrieve the backing source
 file descriptor
In-Reply-To: <CALCETrVE0g-qKC079K4Ch=26VH6R+q1tXVU7HiN_Og9o1zzpow@mail.gmail.com>
	(Andy Lutomirski's message of "Wed, 8 Jul 2026 07:55:25 -0700")
References: <20260708093446.3370200-1-gscrivan@redhat.com>
	<20260708093446.3370200-3-gscrivan@redhat.com>
	<CALCETrVE0g-qKC079K4Ch=26VH6R+q1tXVU7HiN_Og9o1zzpow@mail.gmail.com>
Date: Wed, 08 Jul 2026 17:20:39 +0200
Message-ID: <87se5t7bjs.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6796-lists,linux-api=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amacapital.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81F9F728007

Andy Lutomirski <luto@amacapital.net> writes:

> On Wed, Jul 8, 2026 at 2:36=E2=80=AFAM Giuseppe Scrivano <gscrivan@redhat=
.com> wrote:
>>
>> Add EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor to the
>> backing image file for file-backed erofs mounts.
>
> What=E2=80=99s the use case?

the use case is to reuse EROFS mounts across multiple composefs mounts
without needing a user space daemon to keep the fd alive.  The advantage
is that we can share the same superblock across multiple overlay mounts,
instead of limiting the sharing to the same backing file.

> In any event, this seems to have potential security and API-oddity implic=
ations.
>
> 1. That capable(CAP_SYS_ADMIN) seems critical =E2=80=94 otherwise a task =
that
> is admin in a userns can get an fd to a backing file *outside* its
> container or to an otherwise inaccessible file.  It at least needs a
> comment IMO.

thanks, I'll add that.

> 2.  This series appears to fully round-trip the struct file. That
> means that f_cred and mode are preserved. This seems strange and may
> have all kinds of accidental effects. For mode in parallel, if the
> program that mounts the backing store opened it for write, then this
> API gives a writable fd, which seems like an odd choice for a
> filesystem that literally has read only in the name.
> The OVL variant has these issues to a lesser extent due to the fact
> that it returns an O_PATH fd instead of an actual open file.

I didn't think much of the file mode as I assumed requiring
CAP_SYS_ADMIN was enough.  I'll change the file mode to O_RDONLY and use
current_cred() to open it.  Would that be enough?

Thanks,
Giuseppe


