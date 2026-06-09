Return-Path: <linux-api+bounces-6586-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xo1EIuatJ2r90QIAu9opvQ
	(envelope-from <linux-api+bounces-6586-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 08:08:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6565C9EB
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 08:08:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OGjCkoi1;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6586-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6586-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BB233045B44
	for <lists+linux-api@lfdr.de>; Tue,  9 Jun 2026 06:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F873D1AA6;
	Tue,  9 Jun 2026 06:08:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5743CF68C
	for <linux-api@vger.kernel.org>; Tue,  9 Jun 2026 06:08:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985306; cv=none; b=pdpOLKRVU8wZRr2/P4lwDPJph3ioITBVWGC0htDcOM6CJWvoAtA97gT4vxtfFTpiJoce+ExnzWqRH6IldVFgbeVNVHES93neY0W8ZPZHuFzqe1eF1vMVvHuH6P5EwBcezEAulBHKvt6He10h1cJoN8cGCiAPxgYDZUnkR9ajr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985306; c=relaxed/simple;
	bh=zTpFxujaVIqXrqntYJQiK4/X3IRtxtcHngsZQzceJcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nyyCxlSCmP8zZj3lAlc/GKyzPWodnb9wrJJz7SL/mbGK0zo1JBVQymr0OCMwv/BKnyyH1gzC6TrW0tnQbRzUBqZZaujv7ytEzMbHco1BZ6TkJIE+HACtupDwDIJjZvT3sFKZ95BZIXiiu/kjg2uepMtKK+jnaiNZr5P82zFDtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGjCkoi1; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780985303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbOz6L7GY6LUh60QQjLA14yLmOVQNSrkAN1JuAX65lY=;
	b=OGjCkoi19/v32Ytr1d/HQQFft18xz7tiTxe10U0pI6OhQvCX5mzXD79dXyr1IMlJPuY3g+
	M7nbId0VfUqWO+PLlxTeMi49R+BFMmh3kUpgRNx9ugR2rIXIAjpdrW4xYMBnOOBHe4uCuG
	ofeXFJhZlK08sKBO/bhyH6JSmN9JyAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-CiiFh2z4PQSasqSREsKifg-1; Tue,
 09 Jun 2026 02:08:18 -0400
X-MC-Unique: CiiFh2z4PQSasqSREsKifg-1
X-Mimecast-MFC-AGG-ID: CiiFh2z4PQSasqSREsKifg_1780985295
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FD03180065C;
	Tue,  9 Jun 2026 06:08:15 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.189])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98CB719560A2;
	Tue,  9 Jun 2026 06:08:07 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,  Christian Brauner
 <brauner@kernel.org>,  Li Chen <me@linux.beauty>,  Kees Cook
 <kees@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-fsdevel@vger.kernel.org,  linux-api@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-arch@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  x86@kernel.org,  Arnd Bergmann
 <arnd@arndb.de>,  Andy Lutomirski <luto@kernel.org>,  Thomas Gleixner
 <tglx@kernel.org>,  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov
 <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,  "H. Peter
 Anvin" <hpa@zytor.com>,  Jan Kara <jack@suse.cz>,  Jonathan Corbet
 <corbet@lwn.net>,  Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
In-Reply-To: <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
	(Jann Horn's message of "Mon, 8 Jun 2026 17:02:06 +0200")
References: <20260528095235.2491226-1-me@linux.beauty>
	<vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
	<CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
Date: Tue, 09 Jun 2026 08:08:05 +0200
Message-ID: <lhubjdk1c1m.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6586-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jannh@google.com,m:mjguzik@gmail.com,m:brauner@kernel.org,m:me@linux.beauty,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.beauty,zeniv.linux.org.uk,vger.kernel.org,kvack.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sourceware.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CB6565C9EB

* Jann Horn:

>> Per the above, the primary win would stem from *NOT* messing with mm.
>
> As you write below, I think we have that with CLONE_MM? The C function
> vfork() is kind of a terrible API because of its returns-twice
> behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
> wrapped by libc in a way similar to clone() (with the child executing
> a separate handler function), or if it was used in the implementation
> of some higher-level process-spawning API, it would be a perfectly
> fine API?

No, there is still a problem with SIGTSTP handling because we cannot
atomically unmask the signal during execve.  We need to unblock SIGTSTP
before execve in the new process, but this means that it can get
suspended by SIGTSTP.  Consequently, the execve never happens and the
original process is stuck in vfork:

  posix_spawn: parent can get stuck in uninterruptible sleep if child
  receives SIGTSTP early enough
  <https://inbox.sourceware.org/libc-help/2921668c-773e-465d-9480-0abb6f979=
bf9@www.fastmail.com/>

More on the low-level side, it's difficult to make sure that execve gets
a consistent snapshot of the environ vector.  Both vfork and execve need
to be async-signal-safe.  Any locking or memory allocation (except for
the stack =E2=80=A6) persists in the original process after vfork returns. =
 The
environ vector can be large, so making a copy on the stack is not ideal.
It's even harder for getenv/setenv/unsetenv implementations that use
locking instead of software transactional memory.

In general, I prefer the vfork+execve API over things like posix_spawn
because eventually, you have dependencies between the syslets, or need
control flow.  This introduces a lot of complexity.  Conceptually,
vfork+execve is much simpler, and in many ways quite safe (even mutexes
work as long as they do not need a correct TID).

Thanks,
Florian


