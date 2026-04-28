Return-Path: <linux-api+bounces-6214-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML//C0548GlgTwEAu9opvQ
	(envelope-from <linux-api+bounces-6214-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 11:05:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49A480DD1
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 11:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6F4D30371D2
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85BF3DA5B6;
	Tue, 28 Apr 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Q94D6b"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0D3D9DDE;
	Tue, 28 Apr 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366526; cv=none; b=OwYtnFC0XJLTPG7l/axj7+9E9GrP/oB0zML3isM9jHtypHhIZCoE7gJBL+dCaV/bvY/Gs0N3LZnNJrFb9dYCMn/DfONglqxl7Vml4EMzhjgiZ0L0QtFkCpRZ7at+GWjXzf33PPSQg/jMmL0Oc9FVDHI1yr5FiT26R4kvJMEbBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366526; c=relaxed/simple;
	bh=yNHjOgj0lHYbRohpDEFZC+8Hn3fGX3Sp9ArYLyuvzj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDRU+yfF+NBkwT+BCh3AMc9TuyUfGcfQzmLkmnANdg6cRzEUxwLsG66M+3X2RYd50fp+pTGmO6tvkpjpDs/ic2ibt3Lvfzxw39XquJS6sNt7vMrm79NV0C8aqnhT4wcDDzezkmp0Go5iARrwtAsRXb7LAs0zWdSGngi5307WYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Q94D6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74246C2BCB5;
	Tue, 28 Apr 2026 08:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777366526;
	bh=yNHjOgj0lHYbRohpDEFZC+8Hn3fGX3Sp9ArYLyuvzj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7Q94D6bcmzAY7l3bw7ZxQq1YiLwkR9zbSrwN/XaH3a3+/rgFcPETePHwPfC/K3Nx
	 ObDjANW77xQ5wVR0FiYdt27AIiOVVVBBM/g8AiQxUx3EERJUub+whwBRLdb8eaC0QX
	 1CQfDvM1eEliP1Hu7wsBK+SsRmhzDNPKpLo0CHYT9Ei9zdDrVvLVXYG45P0VlLHVQE
	 8HN5YqRi1cXOki0HS7C3pvLF7RIe1YmbKWGnJ7eSPLHwc+9+d/cwkxjiUEhYEAc3cj
	 UXUwVR6KcbWc1DNiyZsE9veE6+n40xUvfGKusx6iPjwhA7xsNUVy2jWY23GVzSYWIi
	 1Uxxb8PBY4FEA==
Date: Tue, 28 Apr 2026 10:55:17 +0200
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
Message-ID: <20260428-zoodirektor-latten-e412db97141d@brauner>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh>
 <20260427-rudel-gipsabdruck-a7884db4ecea@brauner>
 <CAGudoHFLSHhDZoC6maLsn234dMQVnG4ZbpKXoVrueGujArNF-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFLSHhDZoC6maLsn234dMQVnG4ZbpKXoVrueGujArNF-A@mail.gmail.com>
X-Rspamd-Queue-Id: CB49A480DD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6214-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 06:30:42PM +0200, Mateusz Guzik wrote:
> On Mon, Apr 27, 2026 at 5:14 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > Things proceed to handle_truncate:
> > >       int error = get_write_access(inode);
> > >       if (error)
> > >               return error;
> > >
> > >       error = security_file_truncate(filp);
> > >       if (!error) {
> > >               error = do_truncate(idmap, path->dentry, 0,
> > >                                   ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> > >                                   filp);
> > >       }
> > >
> > > I'm going to ignore the LSM situation and do_truncate failure modes in this one.
> > >
> > > AFAICS nothing prevents the same user from racing against file creation to
> > > execve it, which starts with exe_file_deny_write_access. Should the
> > > other thread win the race, get_write_access will fail and the WARN_ON
> > > splat will be generated. That is definitely a problem.
> >
> > That can't happen:
> >
> > static inline int get_write_access(struct inode *inode)
> > {
> >         return atomic_inc_unless_negative(&inode->i_writecount) ? 0 : -ETXTBSY;
> > }
> >
> > and the check is:
> >
> > error = handle_truncate(idmap, file);
> > if (unlikely(error > 0)) {
> >
> > This was a catch all for broken LSM hook or ->open() instance.
> >
> 
> So with this prog:
> #include <fcntl.h>
> 
> int main(void)
> {
>     open("test", O_TRUNC);
> }
> 
> I verified writecount is 0 on entry to handle_truncate like so:
> 
> bpftrace -e 'kprobe:security_file_truncate { @[comm, (int64)((struct
> file *)arg0)->f_path.dentry->d_inode->i_writecount.counter] = count();
> }'
> 
> @[a.out, 1]: 1
> 
> i.e., get_write_access in handle_truncate transitioned the count 0 -> 1
> 
> but then what prevents the following race:
> 
> CPU0                    CPU1
> open("test")            execve("test")
>   handle_truncate         do_open_execat
>                             exe_file_deny_write_access # should
> succeed as count is 0?
>   get_write_access # should fail as the count is now -1?

I'm not arguing that get_write_access() cannot fail. I'm arguing that it
cannot hit that WARN_ON() as you said above because get_write_access()
returns either 0 or -ETXTBUSY.

