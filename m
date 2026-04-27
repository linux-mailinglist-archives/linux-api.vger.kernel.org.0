Return-Path: <linux-api+bounces-6205-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ii4IlyA72moBwEAu9opvQ
	(envelope-from <linux-api+bounces-6205-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 17:27:24 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79954475289
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 17:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C45B30C28A3
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F46331A53;
	Mon, 27 Apr 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnHS8Oal"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA3330666;
	Mon, 27 Apr 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302866; cv=none; b=XWD0ogx0D2maFpc+Nz2t5gZSEcMfb6SzC1CpBmt+PWoYyIr0ytPcaK/kKre3J4TNO/0Eucn3iwXqS/HvzfYdcCvnHzN/vU7FCiztr6U4asKfvmOEsMxhZI5VDE5/utncCnfMVZ1YM8vudky+BK7hSDytLzcb1YOBK/I7aEbUTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302866; c=relaxed/simple;
	bh=09nu0uoPRJgoIgaxQtajrJcBdSLuPwWjML2SaFlroRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4pvjeJTkf2+LzkjcJSF/W8kyNTey9ZbRn+euXThJeBbhqdOTn7XpV74tqAyINPqyFkYJUzZzLYXLS+H6SBTJKWgO6GaByU9u3ULqBV97PSws/LyM1/1nkIHf5Lgb4wpsgBZAvR+MRHYjylcftSomK9i002PKba2zcxBbkbZyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnHS8Oal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCFBC19425;
	Mon, 27 Apr 2026 15:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302866;
	bh=09nu0uoPRJgoIgaxQtajrJcBdSLuPwWjML2SaFlroRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnHS8OallO7vJ8QaAY/UE3xCjHsCLKXHzLvgDvaltM2YcF3vYmlFwviFvRkVwtNo7
	 EZQjhTQDlTo1u1sOtKKRr1/EUzDaSaJX4wlLT7Vh5JuYjRHOOsGzngAmU3XNNNrwyf
	 FQqTzDqIgAVarUD0pTHZWM8ZEWPjRdtALirz3Ns8Gr2v1364kTjdybdKApwlIsM7kc
	 GbDfIeY4xqdgBIy7+vioT7RoES4HxKdxpyKvImzG7e12RGM8Pq2HmSf7CUoQhvQH29
	 2kJiyEoAcu+XDfoy9bejM6kb72a3gI8gx5elD/a/AiUti+ALLXf0meUPZyqwHHa24B
	 fvSNpem1fL2Lg==
Date: Mon, 27 Apr 2026 17:14:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
Message-ID: <20260427-rudel-gipsabdruck-a7884db4ecea@brauner>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh>
X-Rspamd-Queue-Id: 79954475289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6205-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,arndb.de,zytor.com,suse.cz,infradead.org,linutronix.de,efficios.com,cyphar.com,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

> Things proceed to handle_truncate:
> 	int error = get_write_access(inode);
> 	if (error)
> 		return error;
> 
> 	error = security_file_truncate(filp);
> 	if (!error) {
> 		error = do_truncate(idmap, path->dentry, 0,
> 				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> 				    filp);
> 	}
> 
> I'm going to ignore the LSM situation and do_truncate failure modes in this one.
> 
> AFAICS nothing prevents the same user from racing against file creation to
> execve it, which starts with exe_file_deny_write_access. Should the
> other thread win the race, get_write_access will fail and the WARN_ON
> splat will be generated. That is definitely a problem.

That can't happen:

static inline int get_write_access(struct inode *inode)
{
        return atomic_inc_unless_negative(&inode->i_writecount) ? 0 : -ETXTBSY;
}

and the check is:

error = handle_truncate(idmap, file);
if (unlikely(error > 0)) {

This was a catch all for broken LSM hook or ->open() instance.


