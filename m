Return-Path: <linux-api+bounces-6053-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIOxEN30zGkFYgYAu9opvQ
	(envelope-from <linux-api+bounces-6053-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Apr 2026 12:35:09 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D537896C
	for <lists+linux-api@lfdr.de>; Wed, 01 Apr 2026 12:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A941312AEB9
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2026 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B61C3EF0B4;
	Wed,  1 Apr 2026 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="a6qO4MHZ"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B503EF0B0
	for <linux-api@vger.kernel.org>; Wed,  1 Apr 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039107; cv=none; b=kCIUap8gtkLC/kFQWFTrEltG31TEvjd7j40EBsKkdapQm/kBDkD1y2p/2AgTFX3HgP+Y1FuMxegGYaMHyNoTzYxzdSt+C7OvjhDatBcw/oZ1nbyELE3mke50N8jxzO0fzukd9OXxOMQWH0us2Fxr9+dFUQR9EwYRk+xKx03klA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039107; c=relaxed/simple;
	bh=1PhhPy9OLPG43IIKwPHI4OsPfzGw6hCb/+7/nAJAntE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ev8iAs7XZT6raHRTawb+wztB8OELTYBqPlp4lSLBwCCOP7KplAQMVv2dqjV1QSQJugSVzQuqPpAb8+UQJGanlR9MYofhkCjHLcWxZOecOMG0YwIgav6KpEVCIm8eHdpKEsY/MfPavwFyFQCUxwuGWeprF64L0xzDClDoerxoyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=a6qO4MHZ; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 0ac64d60-2db5-11f1-89dd-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0ac64d60-2db5-11f1-89dd-00505699b430;
	Wed, 01 Apr 2026 12:25:01 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 0ac5850b-2db5-11f1-80ef-00505699693e;
	Wed, 01 Apr 2026 12:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=jV5KSXw2jHvn4aoi8mrtNBU5BcgGNh7rEhT8JECQk5Y=;
	b=a6qO4MHZkOD9egL4G0r7uP1lFQGRCZSA8oNzqns0eLyxX4flP0Gk2j4gOiHLs/tmBv2Kd7RFerLNl
	 OhpiSG8Zc9qzXwJTeIuYvgDt053SmxFAFns6Ct3tpJN5T+VW1QsOlTfvL8sNCdpHsLe3mzh/8ZqrO1
	 lHhOYzxKVyS4V4kjrXtOTzmMzS9YMOs0lUQ6O+V75DUVfTZZ9rR86M7J4pv5h+fEsumrw5fRuGYIrt
	 ap2IU0UFrM6Zb6lvVDMXmTB2MgTDHWEIXmpEAJGxBDWyzvh31tjKM/RiIlKhwo5ij2FjMWVNq+pMFR
	 pk7MmhCaSBRpCGje3kz6i913vdRsH2Q==
X-KPN-MID: 33|Oj+5U07RzBEqkZFJugoE73tcngd7Ls5CXUvAE+Base6KZ8QmFg3KEK76LAtUktp
 srIIgs565J+N/0RTUuHavv003kWuwYnA4RDIflmQ+eLs=
X-CMASSUN: 33|ieEVXN0BevOIstyf4njgr5TcqU1ao57nkzMi1KMpYMKT4zZGGyaQonHcVkH4Vjy
 txWvmVkBP+O1XB2ISP5/Q4w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 0ab8990e-2db5-11f1-94b1-00505699eff2;
	Wed, 01 Apr 2026 12:25:01 +0200 (CEST)
Date: Wed, 1 Apr 2026 12:25:01 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	cmirabil@redhat.com,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Message-ID: <1632825771.784338.1775039101736@kpc.webmail.kpnmail.nl>
In-Reply-To: <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6053-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:dkim,kpc.webmail.kpnmail.nl:mid]
X-Rspamd-Queue-Id: 9F0D537896C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 01-04-2026 06:19 CEST schreef Mateusz Guzik <mjguzik@gmail.com>:
> 
>  
> On Tue, Mar 31, 2026 at 07:19:58PM +0200, Jori Koolstra wrote:
> > @@ -5286,7 +5290,25 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
> >  		lookup_flags |= LOOKUP_REVAL;
> >  		goto retry;
> >  	}
> > +
> > +	if (!error && (flags & MKDIRAT_FD_NEED_FD)) {
> > +		struct path new_path = { .mnt = path.mnt, .dentry = dentry };
> > +		error = FD_ADD(0, dentry_open(&new_path, O_DIRECTORY, current_cred()));
> > +	}
> > +	end_creating_path(&path, dentry);
> >  	return error;
> 
> 
> You can't do it like this. Should it turn out no fd can be allocated,
> the entire thing is going to error out while keeping the newly created
> directory behind. You need to allocate the fd first, then do the hard
> work, and only then fd_install and or free the fd. The FD_ADD machinery
> can probably still be used provided proper wrapping of the real new
> mkdir.

But isn't this exactly what happens in open(O_CREAT) too? Eventually we
call
		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
						mode, open_flag & O_EXCL);

and only then do we assign and install the fd. AFAIK there is no cleanup
happening there either if the FD_ADD step fails. You will just have a
regular file and no descriptor. But I would have to test this to be sure.

> 
> On top of that similarly to what other people mentioned the new syscall
> will definitely want to support O_CLOEXEC and probably other flags down
> the line.
> 

I agree, and perhaps O_PATH too. Maybe just all open flags relevant to
directories?

> Trying to handle this in open() is a no-go. openat2 is rather
> problematic.

I don't think that is necessarily true. It turned out O_CREAT | O_DIRECTORY
was bugged for a very long time. Christian Brauner fixed it eventually, and
that combination now returns EINVAL. But I think there is nothing really
stopping us from implementing that combination in the expected way, apart
from whatever reasons there were for not allowing this in the first place,
which I don't know about (maybe mixing semantics?)

> 
> I tend to agree mkdirat_fd is not a good name for the syscall either,
> but I don't have a suggestion I'm happy with. I think least bad name
> would follow the existing stuff and be mkdirat2 or similar.
> 
> The routine would have to start with validating the passed O_ flags, for
> now only allowing O_CLOEXEC and EINVAL-ing otherwise.

Thanks,
Jori

