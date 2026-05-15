Return-Path: <linux-api+bounces-6332-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDanHkEBB2qVqgIAu9opvQ
	(envelope-from <linux-api+bounces-6332-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 13:19:29 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD754E487
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81332311376E
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5B46AF20;
	Fri, 15 May 2026 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="W8jygT0V"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC446AECD
	for <linux-api@vger.kernel.org>; Fri, 15 May 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842532; cv=none; b=CR/Xy9uu75m26O64LLNi/4vR8QkjqDGs2eKVcLANwyDq+DIUoLZFr1180MrpRmPqzMiXYfcnMnHxZbux7sJPcqAkSB8W9D/+TdWH1hHDFE5VydghDdwfWoQl91MdWtRelbG51R7Z4qInm6XbSMjRCB5lhjkZJZ6glvt2wGjgmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842532; c=relaxed/simple;
	bh=RDSYGP4AvpjXQLhaeYGRAjuyHmsib3J+SU/ffwyYekE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=I+mjD6zjmlVX9E/0noKm50CTklVZS7fq7c8b6MBM8QEHVp4GlYxhxJ5pUZM+38gONJF/a/oFxEdIqCBJ+botKFZ6U7p7bOAwDhEdivPqyh91YS0r9DzgqLVVxx1yZnqPkFV1BHWMFUIC4a8z2ey41cN0p1lIGaht5wNEJe0SwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=W8jygT0V; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 92c2aca4-504c-11f1-89eb-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 92c2aca4-504c-11f1-89eb-00505699b430;
	Fri, 15 May 2026 12:55:23 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 92c27477-504c-11f1-b5d3-0050569981f5;
	Fri, 15 May 2026 12:55:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=/JOazQEzkSHnQFRbJg08Gb3iIdpZS7p0zK2LrD+/fNA=;
	b=W8jygT0VOGQJhPIywrwIqg7mg6qC5wOIGHs7CORljSPLlJL/RSVNN37JEJfwmG5kyVQEY3m9d/eLO
	 JdqdsWwj0jwKTdJNcwNjaEdUVJ0+ajsI6a+7gNjFHlwr8ztVkZ2fpaEZbJmduoX5qjOdvLTBqzn/C3
	 BsL0TB8Vb2s3YFzyRm2WhHzXyMnOXNhRv/By5gEBgzANbWcpatFor9rRoK8xvKrboVzhJnX+GTpdbi
	 uCy4/OOT3UYTuyBmlJZEXvcXbShY6EG6UNXbIbvWty0sEHvVjiEA2ILr/si6Xom+x04eLlMvYs4Jya
	 egBPmBirmx8ew9pvFVngpeMhVTFlFFA==
X-KPN-MID: 33|Qu6aNKuJOy6/p6obf5ryyPtMMwCNlZSo4nk9tfQC5ZZV1+IOrG2CxhgCwRD3crQ
 yNvNe0kGglxQNXuOEL7+DMu86etwnmxQ+ihyHh8puBTQ=
X-CMASSUN: 33|stHwS2isPr0foVCBjTVHWPUkcENvGSlQZIklcPtZIela4wT+O2X/LzrmvBCHlhq
 PglwiqUYKvdeYH/ZgEhGByg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 92b54fc8-504c-11f1-b8d7-005056995d6c;
	Fri, 15 May 2026 12:55:23 +0200 (CEST)
Date: Fri, 15 May 2026 12:55:23 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Weißschuh <thomas.weissschuh@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	cmirabil@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org
Message-ID: <1805140959.1362290.1778842523425@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260511-hochdekoriert-neoliberale-f7a2922bc57c@brauner>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
 <1600596489.77018.1777916475931@kpc.webmail.kpnmail.nl>
 <20260511-hochdekoriert-neoliberale-f7a2922bc57c@brauner>
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns
 an O_DIRECTORY fd
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: F1DD754E487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6332-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:dkim,kpc.webmail.kpnmail.nl:mid]
X-Rspamd-Action: no action

Sorry for the double email, this keyboard is so finicky, I really need to fix it.

> Op 11-05-2026 14:00 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> mkdirat2() is objectively the worse api. It forces userspace to use a
> separate system call without any reason whatsoever. If you can to
> O_CREAT you should also be able to to O_DIRECTORY in the same system
> call. If we support O_DIRECTORY | O_CREAT we get all the lookup
> restriction niceties RESOLVE_* for free. Plus, it is supportable both in
> openat() and openat2() because I made that combo return an errno.

I don't disagree. I know that some of the UAPI feature requests are not fully
flashed out, but at least it gives a basis to get the discussion going.

In fact I already have a O_DIRECTORY | O_CREAT patch that at least passes
the initial tests. However, I need to sit on it a little bit to think whether
I am not leaving something out. Also, I understand why vfs_create() wasn't used
in the O_CREAT path, for instance because you cannot just make use of may_create_dentry()
there. But now that we are going to string another path through lookup_open() it
would be great if we could reuse some of the logic from vfs_create() and vfs_mkdir().

Perhaps we could move may_create_dentry() out of the vfs_* calls and let the caller
take care of that. Then again, this is the pattern for all those calls. You could also
just accept some redundancies with may_o_create(), or have something like
static vfs_mkdir/create_common() functions.

There are also some minor things. If i_op->mkdir is missing this is an EPERM, but with
i_op->create it is EACCESS (and suggesting ENOSYS). Should this not be a consistent error
code? I also wonder whether there is a nicer way to handle error being returned from
vfs_mkdir et al. If I am reading

	if (!error) {
		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
				   dentry, mode, &delegated_inode);
		if (IS_ERR(dentry))
			error = PTR_ERR(dentry);
	}
	end_creating_path(&path, dentry);

it feels like there is a missing return inside the if (IS_ERR(dentry)) block, and I
have to go several function deep to see that end_creating_path correctly deals with
error values being passed instead of a dentry. Then again, probably not worth the
churn...

> 
> UAPI design often is a nasty mix of performance (context switches),
> separation of concerns and privileges, tastefulness, and compromises you
> never thought or wanted to make.
> 

Yes, thanks for suggestion this back at FOSDEM. It is quite fun, and lots
to learn :)

> 
> And during LSFMM the VFS maintains all agreed to proceed with
> O_DIRECTORY | O_CREAT.

Ah good, I didn't know that. I haven't build up the street cred to attend,
maybe next time :)

Thanks,
Jori.

