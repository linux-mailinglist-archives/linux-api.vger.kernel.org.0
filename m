Return-Path: <linux-api+bounces-6071-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBpRDb/F1mnNIAgAu9opvQ
	(envelope-from <linux-api+bounces-6071-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Apr 2026 23:16:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD23C3FF2
	for <lists+linux-api@lfdr.de>; Wed, 08 Apr 2026 23:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71A6D30293D9
	for <lists+linux-api@lfdr.de>; Wed,  8 Apr 2026 21:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2D3382C7;
	Wed,  8 Apr 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IU6NxKRV"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B712EA498
	for <linux-api@vger.kernel.org>; Wed,  8 Apr 2026 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683003; cv=none; b=duT1M0elh7Yn5/cYmHmWXDrVO8InQiKDafatWLQ1iOTpdw6EMnQL74377D25WInEMmPwGO8fhkbnMwpsPMGN0z6tRtotaPSeCwBEkPHrt3fSIchAlM+SLBX06d7Pa3cbaiDqx0rnTTobPsFB4U5mAiq+Q83MGSGsyhtlUXX1JkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683003; c=relaxed/simple;
	bh=wogyNksPaz4ryp0RugIpi5UO26RMp310V+hNWhI5zDw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oANTI8Zu7S3xcmnHe+fwphxGwoBGiD8nbj1arbttyPVYrmSiCByTB3WAbVDd1Ws3/dq0n3rzaNvZxSTMdwfvn1xVQCQARMopeYWIiDebvx2fncyQCNGnuCWsMl2ZzIYpw8jRqwAGIEw8BWJAsSwCJxX+x7NGm9s26T9/IB/S/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IU6NxKRV; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 36c2f440-3390-11f1-89e1-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 36c2f440-3390-11f1-89e1-00505699b430;
	Wed, 08 Apr 2026 23:16:31 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 36c13dab-3390-11f1-83d7-00505699891e;
	Wed, 08 Apr 2026 23:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=yiPrrBk1tIJoqTIC6xlzWyTp2YZZ0OR8oJIwHHuUeV4=;
	b=IU6NxKRVLiKHgUr5HAOAeij7th9cqSJbhU/hGDDdz1rsByPtIrjMWlGnR+dhTw6YQRWX20+uFCpou
	 onq8syVKGSJ1nFF38H7vDQ6ZRixrXHaIwl2yaYaxGJV2YAqjj0lKMRYKpB5GvhZqn1tiFy6XMi7sAi
	 H6jAzHIxUQEQRJ1jI82OI4BkSF6B5URuSjTocUtFp/csF42Kw6R0wZqIGXFGI5giTWjshcqm05L1kZ
	 86oRlqGqI4av9AXPwTNjwIBpVbS6ZhxEemJ4Od0fSDJ2Y9cBdkOB6bXoUHY+z6ObdhqCMzfyakeqQR
	 mRcj+JewdsOMQ5EcNtZd3WuQ9fofQGQ==
X-KPN-MID: 33|+GG5gO2LqBpR/XfkFBFq91xWwLYuHDKzdgbiWTF3SXC5hG+82ZAwH64E4T7yHhL
 deoVCzukijLf7F9fx8LQv7CsroPhsKnEQSzeSAORvBVA=
X-CMASSUN: 33|5AIjK4E1/s8sF2lsphUdfCPcWC69Qniw+3i6j11SDx1J+v1lOeP96UdzxcExwjI
 I5HrFNFOtuaJHjZygIbIqDA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 36b59fed-3390-11f1-b8d7-005056995d6c;
	Wed, 08 Apr 2026 23:16:31 +0200 (CEST)
Date: Wed, 8 Apr 2026 23:16:31 +0200 (CEST)
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
Message-ID: <1333067272.1649333.1775682991132@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAGudoHE-zSfiL2aVf41UHOtMsE53gCqLpVoy-NxoB8HeXtdgEA@mail.gmail.com>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
 <1632825771.784338.1775039101736@kpc.webmail.kpnmail.nl>
 <CAGudoHE-zSfiL2aVf41UHOtMsE53gCqLpVoy-NxoB8HeXtdgEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6071-lists,linux-api=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kpc.webmail.kpnmail.nl:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9FD23C3FF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Op 07-04-2026 11:00 CEST schreef Mateusz Guzik <mjguzik@gmail.com>:
>=20
> =20
> On Wed, Apr 1, 2026 at 12:25=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.n=
l> wrote:
> >
> >
> > > Op 01-04-2026 06:19 CEST schreef Mateusz Guzik <mjguzik@gmail.com>:
> > >
> > >
> > > On Tue, Mar 31, 2026 at 07:19:58PM +0200, Jori Koolstra wrote:
> > > > @@ -5286,7 +5290,25 @@ int filename_mkdirat(int dfd, struct filenam=
e *name, umode_t mode)
> > > >             lookup_flags |=3D LOOKUP_REVAL;
> > > >             goto retry;
> > > >     }
> > > > +
> > > > +   if (!error && (flags & MKDIRAT_FD_NEED_FD)) {
> > > > +           struct path new_path =3D { .mnt =3D path.mnt, .dentry =
=3D dentry };
> > > > +           error =3D FD_ADD(0, dentry_open(&new_path, O_DIRECTORY,=
 current_cred()));
> > > > +   }
> > > > +   end_creating_path(&path, dentry);
> > > >     return error;
> > >
> > >
> > > You can't do it like this. Should it turn out no fd can be allocated,
> > > the entire thing is going to error out while keeping the newly create=
d
> > > directory behind. You need to allocate the fd first, then do the hard
> > > work, and only then fd_install and or free the fd. The FD_ADD machine=
ry
> > > can probably still be used provided proper wrapping of the real new
> > > mkdir.
> >
> > But isn't this exactly what happens in open(O_CREAT) too? Eventually we
> > call
> >                 error =3D dir_inode->i_op->create(idmap, dir_inode, den=
try,
> >                                                 mode, open_flag & O_EXC=
L);
> >
> > and only then do we assign and install the fd. AFAIK there is no cleanu=
p
> > happening there either if the FD_ADD step fails. You will just have a
> > regular file and no descriptor. But I would have to test this to be sur=
e.
> >
>=20
> FD_ADD(how->flags, do_file_open(dfd, name, &op)) means fd itself will
> be allocated upfront and only then file creation will happen and which
> is what I'm saying is how it should be done. With your patch the
> directory is created first and the possibly failing fd allocation
> happens later.

Err, you're right. I understand what you mean now. That does need to be fix=
ed.
I misremembered how FD_ADD works. I'll get back to this in the weekend.

> > > Trying to handle this in open() is a no-go. openat2 is rather
> > > problematic.
> >
> > I don't think that is necessarily true. It turned out O_CREAT | O_DIREC=
TORY
> > was bugged for a very long time. Christian Brauner fixed it eventually,=
 and
> > that combination now returns EINVAL. But I think there is nothing reall=
y
> > stopping us from implementing that combination in the expected way, apa=
rt
> > from whatever reasons there were for not allowing this in the first pla=
ce,
> > which I don't know about (maybe mixing semantics?)
> >
>=20
> I am not saying it's impossible. I am saying mkdir was always a
> separate codepath and in order to change that you would need to add a
> branchfest to open. I don't see any reason to go that route.

That's a fair point. But there's also upsides like Aleksa has mentioned.
I'm not very opinionated on the matter, especially since I don't know why
those paths were ever separated.

Thanks,
Jori.

